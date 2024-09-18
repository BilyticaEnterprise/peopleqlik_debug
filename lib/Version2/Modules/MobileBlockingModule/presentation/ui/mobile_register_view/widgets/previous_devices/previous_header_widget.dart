import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';

import '../../../../../../../../Version1/models/call_setting_data.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/fonts.dart';
import '../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/screen_sizes.dart';

class PreviousHeaderWidget extends StatelessWidget {
  final int count;
  final String header;
  final String text;
  const PreviousHeaderWidget({required this.count,required this.header,required this.text,super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6),vertical: ScreenSize(context).heightOnly(1.2)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  header,
                  style: GetFont.get(
                      context,
                      fontWeight: FontWeight.w600,
                      color: MyColor.colorBlack,
                      fontSize: 2.2
                  ),
                ),
              ),
              Text(
                '${CallLanguageKeyWords.get(context, LanguageCodes.allowedDevice)} ($count)',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w400,
                    color: MyColor.colorBlack,
                    fontSize: 1.6
                ),
              ),
            ],
          ),
          const DividerByHeight(0.8),
          Text(
            text,
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w400,
                color: MyColor.colorGrey3,
                fontSize: 1.6
            ),
          ),
        ],
      ),
    );
  }
}
