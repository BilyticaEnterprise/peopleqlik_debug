import 'package:flutter/material.dart';

import '../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import '../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../../Reuse_Widgets/webview_widget.dart';

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
