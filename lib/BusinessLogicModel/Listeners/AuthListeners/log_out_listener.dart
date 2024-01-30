import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../mainCommon.dart';
import '../../../src/pages_name.dart';
import '../../ApiCalls/Urls/urls.dart';

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
}