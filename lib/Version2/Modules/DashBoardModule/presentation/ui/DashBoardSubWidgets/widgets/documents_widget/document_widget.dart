import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/data/model/document_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/attendance_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/domain/model/document_policy_acknowledge_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/presentation/ui/document_acknowledgement_bottom_sheet.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/model/file_downloader_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/presentation/bloc/file_downloader_bloc.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/checkFileTypeFromUrl/check_file_type.dart';
import 'package:peopleqlik_debug/utils/checkFileTypeFromUrl/src/file_enums.dart';
import 'package:peopleqlik_debug/utils/icon_view/get_icons.dart';
import 'package:peopleqlik_debug/utils/icon_view/icon_text.dart';
import 'package:peopleqlik_debug/utils/lines_widget/horizontal_vertical_line.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/presentation/ui/widgets/document_policy_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/ui/DashBoardSubWidgets/widgets/todos_widgets/widget/todo_display_widget.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../Version1/models/call_setting_data.dart';
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
  final List<ObjDocument>? data;
  final bool isEmpty;
  const DocumentDashboardWidget({required this.onTap,this.data,required this.isEmpty,super.key});

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
          if(isEmpty==true)...[
            const DividerByHeight(1.5),
            GetIconText(
              text: CallLanguageKeyWords.get(context, LanguageCodes.noData)??'',
              textSize: 1.4,
              textColor: MyColor.colorGrey2,
              icon: SvgPicturesData.alert,
              iconColor: MyColor.colorGrey2,
              iconSize: 1.6,
            ),
            const DividerByHeight(0.5),
          ],
          if(isEmpty!=true)...[
            ListView.separated(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){

                  FileTypeEnum fileTypeEnum = CheckFileType.checkFileType(data?[index].fileName);

                  return DashboardDocumentPolicyWidget(
                    isDummy: isEmpty,
                    onTapNext: (){
                      Provider.of<PostAttendanceListener>(context,listen: false).gotToNextDetailPage(context,index);
                    },
                    data: data?[index],
                    onDownloadTap: (){
                      BlocProvider.of<FileDownloaderBloc>(context,listen: false).initializeDownloading(
                          context: context,
                          fileDownloaderModel: FileDownloaderModel(
                              baseUrl: '${RequestType.documentUrl}',
                              fileName: '${data?[index].documentTitle}',
                              urlToDownload: '${data?[index].fileName}'
                          )
                      );
                    },
                    onAcknowledgeTap: (){
                      ShowDocumentBottomSheet.show(
                          context: context,
                          model: DocumentPolicyAcknowledgeModel(
                            id: data?[index].documentCode,
                              title: data?[index].documentTitle,
                              htmlText: data?[index].acknowledgementBody
                          ),
                        onDoneCallBack: (){
                          Provider.of<PostAttendanceListener>(context,listen: false).getDashBoard(context);
                        }
                      );
                    },
                  );
                },
                separatorBuilder: (context,index){
                  return const DividerByHeight(1.5);
                },
                itemCount: isEmpty==true?1:data?.length??0
            ),
          ],
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


