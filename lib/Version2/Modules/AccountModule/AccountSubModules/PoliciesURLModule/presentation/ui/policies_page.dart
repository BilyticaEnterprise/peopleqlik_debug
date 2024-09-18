import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../../../../utils/Webview_Html_Widget/webview_widget.dart';
import '../../../../../../../configs/get_assets.dart';
import '../../../../../../../utils/Appbars/app_bar.dart';

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
              return NotAvailable(GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
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