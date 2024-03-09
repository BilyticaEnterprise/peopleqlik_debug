import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/icon_view/get_icons.dart';
import 'package:peopleqlik_debug/utils/icon_view/next_icon.dart';

import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../utils/CommonUis/common_container.dart';
import '../../../../../../../../../utils/icon_view/done_icon.dart';

class DashboardDocumentPolicyWidget extends StatelessWidget {
  const DashboardDocumentPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
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
