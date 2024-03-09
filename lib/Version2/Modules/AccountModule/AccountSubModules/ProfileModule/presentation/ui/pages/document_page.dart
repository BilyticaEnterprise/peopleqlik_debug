import 'package:flutter/material.dart';

import '../../../../../../../../Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/Buttons/bottom_twin_buttons.dart';
import 'package:peopleqlik_debug/utils/Buttons/buttons.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/fonts.dart';
import '../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/CommonUis/common_container.dart';
import '../../../../../../../../utils/screen_sizes.dart';

class ProfileDocumentViewPage extends StatelessWidget {
  final bool? canEdit;
  const ProfileDocumentViewPage({super.key, this.canEdit});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(3)),
        itemBuilder: (context,index){
          return _DocumentWidget(canEdit);
        },
        separatorBuilder: (context,index){
          return const DividerByHeight(2);
        },
        itemCount: 3
    );
  }
}

class _DocumentWidget extends StatelessWidget {
  final bool? canEdit;
  const _DocumentWidget(this.canEdit, {super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Candidates Application from (CAF)',
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
              'New Document',
              style: GetFont.get(
                  context,
                  fontSize: 2.0,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
              ),
            ),
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
          ],
        )
    );
  }
}
