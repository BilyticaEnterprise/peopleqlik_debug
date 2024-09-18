import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/presentation/ui/widgets/document_policy_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/utils/common_dashboard_container.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/commonUis/common_container.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/icon_view/next_icon.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DummyDashboardWidget extends StatelessWidget {
  const DummyDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: CommonDashboardContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dummy',
              style: GetFont.get(
                  context,
                  fontWeight: FontWeight.w600,
                  fontSize: 2.2,
                  color: MyColor.colorBlack
              ),
            ),
            const DividerByHeight(0.5),
            Text(
              'Dummy data',
              style: GetFont.get(
                  context,
                  fontWeight: FontWeight.w400,
                  fontSize: 1.5,
                  color: MyColor.colorBlack
              ),
            ),
            const DividerByHeight(1.5),
            ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return CommonContainer(

                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly(3)),
                      child: Text('helo'),
                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return const DividerByHeight(1.5);
                },
                itemCount: 2
            ),
            const DividerByHeight(2.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const NextIcon(color: MyColor.colorA5,),
                const DividerByWidth(3),
                Text(
                  CallLanguageKeyWords.get(context, LanguageCodes.clickHereToSee)??'',
                  style: GetFont.get(
                      context,
                      fontWeight: FontWeight.w400,
                      fontSize: 1.4,
                      color: MyColor.colorBlack
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


