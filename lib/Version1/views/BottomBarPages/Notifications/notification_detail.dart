import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/utils/Webview_Html_Widget/html_widget.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/get_assets.dart';
import '../../../../../utils/Appbars/app_bar.dart';

class NotificationDetailPage extends StatelessWidget {
  NotificationDetailPage({Key? key}) : super(key: key);
  String? notification;
  @override
  Widget build(BuildContext context) {
    notification = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      backgroundColor: const Color(MyColor.colorWhite),
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: false,
                  floating: true,
                  backgroundColor: const Color(MyColor.colorWhite),
                  snap: true,
                  elevation: 2,
                  titleSpacing: 0,
                  title: AppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.notificationsDetail)}')
              ),
            ];
          },
          body: Consumer<CheckInternetConnection>(
              builder: (context, data, child) {
                if (data.internetConnectionEnum ==
                    InternetConnectionEnum.available) {
                  return  BodyData(notification);
                }
                else {
                  return NotAvailable(
                    GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}',
                    '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}', topMargin: 8,
                    width: 50,
                    height: 24,);
                }
              }
          ),
        ),

    );
  }
}
class BodyData extends StatelessWidget {
  final String? notification;
  const BodyData(this.notification, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: ScreenSize(context).heightOnly( 100),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: ScreenSize(context).heightOnly( 1),),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 3.6)),
                        child: HtmlDetailWidget(notification)
                    ),
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( window.viewPadding.bottom>0?16:18),),
                ],
              ),
            ),
          ],
        )
    );
  }
}
