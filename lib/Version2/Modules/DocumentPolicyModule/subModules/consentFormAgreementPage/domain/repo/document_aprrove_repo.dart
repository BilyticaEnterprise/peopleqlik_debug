import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/data/model/sign_doucment_approve_model.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class DocumentApproveRepo
{

  Future<AppState> signedDocument({required BuildContext context, required List<DocumentPolicySignedModel> parameters});
}