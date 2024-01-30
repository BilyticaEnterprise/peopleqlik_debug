import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../src/colors.dart';
import '../../../src/divider.dart';
import '../../../src/fonts.dart';
import '../../../src/screen_sizes.dart';

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
                const DividerVertical(2),
              ],
              Row(
                children: [
                  DividerHorizontal(6),
                  Expanded(child: ButtonIs(callBack: rejectCallBack,text: rejectText,icon: rejectIcon,iconSize: iconSize,textSize: textSize,textColor: rejectTextColor,buttonColor: rejectColor,borderDesign: true,)),
                  DividerHorizontal(4),
                  Expanded(child: ButtonIs(callBack: acceptCallBack,text: acceptText,icon: acceptIcon,iconSize: iconSize,textSize: textSize,textColor: acceptTextColor??MyColor.colorBlack,buttonColor: acceptColor,)),
                  DividerHorizontal(6),
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}
class ButtonIs extends StatelessWidget {
  final String text;
  final String? icon;
  final double? iconSize,textSize;
  final bool? borderDesign;
  final int? textColor;
  final int? buttonColor;
  final Function() callBack;
  const ButtonIs({required this.callBack,required this.text,this.icon,this.iconSize,this.buttonColor,this.textSize,this.borderDesign,this.textColor,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        border: borderDesign==true?Border.all(
          width: 1,
          color: const Color(MyColor.colorGrey0)
        ):null,
        color: borderDesign==true?null:Color(buttonColor??MyColor.colorPrimary)
      ),
      child: Material(
        color: const Color(MyColor.colorTransparent),
        borderRadius: const BorderRadius.all(Radius.circular(50)),
        child: InkWell(
          splashColor: const Color(MyColor.colorGrey0),
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          onTap: callBack,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(1.6)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                if(icon!=null)...[
                  SvgPicture.string(
                    icon!,
                    height: ScreenSize(context).heightOnly(iconSize??2),
                    width: ScreenSize(context).heightOnly(iconSize??2),
                    colorFilter: ColorFilter.mode(Color(textColor??MyColor.colorBlack), BlendMode.srcIn),
                  ),
                  const DividerHorizontal(2),
                ],
                Text(text,style: GetFont.get(
                    context,
                    fontSize: textSize??2,
                    fontWeight: FontWeight.w600,
                    color: textColor??MyColor.colorBlack
                ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

