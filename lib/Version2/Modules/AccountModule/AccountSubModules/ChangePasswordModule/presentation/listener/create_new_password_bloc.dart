import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/TextFields/Listeners/text_field_controller.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';

import '../../../../../../../utils/bloc_logic_utils/cubit_ingerited.dart';

class CreateNewPasswordBloc extends ExtendedCubit
{
  TextFieldControllerCall passwordTextFieldControllerCall = TextFieldControllerCall();
  TextFieldControllerCall confirmPasswordTextFieldControllerCall = TextFieldControllerCall();

  CreateNewPasswordBloc(super.initialState);

  void checkPassword(BuildContext context) {
    RegExp regex = RegExp(r'^\s*$'); // Regular expression to match white spaces


    if(
    (passwordTextFieldControllerCall.textEditingController.text.isNotEmpty && !regex.hasMatch(passwordTextFieldControllerCall.textEditingController.text))
    &&
        (confirmPasswordTextFieldControllerCall.textEditingController.text.isNotEmpty && !regex.hasMatch(confirmPasswordTextFieldControllerCall.textEditingController.text))
    &&
        (passwordTextFieldControllerCall.textEditingController.text == confirmPasswordTextFieldControllerCall.textEditingController.text)
    )
    {
    }
    else
    {
      if(passwordTextFieldControllerCall.textEditingController.text.isEmpty || regex.hasMatch(passwordTextFieldControllerCall.textEditingController.text)
      ||
          confirmPasswordTextFieldControllerCall.textEditingController.text.isEmpty || regex.hasMatch(confirmPasswordTextFieldControllerCall.textEditingController.text)
      )
        {
          SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.cannotEmpty));
        }
      else if(passwordTextFieldControllerCall.textEditingController.text != confirmPasswordTextFieldControllerCall.textEditingController.text)
        {
          SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.passwordMatch));
        }
    }
  }
}