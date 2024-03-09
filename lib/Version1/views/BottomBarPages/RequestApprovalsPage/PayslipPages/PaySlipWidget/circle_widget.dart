import 'dart:math';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class PaySlipCircleSpinner extends StatefulWidget {
  AnimationController? progressController;
  double? percent;
  double? spinnerSize;
  String? text;
  String? header;
  int? color;
  IconData? icon;
  PaySlipCircleSpinner({this.progressController,this.spinnerSize,this.header,this.text,this.percent,this.color,this.icon,Key? key}) : super(key: key);

  @override
  _PaySlipCircleSpinnerState createState() => _PaySlipCircleSpinnerState();
}

class _PaySlipCircleSpinnerState extends State<PaySlipCircleSpinner> with SingleTickerProviderStateMixin{
  late Animation animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.progressController = AnimationController(vsync: this,duration: const Duration(milliseconds: 1000));
    animation = Tween(begin: 0.0,end: widget.percent).animate(widget.progressController!)..addListener((){
      setState(() {

      });
    });
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Future.delayed(const Duration(milliseconds: 100),(){
        widget.progressController?.forward();
      });
    });
  }
  @override
  void dispose() {
    widget.progressController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          foregroundPainter: CircleProgress(
              double.parse(animation.value.toString()),
              widget.color
          ), // this will add custom painter after child
          child: SizedBox(
              width: ScreenSize(context).heightOnly( widget.spinnerSize??18),
              height: ScreenSize(context).heightOnly( widget.spinnerSize??18),
              child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(widget.header??'',style: GetFont.get(
                          context,
                          fontSize:2.8,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                      ),
                      ),
                      SizedBox(height: ScreenSize(context).heightOnly( 0.4),),
                      Text(widget.text??'',style: GetFont.get(
                          context,
                          fontSize:1.6,
                          fontWeight: FontWeight.w400,
                          color: MyColor.colorGrey3
                      ),
                      )
                    ],
                  )

          ),
        )
      ],
    );
  }
}


class CircleProgress extends CustomPainter{

  double currentProgress;
  int? color;

  CircleProgress(this.currentProgress,this.color);

  @override
  void paint(Canvas canvas, Size size) {

    final Gradient gradient = RadialGradient(
      colors: <Color>[
        const Color(0xffFFD11D).withOpacity(0.6),
        const Color(0xffFFD11D).withOpacity(0.8),
        const Color(0xffFFD11D).withOpacity(0.8),
        Colors.orangeAccent.withOpacity(0.7),
        Colors.orangeAccent.withOpacity(1.0),
      ],
      stops: const [
        0.0,
        0.2,
        0.6,
        0.8,
        1.0,
      ],
    );
    //this is base circle
    Paint outerCircle = Paint()
      ..strokeWidth = 18
      ..color = const Color(0xff6949C3).withOpacity(0.1)
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromCircle(
      center: const Offset(185.0, 75.0),
      radius: 150.0,
    );
    Paint completeArc = Paint()
      ..strokeWidth = 18
      ..color = Color(color!)
      ..style = PaintingStyle.stroke
      ..shader = gradient.createShader(rect)
      ..strokeCap  = StrokeCap.round;

    Offset center = Offset(size.width/2, size.height/2);
    double radius = min(size.width/2,size.height/2) - 10;

    canvas.drawCircle(center, radius, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (currentProgress/100);

    canvas.drawArc(Rect.fromCircle(center: center,radius: radius), -pi/2, angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}