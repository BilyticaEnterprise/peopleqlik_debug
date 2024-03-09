import 'dart:convert';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/AuthListeners/log_out_listener.dart';
import 'package:peopleqlik_debug/Version1/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../AccountSubModules/PoliciesURLModule/presentation/ui/policies_page.dart';
import '../../../../../configs/routing/pages_name.dart';
import '../../../../../utils/pop_ups.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import '../../domain/model/account_model.dart';

class AccountPageInfoListener extends GetChangeNotifier
{
  String? userName,email,designation,image;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<AccountModel> accountModel = [];
  final colors = [
    MyColor.colorA1,
    MyColor.colorA2,
    MyColor.colorA3,
    MyColor.colorA4,
    MyColor.colorA1,
    MyColor.colorA5,
    MyColor.colorA2,
    MyColor.colorT5,
    // ,0xffF1F1F3
  ];
  final icons = [
    MdiIcons.faceManProfile,
    MdiIcons.lock,
    MdiIcons.alphabetical,
    MdiIcons.accountSettingsOutline,
    MdiIcons.noteOutline,
    MdiIcons.noteOutline,
    MdiIcons.phoneOutline,
    MdiIcons.toggleSwitchOffOutline
  ];

  final header = [
    (LanguageCodes.profile),
    LanguageCodes.changePassword,
    (LanguageCodes.accountLanguageHeader),
    (LanguageCodes.accountSettingHeader),
    (LanguageCodes.accountAboutHeader),
    (LanguageCodes.accountTermsHeader),
    (LanguageCodes.accountSupportHeader),
    (LanguageCodes.accountLogOut)];

  final answer = [
    LanguageCodes.seeProfile,
    LanguageCodes.changePasswordDesc,
    LanguageCodes.accountLanguageAnswer,
    LanguageCodes.accountSettingAnswer,
    LanguageCodes.accountAboutAnswer,
    LanguageCodes.accountTermsAnswer,
    LanguageCodes.accountSupportAnswer,
    '',
  ];

  Future<void> start(BuildContext context)
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
        accountModel = createAccountList(context);
       // PrintLogs.print('imageeeee $image');
        apiStatus = ApiStatus.done;
        notifyListeners();
      }
    else
      {
        apiStatus = ApiStatus.error;
      }
  }

  List<AccountModel> createAccountList(BuildContext context){
    return List<AccountModel>.generate(icons.length, (index) => AccountModel(header: CallLanguageKeyWords.get(context, header[index])??'', desc: CallLanguageKeyWords.get(context, answer[index])??'', icon: icons[index], color: colors[index]));
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

  Future<void> clickedIndex(BuildContext context, int index) async {
    switch(index)
    {
      case 0:
        Navigator.pushNamed(context, CurrentPage.userProfilePage);
        break;
      case 1:
        Navigator.pushNamed(context, CurrentPage.checkCurrentPasswordPage);
        break;
      case 2:
        Navigator.pushNamed(context, CurrentPage.LanguagePage).then((value){
          start(context);
        });
        break;
      case 3:
        Navigator.pushNamed(context, CurrentPage.AccountSettingPage);
        break;
      case 4:
        Navigator.pushNamed(context, CurrentPage.PolicyPage,arguments: PolicyPageData('About', RequestType.privacyPolicy));
        break;
      case 5:
        Navigator.pushNamed(context, CurrentPage.PolicyPage,arguments: PolicyPageData('About', RequestType.termsOfUse));
        break;
      case 6:
        Provider.of<AccountPageInfoListener>(context,listen: false).contactUs(context);
        break;
      case 7:
        bool check = await AlertYesNo().show(context, AlertModel(
          header: CallLanguageKeyWords.get(context, LanguageCodes.logOutHeader)??'',
          description: CallLanguageKeyWords.get(context, LanguageCodes.logOutValue)??'',
          buttonYesText: CallLanguageKeyWords.get(context, LanguageCodes.logOutYes)??'',
          buttonNoText: CallLanguageKeyWords.get(context, LanguageCodes.logOutNo)??'',
        )
        );
        if(check == true)
          {
            await MoveOnLoginPage.logOutClearData();
            Navigator.pushNamedAndRemoveUntil(context, CurrentPage.CompanyPage, ModalRoute.withName(CurrentPage.LoginPage));
          }
        break;
      default:
        break;
    }
  }
}