import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
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