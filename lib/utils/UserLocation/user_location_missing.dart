import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/Version1/viewModel/sliding_up_panel.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/UserLocation/get_user_location.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';

import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';

import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class UserLocationPermissionMissing extends StatelessWidget {
  UserLocationPermissionMissing({Key? key}) : super(key: key);
  late BuildContext buildContext;
  @override
  Widget build(BuildContext context) {
    buildContext = context;
    CheckUserLocation checkUserLocation = Provider.of<CheckUserLocation>(context,listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: ScreenSize(context).heightOnly( 4),),
        Lottie.asset("assets/location_permission.json",fit: BoxFit.fitHeight,height: ScreenSize(context).heightOnly( 25),repeat: true),
        SizedBox(height: ScreenSize(context).heightOnly( 4),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
          child: Text(
            checkUserLocation.locationEnum == LocationEnum.goToSettings?'${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr5)}':'${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr7)}',
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
            checkUserLocation.locationEnum == LocationEnum.goToSettings?'${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr6)}':'${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr8)}',
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
        ButtonWidget(onPressed: onPressedPermission, text: checkUserLocation.locationEnum == LocationEnum.goToSettings?"${CallLanguageKeyWords.get(context, LanguageCodes.letsDoIt)}":'${CallLanguageKeyWords.get(context, LanguageCodes.givePermission)}',width: ScreenSize(context).heightOnly( 23),height: 6.0,weight: FontWeight.w600),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        ButtonWidget(onPressed: onPressedDeny, text: '${CallLanguageKeyWords.get(context, LanguageCodes.noThanks)}',width: ScreenSize(context).heightOnly( 20),height: 6.0,buttonColor: MyColor.colorBlack,textColor: MyColor.colorWhite,weight: FontWeight.w600,),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),

      ],
    );
  }

  void onPressedPermission() async{
    if(await Location().serviceEnabled()==false)
      {
        Provider.of<CheckUserLocation>(buildContext,listen: false).checkAppBackground = true;
        await Provider.of<SlidingPanelData>(buildContext,listen: false).panelController?.close();
        AppSettings.openAppSettings();
      }
    else
      {
        Provider.of<CheckUserLocation>(buildContext,listen: false).checkAppBackground = false;
        await Provider.of<SlidingPanelData>(buildContext,listen: false).panelController?.close();
        //Provider?.of<AttendanceLogicBuilder>(buildContext,listen: false).start(buildContext);
        openAppSettings();
      }
  }
  void onPressedDeny()async
  {
    await Provider.of<SlidingPanelData>(buildContext,listen: false).panelController?.close();
  }
}


class UserMockLocationFailed extends StatelessWidget {
  UserMockLocationFailed({Key? key}) : super(key: key);
  late BuildContext buildContext;
  @override
  Widget build(BuildContext context) {
    buildContext = context;
    CheckUserLocation checkUserLocation = Provider.of<CheckUserLocation>(context,listen: false);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: ScreenSize(context).heightOnly( 4),),
        Lottie.asset("assets/location_permission.json",fit: BoxFit.fitHeight,height: ScreenSize(context).heightOnly( 25),repeat: true),
        SizedBox(height: ScreenSize(context).heightOnly( 4),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
          child: Text(
            '${CallLanguageKeyWords.get(context, LanguageCodes.waitAMinute)}',
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
            '${CallLanguageKeyWords.get(context, LanguageCodes.FakeLocation)}',
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
        ButtonWidget(onPressed: onPressedPermission, text: '${CallLanguageKeyWords.get(context, LanguageCodes.done)}',width: ScreenSize(context).heightOnly( 23),height: 6.0,weight: FontWeight.w600),
        // SizedBox(height: ScreenSize(context).heightOnly( 2),),
        // ButtonWidget(onPressed: onPressedDeny, text: '${CallLanguageKeyWords.get(context, LanguageCodes.noThanks)}',width: ScreenSize(context).heightOnly( 20),height: 6.0,buttonColor: MyColor.colorBlack,textColor: MyColor.colorWhite,weight: FontWeight.w600,),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),

      ],
    );
  }

  Future<void> onPressedPermission() async {
    // Provider?.of<CheckUserLocation>(buildContext,listen: false).checkAppBackground=false;
    // CheckInOutModelStarter checkInOutModelStarter = Provider?.of<CheckInOutModelStarter>(buildContext,listen: false);
    // checkInOutModelStarter.start(buildContext);
    Provider.of<SlidingPanelData>(buildContext,listen: false).panelController?.close();

  }
  void onPressedDeny()
  {
    Provider.of<SlidingPanelData>(buildContext,listen: false).panelController?.close();
  }
}
