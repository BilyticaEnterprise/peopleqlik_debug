import 'package:flutter/material.dart';

import '../../../src/colors.dart';
import '../../../src/fonts.dart';
import '../../../src/screen_sizes.dart';

class MainHeaderWidget extends StatelessWidget {
  final String text;
  final bool? noSpacing;
  const MainHeaderWidget({required this.text,this.noSpacing,super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(noSpacing==true?0:6),vertical: ScreenSize(context).heightOnly(noSpacing==true?0:1.2)),
      child: Text(
        text,
        style: GetFont.get(
            context,
            fontWeight: FontWeight.w700,
            color: MyColor.colorBlack,
            fontSize: 2.4
        ),
      ),
    );
  }
}
