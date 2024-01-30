import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/icons.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:provider/provider.dart';

class TextWidget extends StatefulWidget {
  TextEditingController? controller;
  Key key;
  TextInputType? textInputType;
  String? hintText;
  String? restrictionRegex;
  FocusScopeNode? focusNode;
  bool? isPasswordField=false;
  double? stroke;
  TextInputAction? textInputAction;
  EdgeInsetsGeometry? contentPadding;
  double? padding,height;
  IconData? icon;
  bool? searchIcon;
  bool? isEnabled;
  Function(String)? callBack;
  TextWidget(this.controller,this.textInputAction,this.focusNode,this.key,this.hintText,{this.callBack,this.searchIcon,this.height,this.stroke,this.padding,this.contentPadding,this.icon,this.restrictionRegex,this.isPasswordField,this.isEnabled,this.textInputType}) : super(key: key);
  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  bool hideText=true;
  @override
  Widget build(BuildContext context) {
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
    return Container(
      height: ScreenSize(context).heightOnly(widget.height??6.5),
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(5.6)),
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(widget.padding??0.0),vertical: 0),
        decoration: ShapeDecoration(
        color: const Color(MyColor.colorWhite),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: widget.stroke??1.2, style: BorderStyle.solid,
              color: Color(widget.isEnabled==false?MyColor.colorGrey7:MyColor.colorBlack)
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
              onChanged: (text){
                //PrintLogs.print('textttt $text');
                if(widget.callBack!=null)
                  {
                    widget.callBack!(text);
                  }
                if(widget.searchIcon==true)
                  {
                    if(text.isEmpty||text.length==1)
                      {
                        setState(() {

                        });
                      }
                  }
              },
              decoration: InputDecoration(
                  prefixIcon: widget.icon!=null?Icon(widget.icon!,size: ScreenSize(context).heightOnly( 2.5),):null,
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
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
              textAlignVertical: changeLanguage.languageEnum == LanguageEnum.arabic?TextAlignVertical.center:null,
              maxLines: 1,
              obscureText: widget.isPasswordField==true?hideText:false,
              inputFormatters: widget.restrictionRegex!=null?<TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(widget.restrictionRegex!))
              ]:null,
              textInputAction: widget.textInputAction??TextInputAction.done,
              autocorrect: true,
              autofocus: false,
              keyboardType: widget.textInputType??TextInputType.text,
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
          ],
          if(widget.searchIcon==true)...[
            if(widget.controller!=null&&widget.controller!.text.isNotEmpty)...[
              InkWell(
                onTap: (){
                  widget.controller?.clear();
                  setState(() {
                  });
                },
                child: SvgPicture.string(
                  SvgPicturesData.cross,
                  height: ScreenSize(context).heightOnly(2.8),
                  width: ScreenSize(context).heightOnly(2.8),
                  color: const Color(MyColor.colorGrey2),
                ),
              ),
            ],
            if(widget.controller!=null&&widget.controller!.text.isEmpty)...[
              SvgPicture.string(
                SvgPicturesData.search,
                height: ScreenSize(context).heightOnly(2.8),
                width: ScreenSize(context).heightOnly(2.8),
                color: const Color(MyColor.colorGrey2),
              )
            ],
          ]
        ],
      )
    );

  }
}
