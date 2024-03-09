import 'dart:math';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class CircleSpinner extends StatefulWidget {
  AnimationController? progressController;
  double? percent;
  double? spinnerSize;
  String? text;
  String? extraText;
  int? color;
  IconData? icon;
  CircleSpinner({this.progressController,this.spinnerSize,this.extraText,this.text,this.percent = 1.0,this.color,this.icon,Key? key}) : super(key: key);

  @override
  _CircleSpinnerState createState() => _CircleSpinnerState();
}

class _CircleSpinnerState extends State<CircleSpinner> with TickerProviderStateMixin{
  // AnimationController? progressController;
  Animation<double>? animation;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      try{
        animation = Tween(begin: 0.0,end: widget.percent).animate(widget.progressController!);
        Future.delayed(const Duration(milliseconds: 150),(){
          if(mounted)
            {
              widget.progressController?.forward();
              animation?.addListener((){
                if(mounted&&widget.progressController?.isDismissed==false) {
                  setState(() {

                  });
                }
              });
            }
        });
        // Future.delayed(const Duration(milliseconds: 100),(){
        //
        // });
      }catch(e){}
    });
    super.initState();

  }

  @override
  Widget build(BuildContext context) {

   // PrintLogs.printLogs('wwwww ${widget.percent}');
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomPaint(
          foregroundPainter: CircleProgress(
              animation?.value??0.0,
              widget.color
          ), // this will add custom painter after child
          child: SizedBox(
              width: ScreenSize(context).heightOnly( widget.spinnerSize??18),
              height: ScreenSize(context).heightOnly( widget.spinnerSize??18),
              child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.text??"00 : 00",
                        style: GetFont.get(
                            context,
                            fontSize:3.4,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorBlack
                        ),
                      ),
                      Text(widget.extraText??"00",
                        style: GetFont.get(
                            context,
                            fontSize: 1.8,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorPrimary
                        ),
                      )
                    ],
                  )
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
        const Color(MyColor.colorPrimary).withOpacity(0.3),
        const Color(MyColor.colorPrimary).withOpacity(0.4),
        const Color(MyColor.colorPrimary).withOpacity(0.5),
        Colors.green.withOpacity(0.5),
        Colors.green.withOpacity(0.7),
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
      ..color = const Color(MyColor.colorSecondary).withOpacity(0.1)
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