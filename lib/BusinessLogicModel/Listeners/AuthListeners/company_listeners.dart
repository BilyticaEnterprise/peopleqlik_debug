import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/loader_class.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/show_error.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/company_url_get_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/company_urls_prefs.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import '../../../src/prints_logs.dart';
import '../../../src/strings.dart';
import '../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../Models/make_urls.dart';
import 'initial_cookie_listener.dart';


class CompanyModelListener extends GetChangeNotifier with GetLoader
{
  CompanyResultSet? companyDataSet;

  Future? start(String company,BuildContext context)
  async {

    initLoader();

    ApiResponse apiResponse = await GetApisUrlCaller().getCompanyApi(context,'?CustomerName=$company&CustomerToken=${GetVariable.tempToken}');

    if(apiResponse.apiStatus == ApiStatus.done)
    {

      companyDataSet = apiResponse.data!.resultSet;
      await CompanyInfoPrefs().writeCompanyInfoPrefs(jsonEncode(companyDataSet!.toJson()));
      await MakeUrls().saveUrl();

      PrintLogs.printLogs('aksjndas');
      await CookieModelListener().start(context);

      await closeLoader();
      Future.delayed(const Duration(milliseconds: 100),(){
        Navigator.pushNamed(context, CurrentPage.LoginPage);
      });
    }
    else
    {
      await Future.delayed(const Duration(milliseconds: 120));
      await closeLoader();
      CompanyInfoPrefs().removeCompanyInfoPrefs();
      ShowErrorMessage.show(apiResponse);
    }

  }
}

