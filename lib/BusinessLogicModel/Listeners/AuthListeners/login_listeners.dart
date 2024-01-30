import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/loader_class.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/show_error.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import '../../ApiCalls/ApiCallers/apis_url_caller.dart';


class LoginModelListener extends GetChangeNotifier with GetLoader
{
  LoginResultSet? resultSet;

  Future? start(String email,String password,BuildContext context)
  async {

    initLoader();

    String? deviceId = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid)
    {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    }
    else{
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    }

    try{
      ApiResponse? apiResponse = await GetApisUrlCaller().getLoginApi(context,'?UserName=$email&Password=$password&DeviceType=${Platform.isAndroid?"android":"ios"}&DeviceID=$deviceId&UserType=AP');
      PrintLogs.printLogs('hereit comers');
      if(apiResponse.apiStatus == ApiStatus.done&&apiResponse.data?.resultSet!=null&&apiResponse.data?.resultSet?.headerInfo!=null)
      {

        PrintLogs.printLogs('1hereit comers');
        resultSet = apiResponse.data?.resultSet;
        //PrintLogs.printLogs(loginJson?.resultSet?.headerInfo?.authtokenKey);
        await UserInfoPrefs().writeUserInfoPrefs(jsonEncode(resultSet!.toJson()));
        await UserInfoPrefs().writeUserPersonalInfoPrefs(jsonEncode(resultSet!.myProfile!.toJson()));
        await Provider.of<ChangeLanguage>(context,listen: false).setInitialLanguage();
        await closeLoader();
        Future.delayed(const Duration(milliseconds: 250),(){
          Navigator.pushNamed(context, CurrentPage.SettingsPage);
        });
      }
      else
      {

        PrintLogs.printLogs('hereit comers');
        await UserInfoPrefs().removeUserInfoPrefs();
        await UserInfoPrefs().removeUserPersonalInfoPrefs();
        await closeLoader();
        ShowErrorMessage.show(apiResponse);
      }
    }catch(e){
      PrintLogs.printLogs('hereit comers $e');
    }

  }
}

