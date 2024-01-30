import 'package:flutter/material.dart';

import '../../src/colors.dart';
import '../../src/screen_sizes.dart';

class HorizontalLine extends StatelessWidget {
  final int? color;
  final double? width;
  final double? marginVertical;
  final double? marginHorizontal;
  const HorizontalLine({this.color,this.width,this.marginVertical,this.marginHorizontal,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize(context).heightOnly(0.15),
      margin: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(marginVertical??2),horizontal: ScreenSize(context).widthOnly(marginHorizontal??0)),
      width: width??double.infinity,
      color: Color(MyColor.colorGrey7),
    );
  }
}
