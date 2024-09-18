import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/data/model/sign_doucment_approve_model.dart';

abstract class SignedDocumentApiClientRepo
{
  Future<ApiResponse> signedDocument({required BuildContext context, required List<DocumentPolicySignedModel> parameters});
}