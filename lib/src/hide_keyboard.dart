
import 'package:flutter/material.dart';

class HideShowKeyboard{

  static void hide(BuildContext context)
  {
    try
    {
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }
    catch (e){}


  }
}