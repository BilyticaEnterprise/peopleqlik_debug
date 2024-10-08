import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_form_listener.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/TextFields/LegacyTextFields/text_widgets.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class SeparationRequestTextField extends StatefulWidget {
  final FocusScopeNode nodeFocus;
  final TextInputType? textInputType;
  final RequestSeparationData? requestSeparationData;
  const SeparationRequestTextField(this.requestSeparationData,this.nodeFocus,{Key? key,this.textInputType}) : super(key: key);

  @override
  State<SeparationRequestTextField> createState() => _SeparationRequestTextFieldState();
}

class _SeparationRequestTextFieldState extends State<SeparationRequestTextField> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    if(widget.requestSeparationData?.data!=null&&widget.requestSeparationData!.data!.isNotEmpty)
    {
      textEditingController.text = '${widget.requestSeparationData!.data!}';
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
            Row(
              children: [
                Text(
                  widget.requestSeparationData?.title??'',
                  style: GetFont.get(
                      context,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w600,
                      color: MyColor.colorBlack
                  ),
                ),
                //Expanded(child: Container(),),
                if(widget.requestSeparationData?.isRequired==true)...
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
              ],
            )
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        TextWidget(textEditingController,TextInputAction.done,widget.nodeFocus, Key('Key${widget.requestSeparationData?.title}'),'Write ${widget.requestSeparationData?.title}',padding: 4,stroke: 0.8,height: 6.2,callBack: response,isEnabled:widget.requestSeparationData?.isEnable,textInputType: TextInputType.number,restrictionRegex: r'^[0-9]+$',),
      ],
    );
  }

  void response(String text)
  {
    if(text.isNotEmpty) {
      widget.requestSeparationData?.callBack!(RequestSeparationCallBack(index: widget.requestSeparationData!.index,data: text));
    }
  }
}