import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/TimeRegulationListener/MovementSlipFormListeners/movement_slip_form_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/Version1/models/TimeRegulationModels/time_regulation_monthly_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:provider/provider.dart';

import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../configs/language_codes.dart';
import '../../../../../../configs/prints_logs.dart';
import '../../../../../../utils/datePickText/date_controller.dart';
import '../../../../../../utils/snackbar_design.dart';
import '../../../../../../utils/loader_utils/loader_class.dart';
import '../../../../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import '../../../../../models/TimeRegulationModels/movement_slip_submit_mapper.dart';
import '../../../../../models/call_setting_data.dart';
import '../../../../../models/pop_with_results.dart';
import '../../../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class TimeRegulationFormListener extends GetChangeNotifier with GetLoader
{
  DateController? initialDateController;
  TimeRegulationMonthlyDataList? timeRegulationMonthlyDataList;
  DropDownDataController? typeDropDown;
  DateController? fromDateTimeController;
  DateController? toDateTimeController;
  int? selectedTypeIndex;
  DateTime? attendanceDate;
  late TextEditingController remarksController;
  FocusScopeNode? remarksNodeFocus;
  late SettingsModelListener _settingsModelListener;

  TimeRegulationFormListener(BuildContext context, this.timeRegulationMonthlyDataList)
  {
    _settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    attendanceDate = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.attendanceDate);
    initialDateController = DateController(MovementSlipType.date,dateCallBack,defaultTime: attendanceDate,receivedDate: attendanceDate);
    typeDropDown = DropDownDataController(MovementSlipType.type, List.generate(_settingsModelListener.settingsResultSet?.allStatus?.length??0, (index) => _settingsModelListener.settingsResultSet?.allStatus?[index].statusName??''));
    fromDateTimeController = DateController(MovementSlipType.fromDateTime,dateCallBack,defaultTime: GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeIn),receivedDate: GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeIn));
    toDateTimeController = DateController(MovementSlipType.toDateTime,dateCallBack,defaultTime: GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeOut),receivedDate: GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeOut));
    remarksController = TextEditingController();
    remarksNodeFocus = FocusScopeNode();
  }


  dateCallBack(DateReturn dateReturn) {
    switch(dateReturn.dateType)
    {
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
        AllStatus? allStatus = _settingsModelListener.settingsResultSet?.allStatus?[selectedTypeIndex??0];
        if(allStatus?.prefix=='MI' || allStatus?.prefix=='BI' || allStatus?.prefix=='LT')
          {
            fromDateTimeController?.enabled = true;
            toDateTimeController?.enabled = false;

            fromDateTimeController?.defaultTime = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeIn);
            fromDateTimeController?.receivedDate = null;
            toDateTimeController?.receivedDate = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeOut);
            toDateTimeController?.defaultTime = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeOut);
            notifyListeners();
            toDateTimeController?.refresh();
          }
        else if(allStatus?.prefix=='MO' || allStatus?.prefix=='BO' || allStatus?.prefix=='EO')
        {
          fromDateTimeController?.enabled = false;
          toDateTimeController?.enabled = true;

          toDateTimeController?.defaultTime = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeOut);
          toDateTimeController?.receivedDate = null;

          fromDateTimeController?.receivedDate = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeIn);
          fromDateTimeController?.defaultTime = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeIn);
          notifyListeners();
          fromDateTimeController?.refresh();
        }
        else
          {
            notifyListeners();
            toDateTimeController?.defaultTime = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeOut);
            fromDateTimeController?.defaultTime = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeIn);
            toDateTimeController?.receivedDate = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeOut);
            fromDateTimeController?.receivedDate = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeIn);
            toDateTimeController?.enabled = true;
            fromDateTimeController?.enabled = true;
            toDateTimeController?.refresh();
            fromDateTimeController?.refresh();

          }
        break;
      default:
        break;
    }
  }


  Future<void> confirmPressed(BuildContext context) async {

    if(checkDatesValidation()==true&&initialDateController?.receivedDate!=null
        &&selectedTypeIndex!=null&&remarksController.text.isNotEmpty)
    {
      EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();
      MovementSlipSubmitMapper movementSlipSubmitMapper = MovementSlipSubmitMapper(
          approvalStatusID: AppConstants.dRAFT,
          attendanceDate: GetDateFormats().getMonthFormatDay(initialDateController!.receivedDate),
          typeID: Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.allStatus?[selectedTypeIndex!].statusID,
          officePermissionTypeID: null,
          laWaiveOffRequestDt: List.generate(1, (index) => LaWaiveOffRequestDt(
            entryID: timeRegulationMonthlyDataList?.entryID,
            fileName: '',
            remarks: remarksController.text,
            employeeCode: employeeInfoMapper.employeeCode,
            companyCode: employeeInfoMapper.companyCode,
            timeIn: GetDateFormats().getMonthAndTimeFormat(fromDateTimeController!.receivedDate),
            timeOut: GetDateFormats().getMonthAndTimeFormat(toDateTimeController!.receivedDate),
          ))
      );
     // PrintLogs.printLogs('asndjasdjaks ${jsonEncode(movementSlipSubmitMapper.toJson())}');

      initLoader();
      ApiResponse apiResponse = await UseCaseGetApisUrlCaller().postMovementSlipApiCall(context, jsonEncode(movementSlipSubmitMapper.toJson()));
      await Future.delayed(const Duration(milliseconds: 100));
      await closeLoader();
      if(apiResponse.apiStatus == ApiStatus.done)
      {
        SnackBarDesign.happySnack(CallLanguageKeyWords.get(context, LanguageCodes.UploadedSuccessfully));
        Future.delayed(const Duration(milliseconds: 200),(){
          GetNavigatorStateContext.navigatorKey.currentState?.pop();
          GetNavigatorStateContext.navigatorKey.currentState?.pop(true);
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
  checkDatesValidation()
  {
    AllStatus? allStatus = _settingsModelListener.settingsResultSet?.allStatus?[selectedTypeIndex??0];
    if(allStatus?.prefix=='MI' || allStatus?.prefix=='BI' || allStatus?.prefix=='LT'&&fromDateTimeController?.receivedDate!=null)
    {
      toDateTimeController?.receivedDate = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeOut);
      return true;
    }
    else if(allStatus?.prefix=='MO' || allStatus?.prefix=='BO' || allStatus?.prefix=='EO'&&toDateTimeController?.receivedDate!=null)
    {
      fromDateTimeController?.receivedDate = GetDateFormats().getMonthDay(timeRegulationMonthlyDataList?.timeIn);
      return true;
    }
    else if(fromDateTimeController?.receivedDate!=null&&toDateTimeController?.receivedDate!=null)
    {
      return true;
    }
    else
      {
        return false;
      }
  }
}