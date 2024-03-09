import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../configs/colors.dart';
import '../../configs/prints_logs.dart';
import '../screen_sizes.dart';

class WebviewWidget extends StatefulWidget {
  String? url;
  WebviewWidget({required this.url,Key? key}) : super(key: key);

  @override
  State<WebviewWidget> createState() => _WebviewWidgetState();
}

class _WebviewWidgetState extends State<WebviewWidget> with TickerProviderStateMixin{
  WebViewController? controller;
  AnimationController? animationController;

  bool loading = false;

  int count = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel('Toaster', onMessageReceived: (onMessageReceived){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(onMessageReceived.message)),
        );
      })
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if(progress==100)
            {
              if(mounted){
                setState(() {
                  loading = false;
                });
              }
            }
          },
          onPageStarted: (String url) {
            if(mounted){
              setState(() {
                if(count==0)
                {
                  count++;
                  loading = true;
                }
              });
            }
          },
          onPageFinished: (String url) {
            if(mounted) {
              setState(() {
                loading = false;
              });
            }
            controller?.runJavaScript("javascript:(function() { var head = document.getElementsByTagName('header')[0];head.parentNode.removeChild(head);var footer = document.getElementsByTagName('footer')[0];footer.parentNode.removeChild(footer);var whatsApp = document.getElementsByTagName('WhatsApp us')[0];whatsApp.parentNode.removeChild(whatsApp);var ad = document.getElementsByTagName('chat widget')[0];ad.parentNode.removeChild(ad);javascript:document.getElementsByClassName('s_8 waves-effect waves-light ctc-analytics')[0].style.display=none;})()").then((value) => debugPrint('Page finished loading Javascript'))
                .catchError((onError) => debugPrint('$onError'));
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url!));
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Stack(
              children: [
                if(controller!=null)...[
                  WebViewWidget(
                    controller: controller!,
                  ),
                ],
                if(loading == true)...[
                  Material(
                    color: const Color(MyColor.colorWhite).withOpacity(0.9),
                    child: SafeArea(
                      top: false,
                      bottom: false,
                      left: false,
                      right: false,
                      child: LayoutBuilder(
                        builder: (context,constraints)
                        {
                          return SizedBox(
                              height: constraints.maxHeight,
                              width: constraints.maxWidth,
                              child: Center(child: Lottie.asset("assets/loader_1.json",
                                  controller: animationController,
                                  onLoaded: (composition) {
                                    // Configure the AnimationController with the duration of the
                                    // Lottie file and start the animation.
                                    animationController!
                                      ..duration = composition.duration
                                      ..forward();
                                    animationController!.repeat();
                                  },
                                  fit: BoxFit.fitWidth,height: ScreenSize(context).heightOnly(22),width: ScreenSize(context).heightOnly(22),repeat: true))

                          );
                        },
                      ),
                    ),
                  )
                ]
              ],
            )
        ),
      ],

    );
  }


}
