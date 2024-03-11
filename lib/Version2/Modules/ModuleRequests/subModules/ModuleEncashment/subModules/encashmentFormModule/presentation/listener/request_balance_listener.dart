import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/Version1/Models/RequestsModel/EncashmentsModels/get_request_encashment_balance_model.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class RequestEcashmentBalanceListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  List<SpecialBalanceResultSet>? specialRequestBalanceResultSet;
  Future? start(BuildContext context,String calenderCode,String leaveTypeCode)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getEncashmentBalanceFormApiCall(context,'?CalendarCode=$calenderCode&LeaveTypeCode=$leaveTypeCode&CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}');
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