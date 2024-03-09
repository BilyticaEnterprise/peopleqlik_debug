import 'package:flutter/material.dart';

import '../../configs/colors.dart';
import '../screen_sizes.dart';

class ContainerDesign1 extends StatelessWidget {
  final Function()? onTap;
  final Widget child;
  const ContainerDesign1({this.onTap,required this.child,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: const Color(MyColor.colorBackgroundDark),
            width: 1,
          ),
      ),
      child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          child: Material(
              color: const Color(MyColor.colorWhite),
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: EdgeInsets.all(ScreenSize(context).heightOnly(1.5)),
                  child: child,
                ),
              )
          )
      ),
    );
  }
}
