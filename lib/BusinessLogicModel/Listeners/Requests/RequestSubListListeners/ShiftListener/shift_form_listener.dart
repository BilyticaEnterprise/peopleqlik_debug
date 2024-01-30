import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/loader_class.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:provider/provider.dart';

import '../../../../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/OvertimeFormPages/UiWidgets/ErrorWidgets/overtime_error_bottom_sheet.dart';
import '../../../../../UiPages/Reuse_Widgets/BottomSheetUi/bottom_sheet_ui.dart';
import '../../../../../UiPages/Reuse_Widgets/DatePickText/date_picker_text_style_1.dart';
import '../../../../../UiPages/Reuse_Widgets/DropDowns/drop_down_header.dart';
import '../../../../../UiPages/Reuse_Widgets/DropDowns/drop_down_multiple.dart';
import '../../../../../src/get_random_number.dart';
import '../../../../../src/language_codes.dart';
import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../Enums/apistatus_enum.dart';
import '../../../../Models/TimeOffAndEnCashModel/shift_form_mapper.dart';
import '../../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class ShiftFormListener extends GetChangeNotifier with GetLoader
{
  MultiDropDownDataController? listOfDays;
  DropDownDataController? regularShiftTypeDropDown;
  DropDownDataController? ramdaanShiftTypeDropDown;
  DateController? effectiveDateController;
  late int refreshKeyNumber;
  ApiStatus apiStatus = ApiStatus.nothing;
  ShiftFormMapper? shiftFormMapper;
  late SettingsModelListener _settingsModelListener;

  ShiftFormListener(BuildContext context)
  {
    createModelForForm(context);
  }
  createModelForForm(BuildContext context)
  {
    shiftFormMapper = ShiftFormMapper();
    apiStatus = ApiStatus.started;
    notifyListeners();

    refreshKeyNumber = getRandomNumber();

    _settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    listOfDays = MultiDropDownDataController(ShiftFormEnums.listDays, _settingsModelListener.settingsResultSet?.weekDayList?.map((e) => e.dayName).toList()??[],);
    regularShiftTypeDropDown = DropDownDataController(ShiftFormEnums.regularShift, _settingsModelListener.settingsResultSet?.regularShiftlist?.map((e) => e.shiftTitle).toList()??[]);
    ramdaanShiftTypeDropDown = DropDownDataController(ShiftFormEnums.ramdaanShift, _settingsModelListener.settingsResultSet?.ramadanShiftlist?.map((e) => e.shiftTitle).toList()??[]);
    effectiveDateController = DateController(ShiftFormEnums.effectiveDate,dateCallBack);

    apiStatus = ApiStatus.done;
    notifyListeners();

  }

  void start(BuildContext context) {
    createModelForForm(context);
  }


  dropDownCallBack(SelectedDropDown selectedDropDown) {
    switch(selectedDropDown.dropDownTypeEnum)
    {
      case ShiftFormEnums.regularShift:
        shiftFormMapper?.regularShiftID = _settingsModelListener.settingsResultSet?.regularShiftlist?[selectedDropDown.index!].shiftID;
      break;
      case ShiftFormEnums.ramdaanShift:
        shiftFormMapper?.ramadanShiftID = _settingsModelListener.settingsResultSet?.ramadanShiftlist?[selectedDropDown.index!].shiftID;
        break;
      default:
        break;
    }
  }

  multiDropDownCallBack(MultiSelectedDropDown multiSelectedDropDown) {
    switch(multiSelectedDropDown.dropDownTypeEnum)
    {
      case ShiftFormEnums.listDays:
    multiSelectedDropDown.index?.forEach((element) {
      PrintLogs.printLogs('indexss $element');
    });
        shiftFormMapper?.laShiftSchedulePermenantDt = List.generate(multiSelectedDropDown.index?.length??0, (index) => LaShiftSchedulePermenantDt(permenantID: 0,weekDayID: _settingsModelListener.settingsResultSet?.weekDayList?[multiSelectedDropDown.index![index]].weekDayID));
        shiftFormMapper?.laShiftSchedulePermenantDt?.forEach((element) {
          PrintLogs.printLogs('elementsasda ${element.weekDayID} ${element.permenantID}');
        });
        break;
      default:
        break;
    }
  }

  dateCallBack(DateReturn dateReturn) {
    shiftFormMapper?.effectiveDate = GetDateFormats().getMonthFormatDay(dateReturn.value);
  }

  confirmPressed(BuildContext context)async{
    if(shiftFormMapper?.effectiveDate!=null&&shiftFormMapper?.regularShiftID!=null&&shiftFormMapper?.laShiftSchedulePermenantDt!=null&&shiftFormMapper!.laShiftSchedulePermenantDt!.isNotEmpty)
      {
        EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

        shiftFormMapper?.companyCode = employeeInfoMapper.companyCode;
        shiftFormMapper?.employeeCode = employeeInfoMapper.employeeCode;
        shiftFormMapper?.cultureID = employeeInfoMapper.cultureId;
        shiftFormMapper?.approvalStatusID = 1;
        shiftFormMapper?.createdBy = employeeInfoMapper.employeeCode;
        shiftFormMapper?.modifiedBy = employeeInfoMapper.employeeCode;
        shiftFormMapper?.createdDate = shiftFormMapper?.effectiveDate;
        shiftFormMapper?.modifiedDate = shiftFormMapper?.effectiveDate;
        PrintLogs.printLogs('shiasd ${jsonEncode(shiftFormMapper?.toJson())}');
        initLoader();
        ApiResponse apiResponse = await GetApisUrlCaller().submitShift(context,shiftFormMapper?.toJson());
        await closeLoader();
        if(apiResponse.apiStatus == ApiStatus.done)
          {
            SnackBarDesign.happySnack('${CallLanguageKeyWords.get(context, LanguageCodes.UploadedSuccessfully)}');
            Navigator.pop(context,true);
          }
        else
          {
            if(apiResponse.data!=null&&apiResponse.data.errorResultSet!=null)
            {
              ShowBottomSheet.show(
                  context,
                  height: 90,
                  body: OvertimeErrorBottomSheet(apiResponse),
                  callBack: (filterValues){

                  }
              );
            }
            else
            {
              ShowErrorMessage.show(apiResponse);
            }
          }
      }
    else
      {
        if(shiftFormMapper?.regularShiftID==null)
          {
            SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.shiftError2)??'');
          }
        else if(shiftFormMapper?.laShiftSchedulePermenantDt==null||(shiftFormMapper?.laShiftSchedulePermenantDt!=null&&shiftFormMapper!.laShiftSchedulePermenantDt!.isEmpty))
        {
          SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.shiftError3)??'');
        }
        else if(shiftFormMapper?.effectiveDate==null)
          {
            SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.shiftError1)??'');
          }
      }
  }

}
enum ShiftFormEnums
{
  employee,listDays,regularShift,ramdaanShift,effectiveDate
}