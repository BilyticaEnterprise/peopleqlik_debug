import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/dividers.dart';

import '../../../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../../../src/colors.dart';
import '../../../../../../../../src/fonts.dart';
import '../../../../../../../../src/language_codes.dart';
import '../../../../../../../../src/screen_sizes.dart';

class PreviousHeaderWidget extends StatelessWidget {
  const PreviousHeaderWidget({super.key});

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
                  CallLanguageKeyWords.get(context, LanguageCodes.registeredDevice)??'',
                  style: GetFont.get(
                      context,
                      fontWeight: FontWeight.w600,
                      color: MyColor.colorBlack,
                      fontSize: 2.2
                  ),
                ),
              ),
              Text(
                'Count (2)',
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
            'These are the list of devices which you have registered previously',
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
