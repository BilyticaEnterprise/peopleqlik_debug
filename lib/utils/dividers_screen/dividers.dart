import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class DividerByHeight extends StatelessWidget {
  final double height;
  const DividerByHeight(this.height,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: ScreenSize(context).heightOnly(height),);
  }
}

class DividerByWidth extends StatelessWidget {
  final double width;
  const DividerByWidth(this.width,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: ScreenSize(context).widthOnly(width),);
  }
}
