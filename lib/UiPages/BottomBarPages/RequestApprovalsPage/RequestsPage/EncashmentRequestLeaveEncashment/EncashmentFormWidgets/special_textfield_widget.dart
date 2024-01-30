import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestLeaveEncashmentListeners/request_encashment_form_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/text_widgets.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';

class SpecialRequestTextField extends StatefulWidget {
  final FocusScopeNode nodeFocus;
  final TextInputType? textInputType;
  final RequestEnCashmentData? requestEnCashmentData;
  const SpecialRequestTextField(this.requestEnCashmentData,this.nodeFocus,{Key? key,this.textInputType}) : super(key: key);

  @override
  State<SpecialRequestTextField> createState() => _SpecialRequestTextFieldState();
}

class _SpecialRequestTextFieldState extends State<SpecialRequestTextField> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    if(widget.requestEnCashmentData?.data!=null&&widget.requestEnCashmentData!.data!.isNotEmpty)
    {
      textEditingController.text = '${widget.requestEnCashmentData!.data!}';
      response(textEditingController.text);
    }
    super.initState();
  }
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
            child:
            Row(children: [
              Text(
                widget.requestEnCashmentData?.title??'',
                style: GetFont.get(
                    context,
                    fontSize: 1.6,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                ),
              ),
              //Expanded(child: Container(),),
              if(widget.requestEnCashmentData?.isRequired==true)...
              [
                SizedBox(width: ScreenSize(context).heightOnly( 1),),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Material(
                    color: const Color(MyColor.colorSecondary).withOpacity(0.8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1),vertical: ScreenSize(context).heightOnly( 0.3)),
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
            ],)

        ),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        TextWidget(textEditingController,TextInputAction.done,widget.nodeFocus, Key('Key${widget.requestEnCashmentData?.title}'),'Write ${widget.requestEnCashmentData?.title}',padding: 4,stroke: 0.8,height: 6.2,callBack: response,isEnabled:widget.requestEnCashmentData?.isEnable,textInputType: TextInputType.number,restrictionRegex: r'^[0-9]+$',),
      ],
    );
  }

  void response(String text)
  {
    if(text.isNotEmpty) {
      widget.requestEnCashmentData?.callBack!(RequestEnCashmentCallBack(index: widget.requestEnCashmentData!.index,data: text));
    }
  }
}