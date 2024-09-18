import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/data/model/sign_doucment_approve_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/data/remote/document_api_cleint_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/data/repoImpl/document_approve_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/domain/model/document_policy_acknowledge_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/domain/usecase/document_signed_usecase.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/presentation/ui/document_acknowlegement_page.dart';
import 'package:peopleqlik_debug/utils/bottomSheetUi/bottom_sheet_ui.dart';
import 'package:peopleqlik_debug/utils/default_Screens/bottom_sheet_screens/bottom_sheet_screen.dart';

class ShowDocumentBottomSheet
{
  static show({
    required BuildContext context,
    required DocumentPolicyAcknowledgeModel model,
    required Function() onDoneCallBack})
  {
    DraggableScrollableController controller = DraggableScrollableController();

    ShowBottomSheet.show(
        context,
        height: model.htmlText!=null&&model.htmlText!.isNotEmpty?90:80,
        draggableScrollableController: controller,
        builder: DefaultBottomSheetScreen(
          body: DocumentHtmlView(model: model,),
        ),
        callBack: (value)
        async {
          if(value != null&& value is bool)
          {
            DocumentSignedUseCase useCase = DocumentSignedUseCase(repo: DocumentApproveRepoImpl(apiClientRepo: SignedDocumentApiClientRepoImpl()));
            bool done = await useCase.signedDocument(context: context, parameters: [DocumentPolicySignedModel(documentCode: model.id.toString())]);
            if(done==true)
              {
                onDoneCallBack();
              }
          }
        }
    );
  }
}