import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/divider.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';

import '../Buttons/buttons.dart';

class NotAvailable extends StatelessWidget {
  String? lottieJson,header,description;
  double? topMargin;
  Widget? action;
  BoxFit? boxFit;
  double? height,width;
  NotAvailable(this.lottieJson,this.header,this.description,{Key? key,this.boxFit,this.action,this.topMargin,this.height,this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: ScreenSize(context).heightOnly( topMargin??0),),
        Lottie.asset("assets/$lottieJson.json",
            fit: boxFit,
            height: ScreenSize(context).heightOnly(height??18),width: ScreenSize(context).heightOnly(width??18),repeat: true),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 8.6)),
          child: Text(
            '$header',
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
            '$description',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w400,
                fontSize: 1.6,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        if(action!=null)...[
          const DividerVertical(4),
          action!
        ]
      ],
    );
  }
}

class NotAvailableSmall extends StatefulWidget {
  double? height,width;
  String? header,anim;
  NotAvailableSmall(this.header,this.anim,{Key? key,this.height,this.width,}) : super(key: key);

  @override
  State<NotAvailableSmall> createState() => _NotAvailableSmallState();
}

class _NotAvailableSmallState extends State<NotAvailableSmall> with TickerProviderStateMixin {
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
      children: [
        Lottie.asset(
          "assets/${widget.anim}.json",
          controller: _controller,
          height: ScreenSize(context).heightOnly( widget.height??18),width: ScreenSize(context).heightOnly(
            widget.width??18),
          onLoaded: (composition) {
            // Configure the AnimationController with the duration of the
            // Lottie file and start the animation.
            _controller
              ..duration = composition.duration
              ..forward();
            _controller.repeat();
          },
          repeat: true,
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 8.6)),
          child: Text(
            '${widget.header}',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w400,
                fontSize: 1.6,
                color: MyColor.colorBlack
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),

      ],
    );
  }
}

