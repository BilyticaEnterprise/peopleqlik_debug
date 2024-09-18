import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/FCMModule/data/repoImpl/firebase_setup.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/AuthListeners/save_cookie_globally.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/app_version_check.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/device_info_getter.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/moving_page_extensions.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/setting_device_extension.dart';
import 'package:peopleqlik_debug/Version1/models/AuthModels/company_url_get_model.dart';
import 'package:peopleqlik_debug/Version1/models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/Version1/models/PaysSlipApprovalsRequest/get_payslip_month.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/company_urls_prefs.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/leave_calender.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/settings_pref.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../mainCommon.dart';
import '../../../ApiModule/domain/usecase/apis_url_caller.dart';

import '../../../../../Version1/viewModel/AuthListeners/initial_cookie_listener.dart';
import '../../../../../Version1/viewModel/AuthListeners/log_out_listener.dart';
import '../../../../../utils/global_variables.dart';
import '../../utils/enums.dart';


class SettingsModelListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  SettingsResultSet? settingsResultSet;
  List<Keywords>? keyWordsList;
  PackageInfo? packageInfo;
  AndroidDeviceInfo? androidDeviceInfo;
  IosDeviceInfo? iosDeviceInfo;
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

        ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getSettingDataApi(context);
        if(apiResponse.apiStatus == ApiStatus.done&&apiResponse.data?.resultSet!=null)
        {
          settingsResultSet = apiResponse.data!.resultSet;
          updateAvailable = await checkForAppVersion();

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
          await createDeviceInfo();
          //PrintLogs.printLogs('tokenasda ${settingsResultSet?.headerInfo?.authtokenKey}');
          apiStatus = ApiStatus.done;
          FirebaseSetup.init(GetNavigatorStateContext.navigatorKey.currentState!.context,deviceId: Platform.isAndroid?androidDeviceInfo?.id:iosDeviceInfo?.identifierForVendor);
          Provider.of<GlobalSelectedEmployeeController>(context,listen: false).selectDefaultCurrentEmployee(context);
          notifyListeners();

          if(settingsResultSet?.deviceRestricModel!=null && settingsResultSet?.deviceRestricModel?.deviceRestrict == true)
            {
              checkDeviceRestrict();
            }
          else
            {
              moveToBottomPage();
            }

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
    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getSettingDataApi(context,header: headers);
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

  removeAll()
  {
    settingsResultSet = null;
    settingPageType = SettingPageType.setting;
  }

}

