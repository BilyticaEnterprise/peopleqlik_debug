import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/show_error.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_encashment_balance_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class RequestSpecialBalanceListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  List<SpecialBalanceResultSet>? specialRequestBalanceResultSet;
  Future? start(BuildContext context,String calenderCode,String leaveTypeCode)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse apiResponse = await GetApisUrlCaller().getEncashmentBalanceFormApiCall(context,'?CalendarCode=$calenderCode&LeaveTypeCode=$leaveTypeCode&CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      specialRequestBalanceResultSet = apiResponse.data!.resultSet;
      apiStatus = ApiStatus.done;
      notifyListeners();

    }
    else
    {
      apiStatus = apiResponse.apiStatus!;
      specialRequestBalanceResultSet = null;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }
  resetBalance()
  {
    apiStatus = ApiStatus.nothing;
    specialRequestBalanceResultSet = null;
    notifyListeners();
  }
}