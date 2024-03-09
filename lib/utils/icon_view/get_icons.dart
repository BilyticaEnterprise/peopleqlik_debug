import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../configs/colors.dart';

class GetIcons extends StatelessWidget {
  final String icon;
  final double size;
  final int iconColor;
  final int? backgroundColor;
  final Function()? onTap;
  final bool? noPadding,noColor;
  final double? radius;
  final BorderRadius? borderRadius;
  final double? paddingAll;
  final double opacity;
  const GetIcons({this.opacity = 1.0,this.paddingAll,this.noColor,this.borderRadius,this.radius,this.backgroundColor,this.noPadding,this.onTap,this.iconColor = MyColor.colorBlack,this.size = 3,required this.icon,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius??BorderRadius.all(Radius.circular(radius??100)),
      child: Material(
        color: Color(backgroundColor??MyColor.colorTransparent).withOpacity(opacity),
        child: InkWell(
          onTap: onTap,
          splashColor: const Color(MyColor.colorGrey0),
          child: Padding(
            padding: EdgeInsets.all(noPadding==true?0:ScreenSize(context).heightOnly(paddingAll??size/100*44)),
            child: SvgPicture.string(
              icon,
              height: ScreenSize(context).heightOnly(size),
              width: ScreenSize(context).heightOnly(size),
              colorFilter: noColor==true?null:ColorFilter.mode(Color(iconColor),BlendMode.srcIn),
            ),
          ),
        ),
      ),
    );
  }
}
