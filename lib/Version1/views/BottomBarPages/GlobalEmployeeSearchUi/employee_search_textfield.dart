import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/TextFields/LegacyTextFields/text_widgets.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';

class SearchAnythingTextField extends StatefulWidget {
  final FocusScopeNode nodeFocus;
  final SearchData? requestSeparationData;
  const SearchAnythingTextField(this.requestSeparationData,this.nodeFocus,{Key? key}) : super(key: key);

  @override
  State<SearchAnythingTextField> createState() => _SearchAnythingTextFieldState();
}

class _SearchAnythingTextFieldState extends State<SearchAnythingTextField> {
  final TextEditingController textEditingController = TextEditingController();
  final delay = 500;
  Timer? searchOnStoppedTyping;
  var lastTextEdit = 0;

  @override
  void initState() {
    if(widget.requestSeparationData?.data!=null&&widget.requestSeparationData!.data!.isNotEmpty)
    {
      textEditingController.text = widget.requestSeparationData!.data!;
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
        TextWidget(textEditingController,TextInputAction.done,widget.nodeFocus, const Key('KeySearch'),'${CallLanguageKeyWords.get(context, LanguageCodes.searchWriteSome)}',padding: 4,stroke: 0.8,height: 6.5,callBack: response,isEnabled:widget.requestSeparationData?.isEnable,textInputType: TextInputType.text,searchIcon: true,),
      ],
    );
  }
  void response(String text)
  {
    if(text.isNotEmpty&&text.replaceAll(' ', '').isNotEmpty) {
      if (searchOnStoppedTyping != null) {
          searchOnStoppedTyping?.cancel(); // clear timer
        }
        lastTextEdit=DateTime.now().millisecondsSinceEpoch;
        searchOnStoppedTyping = Timer(Duration(milliseconds: delay), () {
          if(DateTime.now().millisecondsSinceEpoch>(lastTextEdit + delay - 500))
          {
            widget.requestSeparationData?.callBack!(text);
          }
        });

    }
  }
}
class SearchData
{
  String? data;
  bool? isEnable;
  Function(String data)? callBack;
  SearchData({required this.data,required this.isEnable,required this.callBack});
}