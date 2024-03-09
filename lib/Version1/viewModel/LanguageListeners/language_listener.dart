
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/update_language.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/settings_pref.dart';
import 'package:peopleqlik_debug/configs/colors.dart';

import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

class ChangeLanguage extends GetChangeNotifier
{
  Locale _currentLocale = const Locale('en','US');
  Locale permanentLocale = const Locale('en','US');
  Locale get currentLocale => _currentLocale;
  LanguageEnum languageEnum = LanguageEnum.english;
  List<bool> selected = [true,false];
  ApiStatus apiStatus = ApiStatus.nothing;

  Future<void> setInitialLanguage() async
  {
    final List<Locale>? systemLocales = WidgetsBinding.instance.platformDispatcher.locales;
    if(systemLocales!=null&&systemLocales.isNotEmpty)
      {
        String? userInfo = await UserInfoPrefs().getUserInfoPrefs();
        LoginResultSet? loginResultSet;
        if(userInfo!=null)
          {
            loginResultSet = LoginResultSet.fromJson(await jsonDecode(userInfo));

          }
        if(loginResultSet!=null&&loginResultSet.headerInfo!=null)
        {
          int langId = loginResultSet.headerInfo?.userCultureID??1;
          if(langId==1)
            {
              languageEnum = LanguageEnum.english;
            }
          else if(langId==2)
            {
              languageEnum = LanguageEnum.arabic;
            }
          else
            {
              languageEnum = LanguageEnum.english;
            }
          localeChange(languageEnum);
        }
        else
          {
            _currentLocale = permanentLocale;
            apiStatus = ApiStatus.done;
            notifyListeners();
          }
      }
    else
      {
        _currentLocale = permanentLocale;
        apiStatus = ApiStatus.done;
        notifyListeners();
      }
  }

  void changeLocale(Locale locale)
  {
    _currentLocale = locale;
    notifyListeners();
  }
  void checkLanguageStatus(BuildContext context,int code) async
  {
    await UpdateLanguageListener().start(context, code);
    //PrintLogs.print('ahdbsfjashdbfjha');
    if(code == 1)
      {
        selected = [true,false];
        languageEnum = LanguageEnum.english;
        localeChange(languageEnum);
      }
    else if(code == 2)
    {
      selected = [false,true];
      languageEnum = LanguageEnum.arabic;
      localeChange(languageEnum);
    }
    else
      {
        selected = [true,false];
        languageEnum = LanguageEnum.english;
        localeChange(languageEnum);
      }

  }

  void localeChange(LanguageEnum languageEnum) {
    final List<Locale>? systemLocales = WidgetsBinding.instance?.window.locales;
    if(systemLocales!=null&&systemLocales.isNotEmpty)
      {
        for(int x=0;x<systemLocales.length;x++)
        {
          //PrintLogs.print('localessss ${systemLocales[x].countryCode}');
          if(languageEnum == LanguageEnum.arabic)
          {
            selected = [false,true];
            if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('SA'))
            {
              _currentLocale = const Locale('ar','SA');
              break;
            }
            else if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('QA'))
            {
              _currentLocale = const Locale('ar','QA');
              break;
            }
            else if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('KW'))
            {
              _currentLocale = const Locale('ar','KW');
              break;
            }
            else if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('AE'))
            {
              _currentLocale = const Locale('ar','AE');
              break;
            }
            else if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('EG'))
            {
              _currentLocale = const Locale('ar','EG');
              break;
            }
            else if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('PK'))
            {
              _currentLocale = const Locale('ar','PK');
              break;
            }
            else
            {
              _currentLocale = const Locale('ar','SA');
              break;
            }
          }
          else if(languageEnum == LanguageEnum.english)
          {
            selected = [true,false];
            if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('US'))
            {
              _currentLocale = const Locale('en','US');
              break;
            }
            else if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('AU'))
            {
              _currentLocale = const Locale('en','AU');
              break;
            }
            else if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('CH'))
            {
              _currentLocale = const Locale('en','CH');
              break;
            }
            else if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('CA'))
            {
              _currentLocale = const Locale('en','CA');
              break;
            }
            else if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('GB'))
            {
              _currentLocale = const Locale('en','GB');
              break;
            }
            else if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('IN'))
            {
              _currentLocale = const Locale('en','IN');
              break;
            }
            else if(systemLocales[x].countryCode!=null&&systemLocales[x].countryCode!.contains('CH'))
            {
              _currentLocale = const Locale('en','CH');
              break;
            }
            else
            {
              _currentLocale = const Locale('en','US');
              break;
            }
          }
        }
      }
    else
      {
        selected = [true,false];
        _currentLocale = permanentLocale;
      }
    apiStatus = ApiStatus.done;
    notifyListeners();
  }
}
enum LanguageEnum
{
  english,arabic
}
class LanguageData extends GetChangeNotifier
{
  List<Languages>? languageList;
  final icons = [MdiIcons.alphabetical,
    MdiIcons.alphabetical];
  final colors = [MyColor.colorA1,
    MyColor.colorA2
    // ,0xffF1F1F3
  ];
  void setData() async
  {
    String? value = await SettingsPrefs().getSettingsPrefs();
    if(value!=null)
      {
        SettingsResultSet settingsResultSet = SettingsResultSet.fromJson(await jsonDecode(value));
        languageList = settingsResultSet.languages;
        languageList ??= List.empty(growable: true);
        notifyListeners();
      }
  }
}