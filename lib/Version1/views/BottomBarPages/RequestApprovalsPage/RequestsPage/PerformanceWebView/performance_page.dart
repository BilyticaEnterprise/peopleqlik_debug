import 'package:flutter/material.dart';

import '../../../../../../Version1/models/RequestsModel/request_data_taker.dart';
import '../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../../utils/Webview_Html_Widget/webview_widget.dart';

class PerformancePage extends StatelessWidget {
  PerformancePage({Key? key}) : super(key: key);

  RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)?.settings.arguments as RequestDataTaker?;
    return GetPageStarterScaffoldWithOutSliverAppBar(
      title: '',
      body: BodyData(requestDataTaker?.extraData),
    );
  }
}
class BodyData extends StatelessWidget {
  final String? url;
  const BodyData(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WebviewWidget(url: url,);
  }
}
