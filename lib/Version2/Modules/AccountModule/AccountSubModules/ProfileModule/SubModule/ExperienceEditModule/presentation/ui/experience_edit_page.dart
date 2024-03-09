import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Default_Screens/scafold_screens/default_screens.dart';

import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../../configs/language_codes.dart';

class ExperienceEditPage extends StatelessWidget {
  const ExperienceEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetPageStarterScaffoldStateLess(
      title: CallLanguageKeyWords.get(context, LanguageCodes.experiencePage)??'',
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

