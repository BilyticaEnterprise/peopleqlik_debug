import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class LanguageLocalizations
{
  Locale? locale;
  static LanguageLocalizations? of(BuildContext context) {
    return Localizations.of<LanguageLocalizations>(context, LanguageLocalizations);
  }

  late Map<String, String> _localizedValues;

  Future load() async{
    String jsonStringValues=await rootBundle.loadString('assets/languages/${locale?.languageCode}.json');

    Map<String, dynamic> mappedJson=json.decode(jsonStringValues);
    _localizedValues=mappedJson.map((key, value) => MapEntry(key,value.toString()));

  }
  String? getTranslatedValue(String key)
  {
    return _localizedValues[key];
  }

  static const LocalizationsDelegate<LanguageLocalizations> delegate=_LanguageLocalizationsDelegate();
}
class _LanguageLocalizationsDelegate extends LocalizationsDelegate<LanguageLocalizations>
{
  const _LanguageLocalizationsDelegate();
  @override
  bool isSupported(Locale locale) {
    return ['en','ar'].contains(locale.languageCode);
  }
  @override
  Future<LanguageLocalizations> load(Locale locale) async {
    LanguageLocalizations localizations = LanguageLocalizations();
    localizations.locale = locale;
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_LanguageLocalizationsDelegate old) => false;

}