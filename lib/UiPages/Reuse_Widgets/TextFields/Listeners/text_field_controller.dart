import 'package:flutter/material.dart';

import '../ErrorHandler/error_text_handler.dart';

class TextFieldControllerCall with ErrorTextHandler
{
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  dynamic extraDefaultValue;

  TextFieldControllerCall({this.extraDefaultValue})
  {
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    textEditingController.text = extraDefaultValue!=null?extraDefaultValue.toString():'';
  }

  dispose()
  {
    showErrorFunction = null;
    hideErrorFunction = null;
    extraDefaultValue = null;
    errorMessage = null;
    textEditingController.dispose();
    focusNode.dispose();
  }

}