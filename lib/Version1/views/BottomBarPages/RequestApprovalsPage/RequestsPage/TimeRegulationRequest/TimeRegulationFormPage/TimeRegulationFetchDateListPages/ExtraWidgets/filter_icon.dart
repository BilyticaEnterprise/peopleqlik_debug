import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../../../configs/colors.dart';
import 'package:badges/badges.dart' as badges;

import '../../../../../../../../../configs/icons.dart';
import '../../../../../../../../../utils/screen_sizes.dart';

class FilterWidget extends StatelessWidget {
  final Function() onTap;
  const FilterWidget(this.onTap,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: const Color(MyColor.colorTransparent),
        child: InkWell(
          splashColor: const Color(MyColor.colorGrey0),
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.8)),
            child: badges.Badge(
                position: badges.BadgePosition.topEnd(top: -ScreenSize(context).heightOnly(0.2), end: -ScreenSize(context).heightOnly(0.5)),
                badgeStyle: badges.BadgeStyle(
                  shape: badges.BadgeShape.circle,
                  padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.4)),
                  badgeColor: const Color(MyColor.colorPrimary),
                ),
                badgeAnimation: const badges.BadgeAnimation.scale(
                  animationDuration: Duration(milliseconds: 80),
                ),
                showBadge: true,
                badgeContent: SvgPicture.string(
                    SvgPicturesData.done,
                    color: const Color(MyColor.colorWhite),
                    width : ScreenSize(context).heightOnly(1.6)
                ),
                child: Padding(
                  padding: EdgeInsets.only(top: ScreenSize(context).heightOnly(0.6)),
                  child: SvgPicture.string(SvgPicturesData.filter,width: ScreenSize(context).heightOnly(3.6),height:ScreenSize(context).heightOnly(3.6),color: const Color(MyColor.colorBlack),),
                )
            )
          ),
        ),
      ),
    );
  }
}
