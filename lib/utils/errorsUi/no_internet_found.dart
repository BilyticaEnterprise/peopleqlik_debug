import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class NoInternetJustAnim extends StatefulWidget {
  String? lottieJson,header,description;
  double? topMargin;
  double? height,width;
  NoInternetJustAnim(this.lottieJson,this.header,this.description,{Key? key,this.topMargin,this.height = 24,this.width}) : super(key: key);

  @override
  State<NoInternetJustAnim> createState() => _NoInternetJustAnimState();
}

class _NoInternetJustAnimState extends State<NoInternetJustAnim> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: ScreenSize(context).heightOnly(widget.topMargin??0),),
        Lottie.asset("assets/${widget.lottieJson}.json",
            height: ScreenSize(context).heightOnly(widget.height??18),width: ScreenSize(context).heightOnly(widget.width??18),repeat: true),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 8.6)),
          child: Text(
            '${widget.header}',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w600,
                fontSize: 2.2,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 1.5),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 8.6)),
          child: Text(
            '${widget.description}',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w400,
                fontSize: 1.6,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),

      ],
    );
  }
}
