import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/TextFields/Listeners/text_field_controller.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';

import '../../../../../../../utils/bloc_logic_utils/cubit_ingerited.dart';

class CheckCurrentPasswordBloc extends ExtendedCubit
{
  TextFieldControllerCall textFieldControllerCall = TextFieldControllerCall();

  CheckCurrentPasswordBloc(super.initialState);

  void checkPassword(BuildContext context) {
    RegExp regex = RegExp(r'^\s*$'); // Regular expression to match white spaces


    if(textFieldControllerCall.textEditingController.text.isNotEmpty && !regex.hasMatch(textFieldControllerCall.textEditingController.text))
      {
        Navigator.pushNamed(context, CurrentPage.createNewPasswordPage);
      }
    else
      {
        SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.cannotEmpty));
      }
  }
}