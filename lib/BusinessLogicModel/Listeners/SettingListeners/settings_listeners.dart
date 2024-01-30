import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/show_error.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/Urls/urls.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/AuthListeners/save_cookie_globally.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/company_url_get_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_payslip_month.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/settings_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/company_urls_prefs.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/leave_calender.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/settings_pref.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/loader.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import '../../../mainCommon.dart';
import '../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../Encrypter/encryption.dart';
import '../AuthListeners/initial_cookie_listener.dart';
import '../AuthListeners/log_out_listener.dart';
import 'enums.dart';


class SettingsModelListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  SettingsResultSet? settingsResultSet;
  List<Keywords>? keyWordsList;
  PackageInfo? packageInfo;
  SettingPageType settingPageType = SettingPageType.setting;

  Future? start(BuildContext context)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    packageInfo = await PackageInfo.fromPlatform();
    if(loginResultSet.headerInfo==null)
      {
        Future.delayed(const Duration(milliseconds: 200),(){
          GetNavigatorStateContext.navigatorKey.currentState!.pushNamedAndRemoveUntil(CurrentPage.CompanyPage, (route) => false);
        });
      }
    else
      {
        if(Provider.of<SaveCookieGlobally>(context,listen: false).cookieApiCalled==false)
          {
            await CookieModelListener().start(context);
          }

        ApiResponse? apiResponse = await GetApisUrlCaller().getSettingDataApi(context);
        if(apiResponse.apiStatus == ApiStatus.done&&apiResponse.data?.resultSet!=null)
        {
          settingsResultSet = apiResponse.data!.resultSet;

          if(settingsResultSet?.headerInfo!=null&&settingsResultSet?.myProfile!=null)
          {
            LoginResultSet loginResultSet = LoginResultSet();
            loginResultSet.headerInfo = settingsResultSet?.headerInfo;
            loginResultSet.myProfile = settingsResultSet?.myProfile;
            loginResultSet.isAdmin = settingsResultSet?.isAdmin;
            await UserInfoPrefs().writeUserInfoPrefs(jsonEncode(loginResultSet.toJson()));
            await UserInfoPrefs().writeUserPersonalInfoPrefs(jsonEncode(loginResultSet.myProfile!.toJson()));
          }
          if(settingsResultSet?.leaveCalendar!=null&&settingsResultSet!.leaveCalendar!.isNotEmpty)
          {
            await LeaveCalenderPrefs().writeLeaveCalenderPrefs(jsonEncode(settingsResultSet!.leaveCalendar!));
          }
          if(settingsResultSet!=null)
          {
            await SettingsPrefs().writeSettingsPrefs(jsonEncode(settingsResultSet!.toJson()));
          }
          if(settingsResultSet?.keywords!=null)
            {
              keyWordsList = settingsResultSet!.keywords;
            }
          //PrintLogs.printLogs('tokenasda ${settingsResultSet?.headerInfo?.authtokenKey}');
          apiStatus = ApiStatus.done;
          // settingPageType = SettingPageType.mobileBlocking;
          notifyListeners();
          Future.delayed(const Duration(milliseconds: 200),(){
            GetNavigatorStateContext.navigatorKey.currentState?.pushNamedAndRemoveUntil(CurrentPage.MainBottomBarPage, (route) => false);
          });
        }
        else
        {

          apiStatus = ApiStatus.error;
          notifyListeners();
          SnackBarDesign.errorSnack(apiResponse.message??'Unknown Error');
          Future.delayed(const Duration(milliseconds: 50),(){
            MoveOnLoginPage.move(GetNavigatorStateContext.navigatorKey.currentState?.context);
          });
        }
      }
  }
  String? getValue(BuildContext context,String value)
  {
    int? index = keyWordsList?.indexWhere((element) => element.resourceName == value);
    if(index!=null&&index!=-1)
      {
        return keyWordsList?[index].resourceValue;
      }
    //PrintLogs.print('kkkkk');
    return LanguageLocalizations.of(context)?.getTranslatedValue(value);
  }
  Future<void> getSettingsData() async
  {
    settingsResultSet = SettingsResultSet.fromJson(await jsonDecode(await SettingsPrefs().getSettingsPrefs()));
  }
  Future<void> updateSettingsApi(BuildContext context,{dynamic headers}) async
  {
    ApiResponse? apiResponse = await GetApisUrlCaller().getSettingDataApi(context,header: headers);
    if(apiResponse.apiStatus == ApiStatus.done&&apiResponse.data?.resultSet!=null)
    {
      settingsResultSet = apiResponse.data!.resultSet;

      if(settingsResultSet?.headerInfo!=null&&settingsResultSet?.myProfile!=null)
      {
        LoginResultSet loginResultSet = LoginResultSet();
        loginResultSet.headerInfo = settingsResultSet?.headerInfo;
        loginResultSet.myProfile = settingsResultSet?.myProfile;
        loginResultSet.isAdmin = settingsResultSet?.isAdmin;
        await UserInfoPrefs().writeUserInfoPrefs(jsonEncode(loginResultSet.toJson()));
        await UserInfoPrefs().writeUserPersonalInfoPrefs(jsonEncode(loginResultSet.myProfile!.toJson()));
      }
      if(settingsResultSet?.leaveCalendar!=null&&settingsResultSet!.leaveCalendar!.isNotEmpty)
      {
        await LeaveCalenderPrefs().writeLeaveCalenderPrefs(jsonEncode(settingsResultSet!.leaveCalendar!));
      }
      if(settingsResultSet!=null)
      {
        await SettingsPrefs().writeSettingsPrefs(jsonEncode(settingsResultSet!.toJson()));
      }
      if(settingsResultSet?.keywords!=null)
      {
        keyWordsList = settingsResultSet!.keywords;
      }
      // notifyListeners();
    }
  }
  getDefaultCompany(BuildContext context,bool foundIndex)
  {
    int? index = settingsResultSet?.companyList?.indexWhere((element) => element.companyCode == settingsResultSet?.headerInfo?.companyCode);
    if(foundIndex==true){
      return index??0;
    }
    else
      {
        return settingsResultSet?.companyList?[index??0];
      }
  }
}

