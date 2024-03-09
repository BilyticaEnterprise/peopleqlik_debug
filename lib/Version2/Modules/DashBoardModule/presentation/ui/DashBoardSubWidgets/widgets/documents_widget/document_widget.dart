import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/lines_widget/horizontal_vertical_line.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/ui/DashBoardSubWidgets/widgets/documents_widget/widget/dashboard_document_policy_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/ui/DashBoardSubWidgets/widgets/todos_widgets/widget/todo_display_widget.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/fonts.dart';
import '../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/icon_view/next_icon.dart';
import '../../../../../../../../utils/tabs/domain/model/tab_chip_detail.dart';
import '../../../../../../../../utils/tabs/presentation/ui/small_chip_tab.dart';
import '../../../../../utils/common_dashboard_container.dart';
import '../../../../../utils/enums/todo_enums.dart';

class DocumentDashboardWidget extends StatelessWidget {
  final Function() onTap;
  const DocumentDashboardWidget({required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return CommonDashboardContainer(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CallLanguageKeyWords.get(context, LanguageCodes.documentPolicy)??'',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w600,
                fontSize: 2.2,
                color: MyColor.colorBlack
            ),
          ),
          const DividerByHeight(0.5),
          Text(
            CallLanguageKeyWords.get(context, LanguageCodes.documentPolicyDesc)??'',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w400,
                fontSize: 1.5,
                color: MyColor.colorBlack
            ),
          ),
          const DividerByHeight(1.5),
          DashboardDocumentPolicyWidget(),
          const DividerByHeight(1.5),
          DashboardDocumentPolicyWidget(),
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
    );
  }
}


