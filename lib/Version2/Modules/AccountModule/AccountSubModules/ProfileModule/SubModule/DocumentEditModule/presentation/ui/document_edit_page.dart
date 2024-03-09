import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/Default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/attachment_upload_module/domain/model/attahcment_upload_model.dart';

import '../../../../../../../ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../../Version1/Models/uploaded_file_model.dart';
import 'package:peopleqlik_debug/utils/DropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/ScreenLoader/circular_indicator_customized.dart';
import '../../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../utils/Buttons/bottom_single_button.dart';
import '../../../../../../../../../utils/Reuse_LogicalWidgets/attachment_upload_module/presentation/ui/attachment_widget.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/text_field_latest.dart';
import '../../../../../../../../../utils/bloc_logic_utils/bloc_provider_extended.dart';
import '../../../../utils/enums/enum_update_add.dart';
import '../listeners/document_edit_listener.dart';

class DocumentEditPage extends StatelessWidget {
  DocumentEditPage({super.key});

  UpdateAdd? updateAdd;

  @override
  Widget build(BuildContext context) {
    updateAdd = ModalRoute.of(context)?.settings.arguments as UpdateAdd?;
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<DocumentAddEditListener>(create: (_) => DocumentAddEditListener(AppStateNothing(),updateAdd??UpdateAdd.addNew),)
        ],
        builder: (context) {
          return GetPageStarterScaffoldStateLess(
            title: CallLanguageKeyWords.get(context, LanguageCodes.documentsPage)??'',
            body: _BodyView(),
            bottomNavigationBar: BlocConsumer<DocumentAddEditListener,AppState>(
                listener: (context,data){},
                builder: (context, data) {
                  if(data is AppStateDone)
                  {
                    return BottomSingleButton(text: '${CallLanguageKeyWords.get(context, LanguageCodes.done)}',buttonColor: MyColor.colorPrimary,textColor: MyColor.colorWhite,onPressed: (){},);
                  }
                  else
                  {
                    return Container(height: 0,);
                  }
                }
            ),
          );
        }
    );
  }
}
class _BodyView extends StatefulWidget {
  const _BodyView({super.key});

  @override
  State<_BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<_BodyView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<DocumentAddEditListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    DocumentAddEditListener documentAddEditListener = BlocProvider.of<DocumentAddEditListener>(context,listen: false);
    return BlocConsumer<DocumentAddEditListener,AppState>(
        listener: (context,data){},
        builder: (context, data) {
          if(data is AppStateDone)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DividerByHeight(2),
                  HeaderDropDownField(dropDownDataType: documentAddEditListener.useCase.getControllerWithName().documentTypeDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.documentType)??'Document Type', key: Key('regular1'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.documentName)??'Document name', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: documentAddEditListener.useCase.getControllerWithName().documentNameEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('1')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.documentMark)??'Document mark', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: documentAddEditListener.useCase.getControllerWithName().marEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('2')),
                  const DividerByHeight(3),
                  // AttachmentFileWidget(
                  //   headerText: 'Document',
                  //   attachmentUploaderMapper: AttachmentUploadMapper(
                  //       baseUrl: RequestType.baseUrl??'',
                  //       uploadEndPoint: RequestType.uploadLeaveFile,
                  //       model: ClassType<GetUploadedFileJson>(GetUploadedFileJson.fromJson)
                  //   ),
                  //   result: (result) {
                  //     PrintLogs.printLogs('resulasdas $result');
                  //   },
                  // ),
                  const DividerByHeight(16),

                ],
              ),
            );
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }

  dropDownCallBack(SelectedDropDown p1) {

  }
}

