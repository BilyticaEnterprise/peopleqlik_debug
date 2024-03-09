import 'package:flutter/material.dart';

class WaveClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    var temp=(size.height / 2);
    path.moveTo(0, size.height * 1);
    path.quadraticBezierTo(
        size.width / 2, (temp/3)+temp, size.width, size.height * 1);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}