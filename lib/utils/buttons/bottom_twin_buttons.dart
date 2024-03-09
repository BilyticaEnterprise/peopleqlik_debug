import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../configs/colors.dart';
import '../dividers_screen/dividers.dart';
import '../../../configs/fonts.dart';
import '../../../utils/screen_sizes.dart';
import 'buttons.dart';

class BottomTwinButtons extends StatelessWidget {
  final String acceptText,rejectText;
  final String? acceptIcon,rejectIcon;
  final double? iconSize,textSize;
  final Widget? extraWidget;
  final int? backColor;
  final int? rejectColor,acceptColor;
  final int? rejectTextColor,acceptTextColor;
  final Function() acceptCallBack,rejectCallBack;
  const BottomTwinButtons({required this.acceptCallBack,this.extraWidget,this.backColor,required this.rejectCallBack,required this.acceptText,required this.rejectText,this.acceptIcon,this.rejectIcon,this.iconSize,this.textSize,this.acceptColor,this.rejectColor,this.acceptTextColor,this.rejectTextColor,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(backColor??MyColor.colorTransparent),
      child: SafeArea(
        bottom: true,
        top: false,
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom>0?0:ScreenSize(context).heightOnly(4.4),top: ScreenSize(context).heightOnly(2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(extraWidget!=null)...[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6)),
                  child: extraWidget!,
                ),
                const DividerByHeight(2),
              ],
              Row(
                children: [
                  DividerByWidth(6),
                  Expanded(child: ButtonMaterialIs(callBack: rejectCallBack,text: rejectText,icon: rejectIcon,iconSize: iconSize,textSize: textSize,textColor: rejectTextColor,borderColor: rejectColor,borderDesign: true,)),
                  DividerByWidth(4),
                  Expanded(child: ButtonMaterialIs(callBack: acceptCallBack,text: acceptText,icon: acceptIcon,iconSize: iconSize,textSize: textSize,textColor: acceptTextColor??MyColor.colorWhite,buttonColor: acceptColor,)),
                  DividerByWidth(6),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}

class TwinButtonsOnly extends StatelessWidget {
  final String acceptText,rejectText;
  final String? acceptIcon,rejectIcon;
  final double? iconSize,textSize;
  final int? rejectColor,acceptColor;
  final int? rejectTextColor,acceptTextColor;
  final Function() acceptCallBack,rejectCallBack;
  final double? paddingHorizontally;
  final double? buttonTextPaddingVertically;
  const TwinButtonsOnly({required this.acceptCallBack,required this.rejectCallBack,required this.acceptText,required this.rejectText,this.acceptIcon,this.rejectIcon,this.buttonTextPaddingVertically,this.iconSize,this.textSize,this.acceptColor,this.paddingHorizontally,this.rejectColor,this.acceptTextColor,this.rejectTextColor,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(ScreenSize(context).widthOnly(paddingHorizontally??0)),
      child: Row(
        children: [
          Expanded(child: ButtonMaterialIs(callBack: rejectCallBack,text: rejectText,icon: rejectIcon,iconSize: iconSize,textSize: textSize,textColor: rejectTextColor,borderColor: rejectColor,borderDesign: true,verticalPadding: buttonTextPaddingVertically,)),
          const DividerByWidth(4),
          Expanded(child: ButtonMaterialIs(callBack: acceptCallBack,text: acceptText,icon: acceptIcon,iconSize: iconSize,textSize: textSize,textColor: acceptTextColor??MyColor.colorWhite,buttonColor: acceptColor,verticalPadding: buttonTextPaddingVertically,)),
        ],
      ),
    );
  }
}
