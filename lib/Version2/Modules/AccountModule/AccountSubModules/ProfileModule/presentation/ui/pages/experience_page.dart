import 'package:flutter/material.dart';

import '../../../../../../../../Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_twin_buttons.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/fonts.dart';
import '../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/commonUis/common_container.dart';
import '../../../../../../../../utils/date_formats.dart';
import '../../../../../../../../utils/screen_sizes.dart';

class ProfileExperienceViewPage extends StatelessWidget {
  final bool? canEdit;
  const ProfileExperienceViewPage({super.key, this.canEdit});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(3)),
        itemBuilder: (context,index){
          return _ExperienceWidget(canEdit);
        },
        separatorBuilder: (context,index){
          return const DividerByHeight(2);
        },
        itemCount: 3
    );
  }
}

class _ExperienceWidget extends StatelessWidget {
  final bool? canEdit;
  const _ExperienceWidget(this.canEdit, {super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
        onTap: canEdit==true?(){

        }:null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'ORG: Bilytica',
                    style: GetFont.get(
                        context,
                        fontSize: 1.6,
                        fontWeight: FontWeight.w400,
                        color: MyColor.colorGrey3
                    ),
                  ),
                ),
                Icon(
                  Icons.edit_note,
                  size: ScreenSize(context).heightOnly(2.8),
                  color: const Color(MyColor.colorBlack),
                )
              ],
            ),
            const DividerByHeight(0.4),
            Text(
              'Flutter Mobile Developer',
              style: GetFont.get(
                  context,
                  fontSize: 2.0,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
              ),
            ),
            const DividerByHeight(0.4),
            Text(
              '${CallLanguageKeyWords.get(context, LanguageCodes.salary)}: 0000 RS',
              style: GetFont.get(
                  context,
                  fontSize: 1.8,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorPrimary
              ),
            ),
            const DividerByHeight(0.8),
            Text(
              '${CallLanguageKeyWords.get(context, LanguageCodes.country)}: Pakistan',
              style: GetFont.get(
                  context,
                  fontSize: 1.6,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorBlack
              ),
            ),
            const DividerByHeight(0.4),
            Text(
              '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffFromDate)}: ${GetDateFormats().getFilterDate('2023-12-16T00:00:00')}',
              style: GetFont.get(
                  context,
                  fontSize: 1.6,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorBlack
              ),
            ),
            const DividerByHeight(0.4),
            Text(
              '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffToDate)}: ${GetDateFormats().getFilterDate('2023-12-16T00:00:00')}',
              style: GetFont.get(
                  context,
                  fontSize: 1.6,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorBlack
              ),
            ),
            if(canEdit == true)...[
              const DividerByHeight(2.5),
              TwinButtonsOnly(
                acceptCallBack: ()
                {
                },
                rejectCallBack: ()
                async {
                },
                acceptText: CallLanguageKeyWords.get(context, LanguageCodes.view)??'',
                rejectText: CallLanguageKeyWords.get(context, LanguageCodes.delete)??'',
                buttonTextPaddingVertically: 1.2,
                rejectColor: MyColor.colorRed,
                acceptColor: MyColor.colorA5,
                acceptTextColor: MyColor.colorBlack,
                textSize: 1.8,
              ),
            ]
          ],
        )
    );

  }
}
