import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/loader_class.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/show_error.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AppConstants/app_constants.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/settings_model.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:provider/provider.dart';

import '../../../../../../UiPages/Reuse_Widgets/DatePickText/date_picker_text_style_1.dart';
import '../../../../../../UiPages/Reuse_Widgets/DropDowns/drop_down_header.dart';
import '../../../../../../UiPages/Reuse_Widgets/TextFields/Listeners/text_field_controller.dart';
import '../../../../../../src/language_codes.dart';
import '../../../../../Enums/apistatus_enum.dart';
import '../../../../../Models/AuthModels/login_model.dart';
import '../../../../../Models/TimeRegulationModels/date_select_movement_slip_model.dart';
import '../../../../../Models/TimeRegulationModels/movement_slip_submit_mapper.dart';
import '../../../../../SharedPrefs/login_prefs.dart';
import '../../../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class MovementSlipFormListener extends GetChangeNotifier with GetLoader
{
  List<String>? typeList;
  String resetKey = 'resetKey';

  late FocusNode dateFocus;
  DropDownDataController? typeDropDown;
  DateController? initialDateController;
  DateController? fromDateTimeController;
  DateController? toDateTimeController;
  int? selectedTypeIndex;
  late TextEditingController remarksController;
  FocusScopeNode? remarksNodeFocus;

  ApiStatus apiStatus = ApiStatus.nothing;
  List<DateSelectResultSet>? resultSet;
  late BuildContext context;
  DateTime? minDate;

  MovementSlipFormListener(BuildContext context)
  {
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    if(int.parse(settingsModelListener.settingsResultSet?.previousHoursLimit?.settingIdOrNameValue??'0')>0)
      {
        minDate = DateTime.now().subtract(Duration(hours: int.parse(settingsModelListener.settingsResultSet?.previousHoursLimit?.settingIdOrNameValue??'0')));
      }
    else
      {
        if(settingsModelListener.settingsResultSet?.cuttofDate!=null&&settingsModelListener.settingsResultSet!.cuttofDate!.isNotEmpty)
          {
            minDate = GetDateFormats().getMonthDay(settingsModelListener.settingsResultSet!.cuttofDate!);
          }
        else
          {
            SnackBarDesign.errorSnack('Cut off date cannot be null. Server error');
          }
      }
    typeDropDown = DropDownDataController(MovementSlipType.type, List.generate(settingsModelListener.settingsResultSet?.officePermTypes?.length??0, (index) => settingsModelListener.settingsResultSet?.officePermTypes?[index].typeName??''));
    initialDateController = DateController(MovementSlipType.date,dateCallBack);
    remarksController = TextEditingController();
    remarksNodeFocus = FocusScopeNode();
    dateFocus = FocusNode();

  }

  dateCallBack(DateReturn dateReturn) {
    switch(dateReturn.dateType)
    {
      case MovementSlipType.date:
        start(context,dateReturn.value);
        break;
      case MovementSlipType.fromDateTime:
        notifyListeners();
        if(toDateTimeController?.receivedDate!=null&&fromDateTimeController?.receivedDate!=null&&fromDateTimeController!.receivedDate!.isAfter(toDateTimeController!.receivedDate!))
        {
          toDateTimeController?.defaultTime = dateReturn.value;
          toDateTimeController?.receivedDate = dateReturn.value;
          toDateTimeController?.refresh();
        }
        break;
      case MovementSlipType.toDateTime:
        notifyListeners();
        if(toDateTimeController?.receivedDate!=null&&fromDateTimeController?.receivedDate!=null&&fromDateTimeController!.receivedDate!.isAfter(toDateTimeController!.receivedDate!))
          {
            fromDateTimeController?.defaultTime = dateReturn.value;
            fromDateTimeController?.receivedDate = dateReturn.value;
            fromDateTimeController?.refresh();
          }
        break;
      default:
        break;
    }
  }

  dropDownCallBack(SelectedDropDown selectedDropDown) {
    switch(selectedDropDown.dropDownTypeEnum)
    {
      case MovementSlipType.type:
        selectedTypeIndex = selectedDropDown.index;
        break;
      default:
        break;
    }
  }
  start(BuildContext context,DateTime date)async
  {
    apiStatus = ApiStatus.started;
    notifyListeners();

    LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    if(settingsModelListener.settingsResultSet?.officePermTypes!=null&&settingsModelListener.settingsResultSet!.officePermTypes!.isNotEmpty)
    {
      ApiResponse apiResponse = await GetApisUrlCaller().getMovementSlipDataAgainstDateApiCall(context,'?AttendanceDate=${DateFormat('MM/dd/yyyy').format(date)}&EmployeeCode=${loginResultSet.headerInfo?.employeeCode}&CompCode=${loginResultSet.headerInfo?.companyCode}');
      if(apiResponse.apiStatus == ApiStatus.done)
      {
        resultSet = apiResponse.data.resultSet;
        if(resultSet?[0].canApplyforthistransaction == true)
        {
          fromDateTimeController = DateController(MovementSlipType.fromDateTime,dateCallBack,defaultTime: GetDateFormats().getMonthDay(resultSet?[0].timeIn)??DateTime(date.year,date.month,date.day));
          toDateTimeController = DateController(MovementSlipType.toDateTime,dateCallBack,defaultTime: GetDateFormats().getMonthDay(resultSet?[0].timeOut)??DateTime(date.year,date.month,date.day));
          apiStatus = ApiStatus.done;
          notifyListeners();
        }
        else
        {
          apiStatus = ApiStatus.notAllowed;
          notifyListeners();
        }
      }
      else if(apiResponse.apiStatus == ApiStatus.empty)
      {
        fromDateTimeController = DateController(MovementSlipType.fromDateTime,dateCallBack,defaultTime: DateTime(date.year,date.month,date.day));
        toDateTimeController = DateController(MovementSlipType.toDateTime,dateCallBack,defaultTime: DateTime(date.year,date.month,date.day));
        apiStatus = ApiStatus.empty;
        notifyListeners();
      }
      else
      {
        apiStatus = apiResponse.apiStatus!;
        notifyListeners();

        ShowErrorMessage.show(apiResponse);
      }
    }
    else
      {
        apiStatus = ApiStatus.error;
        notifyListeners();
      }
  }

  /// Submitting movement slip data
  Future<void> confirmPressed() async {
    if(initialDateController?.receivedDate!=null&&fromDateTimeController?.receivedDate!=null&&toDateTimeController?.receivedDate!=null
    &&selectedTypeIndex!=null&&remarksController.text.isNotEmpty)
      {
        EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();
        MovementSlipSubmitMapper movementSlipSubmitMapper = MovementSlipSubmitMapper(
          approvalStatusID: AppConstants.dRAFT,
          attendanceDate: GetDateFormats().getMonthFormatDay(initialDateController!.receivedDate),
          officePermissionTypeID: Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.officePermTypes?[selectedTypeIndex!].typeID,
          typeID: AppConstants.movementSlipTypeId,
          laWaiveOffRequestDt: List.generate(1, (index) => LaWaiveOffRequestDt(
            entryID: resultSet?[0].entryID,
            fileName: '',
            remarks: remarksController.text,
            employeeCode: employeeInfoMapper.employeeCode,
            companyCode: employeeInfoMapper.companyCode,
            timeIn: GetDateFormats().getMonthAndTimeFormat(fromDateTimeController!.receivedDate),
            timeOut: GetDateFormats().getMonthAndTimeFormat(toDateTimeController!.receivedDate),
          ))
        );
        //PrintLogs.printLogs('asndjasdjaks ${jsonEncode(movementSlipSubmitMapper.toJson())}');
        initLoader();
        ApiResponse apiResponse = await GetApisUrlCaller().postMovementSlipApiCall(context, jsonEncode(movementSlipSubmitMapper.toJson()));
        await Future.delayed(const Duration(milliseconds: 100));
        await closeLoader();
        if(apiResponse.apiStatus == ApiStatus.done)
          {
            SnackBarDesign.happySnack(CallLanguageKeyWords.get(context, LanguageCodes.UploadedSuccessfully));
            Future.delayed(const Duration(milliseconds: 200),(){
              Navigator.pop(context,true);
            });
          }
        else
          {
            ShowErrorMessage.show(apiResponse);
          }
      }
    else
      {
        if(initialDateController?.receivedDate == null)
          {
            SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.movementEr1));
          }
        else if(selectedTypeIndex == null)
        {
          SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.movementEr2));
        }
        else if(fromDateTimeController?.receivedDate == null)
        {
          SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.movementEr3));
        }
        else if(toDateTimeController?.receivedDate == null)
        {
          SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.movementEr4));
        }
        else if(remarksController.text.isEmpty)
        {
          SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.movementEr5));
        }
      }
  }
  @override
  void dispose() {
    dateFocus.dispose();
    remarksController.dispose();
    remarksNodeFocus?.dispose();
    super.dispose();
  }

  void resetAll() {
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    typeDropDown = DropDownDataController(MovementSlipType.type, List.generate(settingsModelListener.settingsResultSet?.officePermTypes?.length??0, (index) => settingsModelListener.settingsResultSet?.officePermTypes?[index].typeName??''));
    initialDateController = DateController(MovementSlipType.date,dateCallBack);
    remarksController = TextEditingController();
    remarksNodeFocus = FocusScopeNode();
    dateFocus = FocusNode();
    apiStatus = ApiStatus.nothing;
    resetKey = '${Random().nextInt(1000)+1}';
    notifyListeners();
  }

}
enum MovementSlipType
{
  date,type,fromDateTime,toDateTime
}