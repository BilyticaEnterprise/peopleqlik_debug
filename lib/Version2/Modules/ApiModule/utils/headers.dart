import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import 'package:peopleqlik_debug/Version1/Models/AuthModels/login_model.dart';
import 'package:provider/provider.dart';

class GetHeaders
{
  getAuthHeader(BuildContext context,LoginResultSet? loginResultSet)
  {
    return {
      Headers.acceptHeader: 'application/json',
      "authtokenKey":"${loginResultSet?.headerInfo?.authtokenKey}",
      "GlobalCompanyCode": Provider.of<GlobalSelectedEmployeeController>(context,listen: false).companyData?.company.companyCode??loginResultSet?.headerInfo?.companyCode,
      "Content-Type":"application/json",
      "UserCultureID":"${loginResultSet?.headerInfo?.userCultureID}",
      "CultureID":"${loginResultSet?.headerInfo?.cultureID}",
    };
  }
  getChangeCompanyHeader(LoginResultSet? loginResultSet,dynamic companyCode)
  {
    return {
      Headers.acceptHeader: 'application/json',
      "authtokenKey":"${loginResultSet?.headerInfo?.authtokenKey}",
      "GlobalCompanyCode": companyCode,
      "Content-Type":"application/json",
      "UserCultureID":"${loginResultSet?.headerInfo?.userCultureID}",
      "CultureID":"${loginResultSet?.headerInfo?.cultureID}",
    };
  }
  normalHeader(BuildContext context,LoginResultSet? loginResultSet)
  {
    return {
      Headers.acceptHeader: 'application/json',
      "CultureID":"${loginResultSet?.headerInfo?.cultureID}",
      "Content-Type":"application/json",
      "GlobalCompanyCode": Provider.of<GlobalSelectedEmployeeController>(context,listen: false).companyData?.company.companyCode??loginResultSet?.headerInfo?.companyCode,
    };
  }
}