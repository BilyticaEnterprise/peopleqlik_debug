import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/data/model/document_model.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/checkFileTypeFromUrl/check_file_type.dart';
import 'package:peopleqlik_debug/utils/checkFileTypeFromUrl/src/file_enums.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/icon_view/get_icons.dart';
import 'package:peopleqlik_debug/utils/icon_view/next_icon.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';

import '../../../../../../configs/colors.dart';
import '../../../../../../configs/fonts.dart';
import '../../../../../../utils/commonUis/common_container.dart';
import '../../../../../../utils/icon_view/done_icon.dart';

class DashboardDocumentPolicyWidget extends StatelessWidget {
  final bool? isDummy;
  final ObjDocument? data;
  final Function() onDownloadTap;
  final Function() onAcknowledgeTap;
  final Function()? onTapNext;
  const DashboardDocumentPolicyWidget({required this.onDownloadTap,required this.onAcknowledgeTap,this.isDummy,this.data,this.onTapNext,super.key});

  @override
  Widget build(BuildContext context) {
    FileTypeEnum fileTypeEnum = CheckFileType.checkFileType(data?.fileName);
    return CommonContainer(
      onTap: (){
        if(fileTypeEnum == FileTypeEnum.pdf || fileTypeEnum == FileTypeEnum.png || fileTypeEnum == FileTypeEnum.jpg || fileTypeEnum == FileTypeEnum.jpeg)
          {
            onTapNext!();
          }
        else
          {
            SnackBarDesign.warningSnack(CallLanguageKeyWords.get(context, LanguageCodes.unSupportedMediaType));
          }
      },
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
                color: MyColor.colorGrey2,
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
                      isDummy==true?'Dummy':'${data?.documentTitle}',
                      style: GetFont.get(
                          context,
                          fontWeight: FontWeight.w600,
                          fontSize: 1.8,
                          color: MyColor.colorBlack
                      ),
                    ),
                    DividerByHeight(0.5),
                    Text(
                      isDummy==true?'Dummy':'${data?.typeName}',
                      //'2 documents to sign related to policies',
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
              if(isDummy!=true)...[
                if(data?.canDownload==true)...[
                  GetIcons(
                    icon: SvgPicturesData.downloadExtra,
                    size: 2.5,
                    onTap: onDownloadTap,
                    color: MyColor.colorPrimary,
                  ),
                ],
                if(data?.acknowledgement !=true&&data?.readAcknowledgement==true)...[
                  DoneIcon(
                    onTap: onAcknowledgeTap,
                    isSelected: false,
                  ),
                ],
              ],
              Expanded(child: Container()),
              NextIcon(),

            ],
          )
        ],
      ),
    );
  }
}
