import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/loader_class.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/post_language_api.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Accounts/get_user_info_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/settings_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/settings_pref.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/icons.dart';
import 'package:peopleqlik_debug/src/loader.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import '../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../ApiCalls/ApiCallers/show_error.dart';
import '../../ApiCalls/ApiGlobalModel/api_global_model.dart';


class UpdateLanguageListener with GetLoader
{
  SettingsResultSet? settingsResultSet;

  Future? start(BuildContext context,int code)
  async {


    initLoader();
    ApiResponse? apiResponse = await GetApisUrlCaller().postLanguageApi(context,'?UserCultureID=$code');
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

