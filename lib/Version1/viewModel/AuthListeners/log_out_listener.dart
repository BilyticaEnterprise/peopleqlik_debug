import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';


import '../../../mainCommon.dart';
import '../../../configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/company_urls_prefs.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/leave_calender.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/settings_pref.dart';

class MoveOnLoginPage
{
  static move(BuildContext? context,{String? pageName,bool? normalPop})
  {
    if(context!=null&&context.mounted==true&&ModalRoute.of(context)?.settings.name==CurrentPage.CompanyPage)
    {
      if(Platform.isAndroid)
      {
        SystemNavigator.pop(animated: true);
      }
      else
      {
        exit(0);
      }
    }
    else
    {
      if(context!=null&&context.mounted==true&&Navigator.canPop(context))
      {
        if(normalPop == true)
        {
          Navigator.pop(context);
        }
        else
        {
          RequestType.baseUrl = null;
          GetNavigatorStateContext.navigatorKey.currentState?.pushNamedAndRemoveUntil(pageName??CurrentPage.CompanyPage, (route) => false);
        }
      }
      else
      {
        RequestType.baseUrl = null;
        GetNavigatorStateContext.navigatorKey.currentState!.popAndPushNamed(pageName??CurrentPage.CompanyPage);
      }
    }
  }

  static logOutClearData()async
  {
    await UserInfoPrefs().removeUserInfoPrefs();
    await UserInfoPrefs().removeUserPersonalInfoPrefs();
    await CompanyInfoPrefs().removeCompanyInfoPrefs();
    await LeaveCalenderPrefs().removeLeaveCalenderPrefs();
    await SettingsPrefs().removeSettingsPrefs();
    RequestType.baseUrl = null;
  }
}