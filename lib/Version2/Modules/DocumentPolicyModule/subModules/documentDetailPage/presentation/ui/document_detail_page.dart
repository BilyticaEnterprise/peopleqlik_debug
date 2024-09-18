import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/domain/model/document_policy_acknowledge_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/presentation/ui/document_acknowledgement_bottom_sheet.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentDetailPage/domain/model/document_policy_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentDetailPage/presentation/bloc/document_policy_detail_bloc.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_single_button.dart';
import 'package:peopleqlik_debug/utils/checkFileTypeFromUrl/check_file_type.dart';
import 'package:peopleqlik_debug/utils/checkFileTypeFromUrl/src/file_enums.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/utils/image_getter/image_zoom/image_zoom_widget.dart';
import 'package:peopleqlik_debug/utils/lottie_anims_utils/lottie_string.dart';
import 'package:peopleqlik_debug/utils/pdf_viewer/src/ui/pdf_viewer_widget.dart';

class DocumentDetailPage extends StatelessWidget {
  DocumentDetailPage({super.key});

  late DocumentPolicyDetailModel documentPolicyDetailModel;
  @override
  Widget build(BuildContext context) {
    documentPolicyDetailModel = ModalRoute.of(context)?.settings.arguments as DocumentPolicyDetailModel;
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<DocumentPolicyDetailBloc>(create: (_) => DocumentPolicyDetailBloc(documentPolicyDetailModel))
        ],
        builder: (context) {
          return GetPageStarterScaffoldWithOutSliverAppBar(
            title: CallLanguageKeyWords.get(context, LanguageCodes.documentsDetailPage),
            body: _BodyData(),
            bottomNavigationBar: documentPolicyDetailModel.acknowledgement != true&&documentPolicyDetailModel.readAcknowledgement==true?BottomSingleButton(
              text: CallLanguageKeyWords.get(context, LanguageCodes.iAgree)??'',
              onPressed: (){
                PrintLogs.printLogs('asdaskjd ${documentPolicyDetailModel.acknowledgementBody}');
                ShowDocumentBottomSheet.show(
                    context: context,
                    model: DocumentPolicyAcknowledgeModel(
                        id: documentPolicyDetailModel.documentCode,
                        title: documentPolicyDetailModel.documentTitle,
                        htmlText: documentPolicyDetailModel.acknowledgementBody
                    ),
                  onDoneCallBack: (){
                      Navigator.pop(context,true);
                  }
                );
              },
            ):null,
          );
        }
    );
  }
}
class _BodyData extends StatelessWidget {
  const _BodyData({super.key});

  @override
  Widget build(BuildContext context) {


    return BlocConsumer<DocumentPolicyDetailBloc,DocumentPolicyDetailModel>(
        listener: (context, data){},
        builder: (context, data) {
          FileTypeEnum fileTypeEnum = CheckFileType.checkFileType(data.fileName);
          if(fileTypeEnum == FileTypeEnum.png||fileTypeEnum == FileTypeEnum.jpg||fileTypeEnum == FileTypeEnum.jpeg)
            {
              return ImageZoomWidget(image: data.fileName!);
            }
          else if(fileTypeEnum == FileTypeEnum.pdf)
            {
              return PdfViewerImage(fileName: data.fileName!,);
            }
          else
            {
              return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
            }

        }
    );
  }
}
