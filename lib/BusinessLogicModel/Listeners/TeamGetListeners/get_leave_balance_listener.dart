import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TeamGetListeners/team_detail_listener.dart';

import '../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../ApiCalls/ApiCallers/show_error.dart';
import '../../ApiCalls/ApiGlobalModel/api_global_model.dart';
import '../../Enums/apistatus_enum.dart';
import '../../Models/TeamModel/get_employee_leave_balance_mapper.dart';
import '../../Models/TeamModel/leave_balance_model.dart';

class GetEmployeeLeaveBalanceListener extends GetChangeNotifier
{
  ForBalanceEmployeeInfo? forBalanceEmployeeInfo;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<LeaveBalanceResultSet>? resultSet;

  GetEmployeeLeaveBalanceListener({required this.forBalanceEmployeeInfo});

  start(BuildContext context)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse? apiResponse = await GetApisUrlCaller().getEmployeeLeaveBalance(context,'?CompanyCode=${forBalanceEmployeeInfo?.companyCode}&EmployeeCode=${forBalanceEmployeeInfo?.employeeCode}');

    if(apiResponse.apiStatus == ApiStatus.done)
    {
      resultSet = apiResponse.data?.resultSet;
      apiStatus = ApiStatus.done;
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
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
}
