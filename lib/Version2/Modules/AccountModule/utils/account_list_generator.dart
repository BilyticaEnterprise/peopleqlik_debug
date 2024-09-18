import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/domain/model/account_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/utils/account_enums.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';

class GenerateAccountPageList
{
  static List<AccountModel> getAccountPageList(BuildContext context)
  {

    return [
      // AccountModel(
      //     header: CallLanguageKeyWords.get(context, LanguageCodes.profile)??'',
      //     desc: CallLanguageKeyWords.get(context, LanguageCodes.seeProfile)??'',
      //     icon: MdiIcons.faceManProfile,
      //     color: MyColor.colorA1,
      //   accountPageType: AccountPageType.profile
      // ),
      // AccountModel(
      //     header: CallLanguageKeyWords.get(context, LanguageCodes.changePassword)??'',
      //     desc: CallLanguageKeyWords.get(context, LanguageCodes.changePasswordDesc)??'',
      //     icon: MdiIcons.lock,
      //     color: MyColor.colorA2,
      //   accountPageType: AccountPageType.changePassword
      // ),
      AccountModel(
          header: CallLanguageKeyWords.get(context, LanguageCodes.accountLanguageHeader)??'',
          desc: CallLanguageKeyWords.get(context, LanguageCodes.accountLanguageAnswer)??'',
          icon: MdiIcons.alphabetical,
          color: MyColor.colorA3,
        accountPageType: AccountPageType.language
      ),
      AccountModel(
          header: CallLanguageKeyWords.get(context, LanguageCodes.accountSettingHeader)??'',
          desc: CallLanguageKeyWords.get(context, LanguageCodes.accountSettingAnswer)??'',
          icon: MdiIcons.accountSettingsOutline,
          color: MyColor.colorA4,
        accountPageType: AccountPageType.setting
      ),
      AccountModel(
          header: CallLanguageKeyWords.get(context, LanguageCodes.accountAboutHeader)??'',
          desc: CallLanguageKeyWords.get(context, LanguageCodes.accountAboutAnswer)??'',
          icon: MdiIcons.noteOutline,
          color: MyColor.colorA1,
        accountPageType: AccountPageType.about
      ),
      AccountModel(
          header: CallLanguageKeyWords.get(context, LanguageCodes.accountTermsHeader)??'',
          desc: CallLanguageKeyWords.get(context, LanguageCodes.accountTermsAnswer)??'',
          icon: MdiIcons.noteOutline,
          color: MyColor.colorA5,
        accountPageType: AccountPageType.terms
      ),
      AccountModel(
          header: CallLanguageKeyWords.get(context, LanguageCodes.accountSupportHeader)??'',
          desc: CallLanguageKeyWords.get(context, LanguageCodes.accountSupportAnswer)??'',
          icon: MdiIcons.phoneOutline,
          color: MyColor.colorA2,
        accountPageType: AccountPageType.support
      ),
      AccountModel(
          header: CallLanguageKeyWords.get(context, LanguageCodes.accountLogOut)??'',
          desc: '',
          icon: MdiIcons.toggleSwitchOffOutline,
          color: MyColor.colorA5,
        accountPageType: AccountPageType.logOut
      ),
    ];
  }
}

// final colors = [
//   ,
//   MyColor.colorA2,
//   MyColor.colorA3,
//   MyColor.colorA4,
//   MyColor.colorA1,
//   MyColor.colorA5,
//   MyColor.colorA2,
//   MyColor.colorT5,
//   // ,0xffF1F1F3
//];
