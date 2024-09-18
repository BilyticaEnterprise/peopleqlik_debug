import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import '../../models/TeamModel/get_employee_leave_balance_mapper.dart';
import '../../models/TeamModel/leave_balance_model.dart';

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

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getEmployeeLeaveBalance(context,'?CompanyCode=${forBalanceEmployeeInfo?.companyCode}&EmployeeCode=${forBalanceEmployeeInfo?.employeeCode}');

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
