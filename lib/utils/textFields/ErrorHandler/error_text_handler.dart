import 'package:flutter/material.dart';

import '../../provider_logic_utils/overrided_change_notifier.dart';

mixin ErrorTextHandler
{

  VoidCallback? showErrorFunction;
  String? errorMessage;
  VoidCallback? hideErrorFunction;

  void hideError()
  {
    try{
      if(errorMessage!=null)
      {
        hideErrorFunction!();
        errorMessage = null;
      }
    }catch(e){}
  }
  void showError(String? error)
  {
    errorMessage = error;
    try{
      showErrorFunction!();
    }catch(e){}
  }
}

class ErrorNotifierListener extends GetChangeNotifier
{
  String? errorText;

  void notifyAll(String? errorText) {
    this.errorText = errorText;
    notifyListeners();
  }
}