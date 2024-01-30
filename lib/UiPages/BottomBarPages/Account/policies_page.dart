import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Reuse_Widgets/webview_widget.dart';

class PolicyPage extends StatelessWidget {
  PolicyPage({Key? key}) : super(key: key);
  PolicyPageData? policyPageData;
  @override
  Widget build(BuildContext context) {
    policyPageData = ModalRoute.of(context)!.settings.arguments as PolicyPageData;
    return Scaffold(
      backgroundColor: const Color(MyColor.colorWhite),
      appBar: AppBar(
          automaticallyImplyLeading: false,
          // pinned: false,
          // floating: true,
          backgroundColor: const Color(MyColor.colorWhite),
         // snap: true,
          elevation: 0,
          titleSpacing: 0,
          title: AppBarWidget("${CallLanguageKeyWords.get(context, LanguageCodes.about)}")
      ),

      body:Consumer<CheckInternetConnection>(
          builder: (context,data,child) {
            if(data.internetConnectionEnum == InternetConnectionEnum.available)
            {
              return BodyData(policyPageData?.url);

            }
            else
            {
              return NotAvailable(GetVariable.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
            }
          }
      ),
    );
  }
}
class BodyData extends StatefulWidget {
  final String? url;
  const BodyData(this.url, {Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> with TickerProviderStateMixin{
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  dynamic animationController;

  WebViewController? _webViewController;
  bool loading = false;
  int count = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WebviewWidget(url: widget.url,);
  }

}

class PolicyPageData
{
  String header,url;
  PolicyPageData(this.header,this.url);
}