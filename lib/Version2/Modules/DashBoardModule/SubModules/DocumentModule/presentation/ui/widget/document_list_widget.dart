import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/lines_widget/horizontal_vertical_line.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/ui/DashBoardSubWidgets/widgets/documents_widget/widget/dashboard_document_policy_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/ui/DashBoardSubWidgets/widgets/todos_widgets/widget/todo_display_widget.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/fonts.dart';
import '../../../../../../../../configs/icons.dart';
import '../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/CommonUis/common_container.dart';
import '../../../../../../../../utils/icon_view/done_icon.dart';
import '../../../../../../../../utils/icon_view/get_icons.dart';
import '../../../../../../../../utils/icon_view/next_icon.dart';

class DocumentListWidget extends StatelessWidget {
  final Function() onTap;
  const DocumentListWidget({required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      borderColor: MyColor.colorPrimary,
      onTap: (){},
      horizontalMargin: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GetIcons(
                icon: SvgPicturesData.file,
                iconColor: MyColor.colorGrey2,
                size: 5,
                backgroundColor: MyColor.colorTransparent,
                paddingAll: 0.6,
              ),
              const DividerByWidth(2),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Consent form resign',
                      style: GetFont.get(
                          context,
                          fontWeight: FontWeight.w600,
                          fontSize: 1.8,
                          color: MyColor.colorBlack
                      ),
                    ),
                    DividerByHeight(0.5),
                    Text(
                      '2 documents to sign related to policies',
                      style: GetFont.get(
                          context,
                          fontWeight: FontWeight.w400,
                          fontSize: 1.4,
                          color: MyColor.colorBlack
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              const DividerByWidth(13),
              GetIcons(
                icon: SvgPicturesData.downloadExtra,
                size: 2.5,
                onTap: (){},
                iconColor: MyColor.colorPrimary,
              ),
              DoneIcon(
                onTap: (){},
                isSelected: false,
              ),
              Expanded(child: Container()),
              NextIcon(),
            ],
          )
        ],
      ),
    );
  }
}


