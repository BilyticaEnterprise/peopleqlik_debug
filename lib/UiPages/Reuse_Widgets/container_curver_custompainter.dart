import 'dart:math';

import 'package:flutter/material.dart';

class CurveCustomClipper extends CustomClipper<Path> {
  double radius = 50;
  @override
  Path getClip(Size size) {
    // var controlPoint = Offset(size.width/100*20, size.height/2);
    // var endPoint = Offset(0, size.height);
    //
    // Path path = Path()
    //   ..moveTo(size.width / 2, 0)
    //  // ..lineTo(0, size.height)
    // ..quadraticBezierTo(
    //       controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
    //   ..lineTo(size.width, size.height)
    //   ..close();
    //
    // return path;
    Path path = Path()  // Start from (0,0)
      ..moveTo(0, 0)   // move path point to (w/2,0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height/100*94-((size.height/100*88)/100*20))
      ..arcTo(Rect.fromCircle(center: Offset(size.width - radius, size.height/100*88 - radius), radius: radius), 0, 0.5 * pi, false)
      ..lineTo((size.width/100*20), size.height/100*88)
      ..arcTo(Rect.fromCircle(center: Offset(0+radius, ((size.height/100*88)+radius)), radius: radius), 1 * pi, 0.5 * pi, true)
    //..arcTo(Rect.fromCircle(center: Offset((size.width/100*13), ((size.height/100*88)/100*116)), radius: radius), 1 * pi, 0.5 * pi, true)
      ..lineTo((size.width/100*20), size.height/100*88)
      ..lineTo(0, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}