import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/models/AuthModels/company_url_get_model.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/company_urls_prefs.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../../configs/prints_logs.dart';
import '../../../utils/strings.dart';
import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../models/make_urls.dart';
import 'initial_cookie_listener.dart';


class CompanyModelListener extends GetChangeNotifier with GetLoader
{
  CompanyResultSet? companyDataSet;

  Future? start(String company,BuildContext context)
  async {

    initLoader();

    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getCompanyApi(context,'?CustomerName=$company&CustomerToken=${GetVariable.tempToken}');

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

