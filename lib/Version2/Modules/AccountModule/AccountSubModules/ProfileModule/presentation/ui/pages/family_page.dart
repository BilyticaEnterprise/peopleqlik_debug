import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peopleqlik_debug/configs/icons.dart';

import '../../../../../../../../Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/fonts.dart';
import '../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/commonUis/common_container.dart';
import '../../../../../../../../utils/date_formats.dart';
import '../../../../../../../../utils/icon_view/icon_text.dart';
import '../../../../../../../../utils/screen_sizes.dart';

class ProfileFamilyViewPage extends StatelessWidget {
  final bool? canEdit;
  const ProfileFamilyViewPage({super.key, this.canEdit});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(3)),
        itemBuilder: (context,index){
          return _FamilyWidget(canEdit);
        },
        separatorBuilder: (context,index){
          return const DividerByHeight(2);
        },
        itemCount: 3
    );
  }
}

class _FamilyWidget extends StatelessWidget {
  final bool? canEdit;
  const _FamilyWidget(this.canEdit, {super.key});

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
                    'Father',
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
              'Muhammad Akram Javed',
              style: GetFont.get(
                  context,
                  fontSize: 2.0,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
              ),
            ),
            const DividerByHeight(0.8),
            Row(
              children: [
                Expanded(
                    flex: 2,
                    child: GetIconText(text: ': 090000992000',icon: SvgPicturesData.callIcon,textSize: 1.6,fontWeight: FontWeight.w600,textColor: MyColor.colorPrimary,iconSize: 2,)),
                DividerByWidth(0.6),
                Expanded(
                    flex: 1,
                    child: GetIconText(text: ': Yes',icon: SvgPicturesData.emergency,iconSize: 2,)),
              ],
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
