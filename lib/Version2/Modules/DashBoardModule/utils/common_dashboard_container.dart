import 'package:flutter/material.dart';

import '../../../../configs/colors.dart';
import '../../../../utils/screen_sizes.dart';

class CommonDashboardContainer extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final bool? noPadding;
  const CommonDashboardContainer({required this.child,this.onTap,this.noPadding,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(5.6),ScreenSize(context).heightOnly(1.5),ScreenSize(context).widthOnly(5.6),ScreenSize(context).heightOnly(2.0)),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(MyColor.colorPrimary),
            width: 1,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: const Color(MyColor.colorWhite),
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Material(
                color: const Color(MyColor.colorTransparent),
                child: InkWell(
                    onTap: onTap,
                    child: Padding(
                      padding: EdgeInsets.all(ScreenSize(context).heightOnly(noPadding!=true?1.6:0)),
                      child: child,
                    )
                )
            )
        )
    );
  }
}
