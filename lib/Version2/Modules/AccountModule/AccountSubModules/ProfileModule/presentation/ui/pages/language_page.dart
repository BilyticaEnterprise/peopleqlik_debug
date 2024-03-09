import 'package:flutter/material.dart';

import '../../../../../../../../Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/Buttons/buttons.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/fonts.dart';
import '../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/CommonUis/common_container.dart';
import '../../../../../../../../utils/screen_sizes.dart';

class ProfileLanguageViewPage extends StatelessWidget {
  final bool? canEdit;
  const ProfileLanguageViewPage({super.key, this.canEdit});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(3)),
        itemBuilder: (context,index){
          return _LanguageWidget(canEdit);
        },
        separatorBuilder: (context,index){
          return const DividerByHeight(2);
        },
        itemCount: 3
    );
  }
}


class _LanguageWidget extends StatelessWidget {
  final bool? canEdit;
  const _LanguageWidget(this.canEdit, {super.key});

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
                    '${CallLanguageKeyWords.get(context, LanguageCodes.native)}: Yes',
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
              'English',
              style: GetFont.get(
                  context,
                  fontSize: 2.0,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
              ),
            ),
            const DividerByHeight(0.8),
            Text(
              '${CallLanguageKeyWords.get(context, LanguageCodes.proficiency)}: Professional',
              style: GetFont.get(
                  context,
                  fontSize: 1.6,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorBlack
              ),
            ),
            if(canEdit == true)...[
              const DividerByHeight(2.5),
              ButtonMaterialIs(
                callBack: () {  },
                text: CallLanguageKeyWords.get(context, LanguageCodes.delete)??'',
                borderDesign: true,
                borderColor: MyColor.colorRed,
                verticalPadding: 1.2,
                textSize: 1.8,
              )
            ]
          ],
        )
    );
  }
}
