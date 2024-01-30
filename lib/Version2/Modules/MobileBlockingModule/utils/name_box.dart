import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/colors.dart';

import '../../../../src/fonts.dart';
import '../../../../src/screen_sizes.dart';


class NameBox extends StatelessWidget {
  final String text;
  final int? boxColor;
  const NameBox({required this.text,this.boxColor, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize(context).heightOnly(4.8),
      width: ScreenSize(context).heightOnly(5),
      decoration: BoxDecoration(
        color: Color(boxColor??MyColor.colorA3),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
      child: Center(
        child: Text(
              text,
              style: GetFont.get(
                  context,
                color: MyColor.colorBlack,
                fontSize: 1.6,
                fontWeight: FontWeight.w600
              ),
          textAlign: TextAlign.center,
            ),
      ),


    );
  }
}
