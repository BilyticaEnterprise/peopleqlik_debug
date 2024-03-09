import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_leave_balance.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/get_time_off_form_data_collector.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../../../../../../ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../../../../../ApiModule/domain/model/show_error.dart';
import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';


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

    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getLeaveBalanceApiCall(context,'?CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}&LeaveTypeCode=$type');
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

