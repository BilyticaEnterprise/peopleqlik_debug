import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../domain/repoImpl/settings_listeners.dart';
import '../../../../configs/colors.dart';
import '../../../../configs/fonts.dart';
import '../../../../utils/screen_sizes.dart';

class SettingUi extends StatelessWidget {
  const SettingUi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: ScreenSize(context).widthOnly( 100),
        height: ScreenSize(context).heightOnly( 100),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(bottom: ScreenSize(context).widthOnly(30)),
                child: Lottie.asset("assets/settings.json",
                    width: ScreenSize(context).widthOnly(80),
                    height: ScreenSize(context).heightOnly( 38),
                    repeat: true),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: ScreenSize(context).widthOnly( 48)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                      child: Text(
                        Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.peopleQlik?.question??"",
                        style: GetFont.get(
                            context,
                            fontSize: 2.2,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorPrimary
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 7.6)),
                      child: Text(
                        Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.peopleQlik?.answer??"",
                        style: GetFont.get(
                            context,
                            fontSize: 1.6,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorBlack
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: ScreenSize(context).widthOnly( 10)),
                child: Lottie.asset("assets/linesss.json",
                    width: ScreenSize(context).widthOnly( 100),
                    height: ScreenSize(context).heightOnly( 30),
                    reverse: true,
                    repeat: true),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
