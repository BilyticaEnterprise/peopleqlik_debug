import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class GetIconOnly extends StatelessWidget {
  final String icon;
  final double size;
  final int color;
  const GetIconOnly({this.color = MyColor.colorBlack,this.size = 3,required this.icon,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.string(
      icon,
      height: ScreenSize(context).heightOnly(size),
      width: ScreenSize(context).heightOnly(size),
      colorFilter: ColorFilter.mode(Color(color), BlendMode.srcIn),
    );
  }
}
