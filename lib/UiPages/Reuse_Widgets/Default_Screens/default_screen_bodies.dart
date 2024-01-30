import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../BusinessLogicModel/internet_connection.dart';
import '../../../src/language_codes.dart';
import '../../../src/prints_logs.dart';
import '../../../src/screen_sizes.dart';
import '../../../src/strings.dart';
import '../ErrorsUi/no_internet_found.dart';

class GetBodyWidgetWithScrollView extends StatelessWidget {
  final double paddingHorizontally;
  final Widget body;
  final bool? checkForInternet;
  const GetBodyWidgetWithScrollView({this.checkForInternet,required this.body,required this.paddingHorizontally,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(paddingHorizontally)),
        child: checkForInternet==false?body:Consumer<CheckInternetConnection>(
            builder: (context, dataInternet, child) {
              if (dataInternet.internetConnectionEnum == InternetConnectionEnum.available) {
                return body;
              } else {
                return NoInternetJustAnim(GetVariable.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 0,width: 50,height: 24,);
              }
            }
        )
    );
  }
}
class GetBodyWidgetWithOutScrollView extends StatelessWidget {
  final double? paddingHorizontally;
  final Widget body;
  final bool? checkForInternet;
  const GetBodyWidgetWithOutScrollView({this.checkForInternet,required this.body,this.paddingHorizontally,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PrintLogs.printLogs('interetete $checkForInternet');
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(paddingHorizontally ?? 0)),
        child: checkForInternet==false?body:Consumer<CheckInternetConnection>(
            builder: (context, dataInternet, child) {
              if (dataInternet.internetConnectionEnum == InternetConnectionEnum.available) {
                return body;
              } else {
                return NoInternetJustAnim(GetVariable.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 0,width: 50,height: 24,);
              }
            }
        )
    );
  }
}

