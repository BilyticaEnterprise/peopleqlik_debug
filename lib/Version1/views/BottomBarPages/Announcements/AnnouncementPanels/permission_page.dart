import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/Version1/viewModel/FileDownloaderListener/file_downloader_listener.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/Buttons/buttons.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class StoragePermission extends StatelessWidget {
  final PanelController panelController;
  StoragePermission(this.panelController, {Key? key}) : super(key: key);
  late BuildContext buildContext;

  @override
  Widget build(BuildContext context) {
    buildContext = context;
    FileDownloaderListener checkUserLocation = Provider.of<FileDownloaderListener>(context,listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //SizedBox(height: ScreenSize(context).heightOnly( 4),),
        Lottie.asset("assets/storage.json",fit: BoxFit.fitHeight,height: ScreenSize(context).heightOnly( 25),repeat: true),
        SizedBox(height: ScreenSize(context).heightOnly( 6),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
          child: Text(
            checkUserLocation.storageEnum == StorageEnum.goToSettings?'${CallLanguageKeyWords.get(context, LanguageCodes.enableStorage)}':'${CallLanguageKeyWords.get(context, LanguageCodes.deniedStorage)}',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w600,
                fontSize: 2.2,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
          child: Text(
            checkUserLocation.storageEnum == StorageEnum.goToSettings?'${CallLanguageKeyWords.get(context, LanguageCodes.enableStorageHeader)}':'${CallLanguageKeyWords.get(context, LanguageCodes.deniedStorageHeader)}',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w400,
                fontSize: 1.8,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 4),),
        ButtonWidget(onPressed: onPressedPermission, text: checkUserLocation.storageEnum == StorageEnum.goToSettings?"${CallLanguageKeyWords.get(context, LanguageCodes.letsDoIt)}":'${CallLanguageKeyWords.get(context, LanguageCodes.givePermission)}',width: ScreenSize(context).heightOnly( 23),height: 6.0,weight: FontWeight.w600),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        ButtonWidget(onPressed: onPressedDeny, text: '${CallLanguageKeyWords.get(context, LanguageCodes.noThanks)}',width: ScreenSize(context).heightOnly( 20),height: 6.0,buttonColor: MyColor.colorBlack,textColor: MyColor.colorWhite,weight: FontWeight.w600,),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),

      ],
    );
  }

  void onPressedPermission() async{
    Provider.of<FileDownloaderListener>(buildContext,listen: false).checkAppBackground = true;
    await panelController.close();
    AppSettings.openAppSettings();

  }
  void onPressedDeny()async
  {
    await panelController.close();
  }
}
