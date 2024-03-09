import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import '../screen_sizes.dart';

class HorizontalLine extends StatelessWidget {
  final int? color;
  final double? width;
  final double? lineHeight;
  final double? marginVertical;
  final double? marginHorizontal;
  final double? borderRadius;
  const HorizontalLine({this.color,this.width,this.marginVertical,this.borderRadius,this.lineHeight,this.marginHorizontal,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize(context).heightOnly(lineHeight??0.15),
      margin: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(marginVertical??2),horizontal: ScreenSize(context).widthOnly(marginHorizontal??0)),
      width: width??double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(borderRadius??10)),
        color: Color(color??MyColor.colorBackgroundDark),
      ),
    );
  }
}
