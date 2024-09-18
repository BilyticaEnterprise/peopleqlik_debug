import 'dart:io';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import '../../../../../configs/colors.dart';
import '../../../../../configs/fonts.dart';
import '../../../../../configs/icons.dart';
import '../../../../../utils/global_variables.dart';
import '../../../../../utils/icon_view/get_icons.dart';

class VersionCheckerView extends StatelessWidget {
  VersionCheckerView({super.key});

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height:ScreenSize(context).heightOnly(4),),
          NotAvailableIcon(icon: Platform.isAndroid?SvgPicturesData.playStore:SvgPicturesData.appStore,header: CallLanguageKeyWords.get(context, LanguageCodes.newUpdateHeader)??'', description: '${CallLanguageKeyWords.get(context, LanguageCodes.newUpdateDesc)??''} ${updateAvailable?.storeVersion}',),
          SizedBox(height:ScreenSize(context).heightOnly(10),),
          ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.updateYes)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 70),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: confirmPressed,),
          SizedBox(height:ScreenSize(context).heightOnly(2.5),),
          ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.updateNo)}',buttonColor: MyColor.colorBlack,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 60),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: noPressed,),
          SizedBox(height:ScreenSize(context).heightOnly(6),),

        ],
      ),
    );
  }

  void confirmPressed() {
    Navigator.pop(context,true);
  }

  void noPressed() {
    Navigator.pop(context);
  }
}
