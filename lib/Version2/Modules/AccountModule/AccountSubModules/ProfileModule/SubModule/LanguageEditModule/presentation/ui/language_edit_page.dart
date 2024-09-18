import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';

import '../../../../../../../../../Version1/models/call_setting_data.dart';
import '../../../../../../../../../configs/language_codes.dart';

class LanguageEditPage extends StatelessWidget {
  const LanguageEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetPageStarterScaffoldStateLess(
      title: CallLanguageKeyWords.get(context, LanguageCodes.languagePage)??'',
      body: _BodyView(),
    );
  }
}
class _BodyView extends StatelessWidget {
  const _BodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

