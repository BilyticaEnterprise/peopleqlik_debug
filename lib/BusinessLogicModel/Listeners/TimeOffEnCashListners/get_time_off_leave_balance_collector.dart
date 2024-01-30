import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/get_time_off_form_data_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/submit_time_off_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/time_off_leave_balance.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import '../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../ApiCalls/ApiCallers/show_error.dart';
import '../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';


class GetLeaveBalanceJsonModelListener extends GetChangeNotifier
{
  List<GetLeaveBalanceResultSet>? getLeaveBalanceJson;
  List<LeaveReasons>? leaveReasons;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<String>? leaveReasonList = List.empty(growable: true);
  GetLeaveBalanceResultSet? getLeaveBalanceResultSet;
  int? isFullDay;
  String optionalString = 'Select an option';

  Future? start(BuildContext context,String type,String calendarCode)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();
    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse apiResponse = await GetApisUrlCaller().getLeaveBalanceApiCall(context,'?CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}&LeaveTypeCode=$type');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      getLeaveBalanceJson = apiResponse.data!.resultSet.leaveTypes;
      leaveReasons = apiResponse.data!.resultSet.leaveReasons;
      makeReasonList(leaveReasons);

      int? index = getLeaveBalanceJson?.indexWhere((element) => element.calendarCode == calendarCode);
      if(index!=null&&index!=-1)
        {
          getLeaveBalanceResultSet = getLeaveBalanceJson![index];
        }
      checkIsFullDay(context);
      apiStatus = ApiStatus.done;
      notifyListeners();
    }
    else
    {
      apiStatus = ApiStatus.error;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }
  resetBalance()
  {
    isFullDay = null;
    getLeaveBalanceResultSet = null;
    apiStatus = ApiStatus.nothing;
    getLeaveBalanceJson = null;
    leaveReasons = null;
    notifyListeners();
  }
  void makeReasonList(List<LeaveReasons>? leaveReason)
  {
    leaveReasonList?.clear();
    leaveReasonList?.add(optionalString);
    if(leaveReasons!=null&&leaveReasons!.isNotEmpty)
      {
        for(var val in leaveReason!)
        {
          leaveReasonList?.add(val.reasonTitle!);
        }
      }
  }
  checkIsFullDay(BuildContext context)
  {
    GetLeaveFormModelListener? getLeaveFormModelListener = Provider?.of<GetLeaveFormModelListener>(context,listen: false);
    if(getLeaveFormModelListener.leaveCreateFormResultSet?.leaveType?[getLeaveFormModelListener.getSelectedIndexLeaveType].unitID == GetVariable.isTime)
      {
        Provider.of<GetLeaveFormModelListener>(context,listen: false).halfLeaveList?.clear();
        Provider.of<GetLeaveFormModelListener>(context,listen: false).halfLeaveList?.add('Select an option');
        Provider.of<GetLeaveFormModelListener>(context,listen: false).halfLeaveList?.add('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffHourly)}');
        //isFullDay = 2;
      }
    else if(getLeaveFormModelListener.leaveCreateFormResultSet?.leaveType?[getLeaveFormModelListener.getSelectedIndexLeaveType].onlyApplyForFullDay == true)
      {
        Provider.of<GetLeaveFormModelListener>(context,listen: false).halfLeaveList?.clear();
        Provider.of<GetLeaveFormModelListener>(context,listen: false).halfLeaveList?.add('Select an option');
        Provider.of<GetLeaveFormModelListener>(context,listen: false).halfLeaveList?.add('${CallLanguageKeyWords.get(context, LanguageCodes.fullDay)}');
        //isFullDay = 1;
      }
  }
  updateEitherFullDay(int check)
  {
    isFullDay = check;
    notifyListeners();
  }
}

