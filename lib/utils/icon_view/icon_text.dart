import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/configs/colors.dart';

import '../dividers_screen/dividers.dart';
import '../../configs/fonts.dart';
import '../screen_sizes.dart';

class GetIconText extends StatelessWidget {
  final String icon;
  final String text;
  final double? textSize;
  final double? iconSize;
  final int? iconColor;
  final int? textColor;
  final FontWeight? fontWeight;
  const GetIconText({required this.text,required this.icon,this.textColor,this.fontWeight,this.iconColor,this.iconSize,this.textSize,super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.string(
          icon,
          height: ScreenSize(context).heightOnly(iconSize??2.2),
          width: ScreenSize(context).heightOnly(iconSize??2.2),
          colorFilter: iconColor!=null?ColorFilter.mode(Color(iconColor??MyColor.colorBlack), BlendMode.srcIn):null,
        ),
        const DividerByWidth(1),
        Text(
          text,
          style: GetFont.get(
              context,
              fontSize: textSize??1.6,
              fontWeight: FontWeight.w400,
              color: textColor??MyColor.colorBlack
          ),
        ),
      ],
    );
  }
}
