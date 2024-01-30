import 'package:flutter/material.dart';

import '../../../src/colors.dart';
import '../../../src/divider.dart';
import '../../../src/screen_sizes.dart';
import 'buttons.dart';

class BottomSingleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool? elevation;
  final int? buttonColor;
  final int? textColor;
  final int? backGroundColor;
  final Widget? actionWidget;
  const BottomSingleButton({this.buttonColor,this.elevation = false,this.actionWidget,this.backGroundColor,this.textColor,required this.text,required this.onPressed,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(backGroundColor??MyColor.colorTransparent),
          boxShadow: elevation==true?[
            const BoxShadow(
                offset: Offset(0,3),
                color: Color(MyColor.colorGrey0),
                spreadRadius: 4,
                blurRadius: 4
            )
          ]:null
      ),
      child: SafeArea(
        bottom: true,
        top: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom>0?0:ScreenSize(context).heightOnly(4.4),top: ScreenSize(context).heightOnly(2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(actionWidget!=null)...[
                actionWidget!,
                const DividerVertical(2),
              ],
              ButtonWidget(text: text,buttonColor: buttonColor??MyColor.colorPrimary,textSize: 2.2,textColor: textColor??MyColor.colorWhite,height: 6.5,paddingHorizontal: ScreenSize(context).heightOnly(1.2),weight: FontWeight.w600,onPressed: onPressed,margin: 6,elevation: 0,),
            ],
          )
        ),
      ),
    );
  }
}
