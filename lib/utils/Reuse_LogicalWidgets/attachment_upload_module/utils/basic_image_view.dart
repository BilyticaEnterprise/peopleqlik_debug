import 'package:flutter/material.dart';

import '../../../../configs/colors.dart';
import '../../../screen_sizes.dart';

class BasicImageView extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  const BasicImageView({required this.child,this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: key,
      width: ScreenSize(context).heightOnly(14),
      margin: EdgeInsets.only(top: ScreenSize(context).heightOnly(3),bottom: ScreenSize(context).heightOnly(4)),
      decoration: BoxDecoration(
        color: const Color(MyColor.colorWhite),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        //color: const Color(MyColor.colorWhite),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 0.0,
              blurRadius: 14,
              offset: const Offset(3.0, 3.0)),
          BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 0.0,
              blurRadius: 14 / 2.0,
              offset: const Offset(3.0, 3.0)),
          BoxShadow(
              color: Colors.grey.shade50,
              spreadRadius: 2.0,
              blurRadius: 14,
              offset: const Offset(0.0, -3.0)),
          BoxShadow(
              color: Colors.grey.shade50,
              spreadRadius: 2.0,
              blurRadius: 14 / 2,
              offset: const Offset(0.0, -3.0)),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Material(
          color: const Color(MyColor.colorWhite),
          child: InkWell(
              splashColor: const Color(MyColor.colorGrey0),
              onTap: onTap,
              child: child
          ),
        ),
      ),
    );
  }
}
