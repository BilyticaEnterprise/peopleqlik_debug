import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/configs/colors.dart';

class CurvePainter extends CustomPainter {
  Color? color;
  CurvePainter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color??const Color(MyColor.colorPrimary);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();
    var temp=(size.height / 2);
    path.moveTo(0, size.height * 0.61);
    path.quadraticBezierTo(
        size.width / 2, (temp/3.0)+temp, size.width, size.height * 0.61);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
class CurvePainterN extends CustomPainter {
  Color? color;
  CurvePainterN({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color??const Color(MyColor.colorPrimary);
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();
    var temp=(size.height / 2);
    path.moveTo(0, size.height * 1.00);
    path.quadraticBezierTo(
        size.width / 2, (temp/3.0)+temp, size.width, size.height * 1.00);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}