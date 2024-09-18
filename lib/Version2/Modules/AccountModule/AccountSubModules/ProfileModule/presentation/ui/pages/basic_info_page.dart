import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../../../../utils/lines_widget/horizontal_vertical_line.dart';
import '../../../utils/profile_header_value_text.dart';

class ProfileBasicInfoViewPage extends StatelessWidget {
  final bool? canEdit;
  const ProfileBasicInfoViewPage({super.key, this.canEdit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(5),vertical: ScreenSize(context).heightOnly(3)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: const Color(MyColor.colorWhite),
          border: Border.all(width: 1,color: Color(MyColor.colorBackgroundDark))
        ),
        child: Padding(
          padding: EdgeInsets.all(ScreenSize(context).heightOnly(2)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileHeaderValueText(header: CallLanguageKeyWords.get(context, LanguageCodes.Gender)??'', value: 'Male',),
              const DividerByHeight(2.5),
              ProfileHeaderValueText(header: CallLanguageKeyWords.get(context, LanguageCodes.MartialStatus)??'', value: 'Single',),
              const DividerByHeight(2.5),
              ProfileHeaderValueText(header: CallLanguageKeyWords.get(context, LanguageCodes.Religion)??'', value: 'Islam',),
              const DividerByHeight(2.5),
              ProfileHeaderValueText(header: CallLanguageKeyWords.get(context, LanguageCodes.IdentificationNo)??'', value: '0000-000000-0',),
              const DividerByHeight(2.5),
              ProfileHeaderValueText(header: CallLanguageKeyWords.get(context, LanguageCodes.Ethnicity)??'', value: 'Asian',),
            ],
          ),
        ),
      ),
    );
  }
}
