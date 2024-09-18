import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/data/model/sign_doucment_approve_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/domain/repo/document_api_client.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/domain/repo/document_aprrove_repo.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';

class DocumentApproveRepoImpl extends DocumentApproveRepo with GetLoader
{

  SignedDocumentApiClientRepo apiClientRepo;
  DocumentApproveRepoImpl({required this.apiClientRepo});

  @override
  Future<AppState> signedDocument({required BuildContext context, required List<DocumentPolicySignedModel> parameters}) async {

    initLoader();
    ApiResponse response = await apiClientRepo.signedDocument(context: context, parameters: parameters);
    await closeLoader();
    if(response.apiStatus == ApiStatus.done)
      {
        return AppStateDone();
      }
    else
      {
        ShowErrorMessage.show(response);
        return AppStateError(data: response.message);
      }
  }

}