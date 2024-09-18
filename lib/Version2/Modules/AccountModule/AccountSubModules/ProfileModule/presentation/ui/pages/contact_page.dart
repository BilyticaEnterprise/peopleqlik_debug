import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/icon_view/get_icons.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../../../../Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_twin_buttons.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import '../../../../../../../../utils/icon_view/next_icon.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/fonts.dart';
import '../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/commonUis/common_container.dart';

class ProfileContactViewPage extends StatelessWidget {
  final bool? canEdit;
  const ProfileContactViewPage({this.canEdit,super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(3)),
        itemBuilder: (context,index){
          return _ContactWidget(canEdit);
        },
        separatorBuilder: (context,index){
          return const DividerByHeight(2);
        },
        itemCount: 3
    );
  }
}

class _ContactWidget extends StatelessWidget {
  final bool? canEdit;
  const _ContactWidget(this.canEdit, {super.key});

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
                  'CT: Permanent',
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
            '0900078601',
            style: GetFont.get(
                context,
                fontSize: 2.0,
                fontWeight: FontWeight.w600,
                color: MyColor.colorBlack
            ),
          ),
          const DividerByHeight(0.8),
          Flexible(
            child: Text(
              '${CallLanguageKeyWords.get(context, LanguageCodes.address)}: Phajy k naan chany',
              style: GetFont.get(
                  context,
                  fontSize: 1.4,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorBlack
              ),
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
              acceptText: CallLanguageKeyWords.get(context, LanguageCodes.call)??'',
              rejectText: CallLanguageKeyWords.get(context, LanguageCodes.delete)??'',
              buttonTextPaddingVertically: 1.2,
              textSize: 1.8,
              rejectColor: MyColor.colorRed,
              acceptColor: MyColor.colorA5,
              acceptTextColor: MyColor.colorBlack,
            ),
          ]
        ],
      )
    );
  }
}
