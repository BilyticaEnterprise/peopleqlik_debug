import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
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
          fixedSize: Size(widget.width??double.infinity, widget.height??ScreenSize(context).heightOnly( 5)),
          primary: Color(widget.buttonColor??MyColor.colorPrimary),
          onPrimary: Color(widget.textColor??MyColor.colorWhite),//c
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
