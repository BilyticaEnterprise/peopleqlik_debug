import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/Version1/ApiCalls/post_language_api.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/Version1/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';

import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';


class UpdateLanguageListener with GetLoader
{
  SettingsResultSet? settingsResultSet;

  Future? start(BuildContext context,int code)
  async {


    initLoader();
    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().postLanguageApi(context,'?UserCultureID=$code');
    await closeLoader();
    // UpdateLanguageData? updateLanguageData = await UpdateLanguageApiCall().callApi(context,code);
    Future.delayed(const Duration(milliseconds: 100),() async {
      if(apiResponse.apiStatus == ApiStatus.done)
      {
        await Provider.of<SettingsModelListener>(context,listen: false).updateSettingsApi(context);
        SnackBarDesign.happySnack(apiResponse.data?.message);
      }
      else
      {
        ShowErrorMessage.show(apiResponse);
      }
    });

  }

}

