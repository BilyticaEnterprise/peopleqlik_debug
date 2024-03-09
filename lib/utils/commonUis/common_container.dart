import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import '../screen_sizes.dart';

class CommonContainer extends StatelessWidget {
  final Widget child;
  final double? paddingAll;
  final double? horizontalMargin;
  final int? borderColor;
  final Function()? onTap;
  const CommonContainer({required this.child,this.paddingAll,this.onTap,this.horizontalMargin,this.borderColor,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(horizontalMargin??5.6)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
              color: Color(borderColor??MyColor.colorBackgroundDark),
              width: 0.7
          )
      ),
      child: Material(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: const Color(MyColor.colorWhite),
            child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                splashColor: const Color(MyColor.colorBackgroundLight),
                focusColor: const Color(MyColor.colorBackgroundLight),
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.all(ScreenSize(context).heightOnly(paddingAll??2)),
                  child: child,
                )
            )
        ),
    );
  }
}
