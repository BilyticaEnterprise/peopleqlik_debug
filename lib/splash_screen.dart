import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool animateNow=false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CheckInternetConnection>(context,listen: false).initConnectivity();
      init();
    });
  }
  init()
  {
    Future.delayed(const Duration(milliseconds: 2000),(){
      setState(() {
        animateNow=true;
      });

      startNextStep();

    });

  }
  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
          backgroundColor: const Color(MyColor.colorWhite),
          body: SafeArea(
            bottom: true,
            top: true,
            right: true,
            left: true,
            child: Stack(
              children: [
                Align(
                  child:
                    Lottie.asset("assets/bgstart.json",
                        height: double.infinity,width: double.infinity,repeat: false),

                ),
                Align(
                  alignment: Alignment.center,
                  child: AnimatedOpacity(
                    opacity: animateNow? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 1000),
                    child: SizedBox(
                      width: ScreenSize(context).heightOnly(34),
                      // width: MediaQuery.of(GetNavigatorStateContext.navigatorKey.currentState!.context).size.height/100*34,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
  void startNextStep() async {
    await Provider.of<SettingsModelListener>(context,listen: false).getSettingsData();
    Future.delayed(const Duration(milliseconds: 2500),(){
        GetNavigatorStateContext.navigatorKey.currentState!.pushReplacementNamed(CurrentPage.SettingsPage);
    });
  }
}
