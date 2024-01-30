import 'dart:convert';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:url_launcher/url_launcher.dart';

class UserPersonalInfoListener extends GetChangeNotifier
{
  String? userName,email,designation,image;
  ApiStatus apiStatus = ApiStatus.nothing;
  Future<void> start()
  async {
    apiStatus = ApiStatus.started;
    notifyListeners();
    LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    if(loginResultSet.headerInfo!=null&&loginResultSet.myProfile!=null)
      {
        userName = loginResultSet.myProfile?.employeeName;
        email = loginResultSet.myProfile?.email;
        designation = loginResultSet.myProfile?.jobTitle;
        image = loginResultSet.myProfile?.picture;
       // PrintLogs.print('imageeeee $image');
        apiStatus = ApiStatus.done;
        notifyListeners();
      }
    else
      {
        apiStatus = ApiStatus.error;
      }
  }
  void contactUs(BuildContext context) async
  {
    LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'support@peopleqlik.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'Need Support to (Employee Name: ${loginResultSet.headerInfo?.employeeName}) (Employee Code: ${loginResultSet.headerInfo?.employeeCode})'
      }),
    );
    if(await canLaunch(emailLaunchUri.toString())) {
      launch(emailLaunchUri.toString());
    }
    else
    {
      SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.emailError1)}');
     // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'${CallLanguageKeyWords.get(context, LanguageCodes.emailError1)}',color: MyColor.colorRed));
    }
  }
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
  void justNotify()
  {
    notifyListeners();
  }
}