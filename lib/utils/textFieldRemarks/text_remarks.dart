import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class TextWidgetRemarks extends StatefulWidget {
  TextEditingController? controller;
  Key key;
  String? hintText;
  String? restrictionRegex;
  FocusScopeNode? focusNode;
  bool? isPasswordField=false;
  double? stroke;
  TextInputAction? textInputAction;
  EdgeInsetsGeometry? contentPadding;
  double? padding,height,margin;
  IconData? icon;
  bool? isEnabled;
  Function(String)? callBack;
  TextWidgetRemarks(this.controller,this.textInputAction,this.focusNode,this.key,this.hintText,{this.callBack,this.height,this.stroke,this.padding,this.contentPadding,this.icon,this.restrictionRegex,this.isPasswordField,this.isEnabled,this.margin}) : super(key: key);
  @override
  _TextWidgetRemarksState createState() => _TextWidgetRemarksState();
}

class _TextWidgetRemarksState extends State<TextWidgetRemarks> {
  bool hideText=true;
  @override
  Widget build(BuildContext context) {
    return Container(
        //height: ScreenSize(context).heightOnly(widget.height??6.5),
        margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(widget.margin??5.6)),
        padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(widget.padding??0.0)),
        decoration: ShapeDecoration(
          color: const Color(MyColor.colorWhite),
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: widget.stroke??1.2, style: BorderStyle.solid,
                color: Color(widget.isEnabled==false?MyColor.colorBackgroundDark:MyColor.colorBlack)
            ),
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                key: widget.key,
                controller: widget.controller,
                cursorColor: Colors.black,
                minLines: 4,
                onChanged: (text){
                  //PrintLogs.print('textttt $text');
                  if(widget.callBack!=null)
                  {
                    widget.callBack!(text);
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: widget.icon!=null?Icon(widget.icon!,size: ScreenSize(context).heightOnly( 2.5),):null,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    counterText: '',
                    contentPadding: widget.contentPadding,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: widget.hintText,
                    enabled: widget.isEnabled??true,
                    hintStyle: GetFont.get(
                      context,
                      fontSize:1.6,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorGrey3,
                    )
                ),
                textAlignVertical: TextAlignVertical.center,
                maxLines: 12,
                maxLength: 2000,
                obscureText: widget.isPasswordField==true?hideText:false,
                inputFormatters: widget.restrictionRegex!=null?<TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(widget.restrictionRegex!))
                ]:null,
                textInputAction: widget.textInputAction??TextInputAction.done,
                autocorrect: true,
                autofocus: false,
                keyboardType: TextInputType.text,
                textAlign: TextAlign.start,
                style: GetFont.get(
                  context,
                  fontSize:1.8,
                  fontWeight: FontWeight.w500,
                  color: MyColor.colorBlack,
                ),
              ),
            ),
            if(widget.isPasswordField==true)...[
              IconButton(icon: Icon(
                hideText?MdiIcons.eye:MdiIcons.eyeOff,
                size: ScreenSize(context).heightOnly(2.8),
                color: const Color(MyColor.colorGrey2),
              ),
                onPressed: (){
                  setState(() {
                    if(hideText) {
                      hideText=false;
                    } else {
                      hideText=true;
                    }
                  });
                },
              )
            ]
          ],
        )
    );

  }
}
