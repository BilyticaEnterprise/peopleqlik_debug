import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';

import '../../src/colors.dart';
import '../../src/divider.dart';
import '../../src/fonts.dart';
import '../../src/icons.dart';

class TextEmployeeChipWidget extends StatelessWidget {
  final Function()? removeCallBack;
  final String text;
  final double textSize;
  final double verticalPadding;
  const TextEmployeeChipWidget(this.text, {this.removeCallBack,this.verticalPadding = 0.8,this.textSize = 1.6,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderSize = 14;
    return Container(
      margin: EdgeInsets.all(ScreenSize(context).heightOnly(0.6)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(borderSize)),
          border: Border.all(
              width: 0.8,
              color: const Color(MyColor.colorT1)
          )
      ),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(borderSize)),
        color: const Color(MyColor.colorA5),
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(borderSize)),
          onTap: removeCallBack,
          child: Padding(
            padding: removeCallBack!=null?EdgeInsets.all(ScreenSize(context).heightOnly(0.8)):EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(verticalPadding),horizontal: ScreenSize(context).heightOnly(1.4)),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  text,
                  style: GetFont.get(
                      context,
                      fontSize: textSize??1.6,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorBlack
                  ),
                ),
                if(removeCallBack!=null)...[
                  const DividerHorizontal(2),
                  SvgPicture.string(
                    SvgPicturesData.cross,
                    color: const Color(MyColor.colorBlack),
                    width: ScreenSize(context).heightOnly(2.6),
                    height: ScreenSize(context).heightOnly(2.6),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}