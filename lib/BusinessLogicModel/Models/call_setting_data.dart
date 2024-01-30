import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/settings_model.dart';
import 'package:provider/provider.dart';

class CallLanguageKeyWords
{
  static String? get(BuildContext context,value)
  {
    if(!context.mounted) {
      return '';
    }
    return Provider.of<SettingsModelListener>(context,listen: false).getValue(context, value);
  }
}