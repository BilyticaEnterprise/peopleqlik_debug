import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/SummaryListeners/leave_calender_model_listener.dart';
import 'package:peopleqlik_debug/Version1/models/TimeOffAndEnCashModel/leave_summary_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';


class LeaveSummaryModelListener extends GetChangeNotifier
{
  List<LeaveSummaryResultSet>? leaveSummaryResultSet;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<LeaveCalendar>? leaveCalendarList;
  Future? start(BuildContext context,String? calendarCode)
  async {
    leaveSummaryResultSet = null;

    apiStatus = ApiStatus.started;
    notifyListeners();

    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getLeaveSummaryApiCall(context,'?CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}&CalendarCode=${calendarCode??'LC${DateTime.now().year}'}');
    PrintLogs.printLogs('offsadsa ${apiResponse.apiStatus}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      leaveSummaryResultSet = apiResponse.data!.resultSet;
      apiStatus = ApiStatus.done;
      Provider.of<LeaveCalenderModelListener>(context,listen: false).updateSelected(-1); /// Here we are changing selected Summary filter of panel_Options_List_view.dart which is called from SlidingUpPanels(panel_header.dart)
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      leaveSummaryResultSet = null;
      apiStatus = ApiStatus.empty;
      notifyListeners();
    }
    else
    {
      leaveSummaryResultSet = null;
      apiStatus = ApiStatus.error;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }
}

