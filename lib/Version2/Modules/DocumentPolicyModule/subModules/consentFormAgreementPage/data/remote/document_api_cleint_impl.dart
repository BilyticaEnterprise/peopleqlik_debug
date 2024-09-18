import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/repo/api_client_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/check_type_enums.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/data/model/sign_doucment_approve_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/data/model/signed_approve_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/domain/repo/document_api_client.dart';

class SignedDocumentApiClientRepoImpl extends SignedDocumentApiClientRepo
{
  @override
  Future<ApiResponse> signedDocument({required BuildContext context, required List<DocumentPolicySignedModel> parameters}) async {
    return await GlobalApiCallerRepo.instance.callApi(
        context,
        endPoint: RequestType.acknowledgeDocument,
        parameters: parameters,
        authHeaders: true,
        isPost: true,
        type: ClassType<SignedOrganizationResponseModel>(SignedOrganizationResponseModel.fromJson),
        checkTypes: CheckTypes.onlyBool
    );
  }

}