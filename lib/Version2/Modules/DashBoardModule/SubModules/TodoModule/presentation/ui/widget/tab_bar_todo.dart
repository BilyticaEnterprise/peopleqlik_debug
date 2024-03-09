import 'package:flutter/material.dart';

import '../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../utils/tabs/presentation/ui/custom_tabs_header.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/screen_sizes.dart';

class TabBarTodo extends StatelessWidget {
  const TabBarTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize(context).heightOnly( 6.5),
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      width: double.maxFinite,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(MyColor.colorGrey6)
      ),
      child: Row(
        children: [
          Expanded(
              child: CustomTabsHeaderCircleElevated(true,'${CallLanguageKeyWords.get(context, LanguageCodes.pending)}',(){})
          ),
          // Expanded(
          //     child: TimeOffHeader(false,'${CallLanguageKeyWords.get(context, LanguageCodes.approved)}',(){})
          // ),
          Expanded(
              child: CustomTabsHeaderCircleElevated(false,'Completed',(){})
          )
        ],
      )
    );
  }
}
