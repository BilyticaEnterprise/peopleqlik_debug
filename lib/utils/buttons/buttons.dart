import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../dividers_screen/dividers.dart';
class ButtonWidget extends StatefulWidget {
  double? height,width,textSize;
  double? margin;
  double? paddingHorizontal;
  String text;
  int? textColor,buttonColor;
  FontWeight? weight;
  double? elevation;
  VoidCallback onPressed;
  ButtonWidget({required this.onPressed,required this.text,this.margin,this.elevation,this.width,this.height,this.textColor,this.textSize,this.paddingHorizontal,this.buttonColor,this.weight});

  @override
  _ButtonWidgetState createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width??double.infinity,
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(widget.margin??0)),
      child: ElevatedButton(
        onPressed: widget.onPressed,
        style: ElevatedButton.styleFrom(
            foregroundColor: Color(widget.textColor??MyColor.colorWhite),
            backgroundColor: Color(widget.buttonColor??MyColor.colorPrimary),
            fixedSize: Size(widget.width??double.infinity, ScreenSize(context).heightOnly( widget.height??5)),//c
            padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal??10),
            textStyle: GetFont.get(
              context,
              fontSize: widget.textSize??1.6,
              fontWeight: widget.weight??FontWeight.w400,
            ),

            elevation: widget.elevation??4,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50))
        ),
        child: Text(widget.text),
      ),
    );
  }
}

class ButtonCustom extends StatefulWidget {
  double? height,width,textSize;
  double? paddingHorizontal;
  String text;
  int? textColor,buttonColor;
  FontWeight? weight;
  VoidCallback onPressed;
  ButtonCustom({required this.onPressed,required this.text,this.width,this.height,this.textColor,this.textSize,this.paddingHorizontal,this.buttonColor,this.weight});

  @override
  _ButtonCustomState createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(widget.text),
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
          foregroundColor: Color(widget.textColor??MyColor.colorWhite),
          backgroundColor: Color(widget.buttonColor??MyColor.colorPrimary),
          fixedSize: Size(widget.width??double.infinity, widget.height??ScreenSize(context).heightOnly( 5)),//c
          padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizontal??10),
          textStyle: GetFont.get(
            context,
            fontSize: widget.textSize??1.6,
            fontWeight: widget.weight??FontWeight.w400,
          ),

          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15))
      ),
    );
  }
}

class ButtonMaterialIs extends StatelessWidget {
  final String text;
  final String? icon;
  final double? iconSize,textSize;
  final bool? borderDesign;
  final int? textColor;
  final int? buttonColor;
  final int? borderColor;
  final double? verticalPadding;
  final Function() callBack;
  const ButtonMaterialIs({required this.callBack,required this.text,this.borderColor,this.verticalPadding,this.icon,this.iconSize,this.buttonColor,this.textSize,this.borderDesign,this.textColor,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(50)),
          border: borderDesign==true?Border.all(
              width: 1,
              color: Color(borderColor??MyColor.colorGrey0)
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
            padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(verticalPadding??1.6)),
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
                  const DividerByWidth(2),
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