import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

import '../../../BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import '../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../src/colors.dart';
import '../../../src/fonts.dart';
import '../../../src/icons.dart';
import '../../../src/language_codes.dart';
import '../../../src/screen_sizes.dart';
import 'ErrorHandler/error_text_handler.dart';
import 'Listeners/text_field_controller.dart';


class TextWidgetLatest extends StatefulWidget {
  String textFieldHeader;
  double? margin;
  bool? isCompulsory;
  TextFieldControllerCall? controller;
  Key? key;
  TextInputType? textInputType;
  String? hintText;
  String? restrictionRegex;
  FocusNode? focusNode;
  bool? isPasswordField=false;
  double? stroke;
  TextInputAction? textInputAction;
  EdgeInsetsGeometry? contentPadding;
  double? padding,height;
  IconData? icon;
  bool? searchIcon;
  bool? isEnabled,showCalender,onTap,isPhoneNumber;
  DateTime? minYears,maxYears;
  String? extraText;
  int? maxLines;
  bool? noHeader;
  Function(String)? callBack;
  TextWidgetLatest(this.controller,this.textInputAction,this.focusNode,this.key,this.hintText,{this.noHeader,this.maxLines,this.extraText,this.maxYears,this.isPhoneNumber,this.onTap,this.margin,required this.textFieldHeader,this.isCompulsory,this.callBack,this.searchIcon,this.height,this.stroke,this.padding,this.icon,this.restrictionRegex,this.isPasswordField,this.isEnabled,this.textInputType,this.showCalender,this.minYears}) : super(key: key);
  @override
  _TextWidgetLatestState createState() => _TextWidgetLatestState();
}

class _TextWidgetLatestState extends State<TextWidgetLatest> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ErrorNotifierListener>(create: (_) => ErrorNotifierListener()),
        ],
        child: ShowTextWidget(widget.controller,widget.textInputAction,widget.focusNode,widget.key,widget.hintText,noHeader: widget.noHeader,maxLines: widget.maxLines,extraText: widget.extraText,isPhoneNumber: widget.isPhoneNumber,maxYears: widget.maxYears, margin: widget.margin,textFieldHeader: widget.textFieldHeader,isCompulsory:widget.isCompulsory,callBack:widget.callBack,searchIcon:widget.searchIcon,height:widget.height,stroke:widget.stroke,padding:widget.padding,contentPadding:widget.contentPadding,icon:widget.icon,restrictionRegex:widget.restrictionRegex,isPasswordField:widget.isPasswordField,isEnabled:widget.isEnabled,textInputType:widget.textInputType,onTap: widget.onTap,showCalender: widget.showCalender,minYears: widget.minYears,));
  }

}
class ShowTextWidget extends StatefulWidget {
  String textFieldHeader;
  double? margin;
  bool? isCompulsory;
  bool? noHeader;
  TextFieldControllerCall? controller;
  Key? key;
  TextInputType? textInputType;
  String? hintText;
  String? restrictionRegex;
  FocusNode? focusNode;
  bool? isPasswordField=false,isPhoneNumber=false;
  double? stroke;
  TextInputAction? textInputAction;
  EdgeInsetsGeometry? contentPadding;
  double? padding,height;
  IconData? icon;
  bool? searchIcon,onTap;
  String? extraText;
  bool? isEnabled,showCalender;
  DateTime? minYears,maxYears;
  int? maxLines;
  Function(String)? callBack;
  //Function(bool)? callError;
  ShowTextWidget(this.controller,this.textInputAction,this.focusNode,this.key,this.hintText,{this.noHeader,this.maxLines,this.extraText,this.isPhoneNumber,this.maxYears,this.onTap,this.margin,required this.textFieldHeader,this.isCompulsory,this.callBack,this.searchIcon,this.height,this.stroke,this.padding,this.contentPadding,this.icon,this.restrictionRegex,this.isPasswordField,this.isEnabled,this.textInputType,this.showCalender,this.minYears}) : super(key: key);
  @override
  State<ShowTextWidget> createState() => _ShowTextWidgetState();
}

class _ShowTextWidgetState extends State<ShowTextWidget> {
  bool hideText=true;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
    return Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(widget.margin??5.6)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.noHeader != true)...[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
                      child:
                      Row(children: [
                        Text(
                          widget.textFieldHeader??'',
                          style: GetFont.get(
                              context,
                              fontSize: 1.6,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                        ),
                        //Expanded(child: Container(),),
                        if(widget.isCompulsory==true)...
                        [
                          SizedBox(width: ScreenSize(context).heightOnly( 1),),
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: Material(
                              color: const Color(MyColor.colorSecondary).withOpacity(0.8),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(1),vertical: ScreenSize(context).heightOnly( 0.3)),
                                child: Text(
                                  '${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra2)}',
                                  style: GetFont.get(
                                      context,
                                      fontSize: 1.0,
                                      fontWeight: FontWeight.w600,
                                      color: MyColor.colorWhite
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ],
                      )
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                ],
                Container(
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
                            controller: widget.controller?.textEditingController,
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
                          if(widget.controller!=null&&widget.controller!.textEditingController.text.isNotEmpty)...[
                            InkWell(
                              onTap: (){
                                widget.controller?.textEditingController.clear();
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
                          if(widget.controller!=null&&widget.controller!.textEditingController.text.isEmpty)...[
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
                )
              ],
            ),
          );

  }
}


class CaseFormatting extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
        text: newValue.text,
        selection: newValue.selection
    );
  }
}

