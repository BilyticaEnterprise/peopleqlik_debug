import 'package:flutter/material.dart';

class GetChangeNotifier extends ChangeNotifier
{
  bool isDisposed = false;
  GetChangeNotifier(){
    isDisposed = false;
  }
  @override
  void notifyListeners() {
    if(isDisposed==false)
    {
      super.notifyListeners();
    }
  }
  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }
}