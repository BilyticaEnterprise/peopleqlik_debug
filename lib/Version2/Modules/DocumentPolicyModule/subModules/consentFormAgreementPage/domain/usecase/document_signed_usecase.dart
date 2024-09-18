import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/data/model/sign_doucment_approve_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/consentFormAgreementPage/domain/repo/document_aprrove_repo.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';

class DocumentSignedUseCase
{
  DocumentApproveRepo repo;
  DocumentSignedUseCase({required this.repo});

  Future<bool> signedDocument({required BuildContext context, required List<DocumentPolicySignedModel> parameters})
  async {
    AppState appState = await repo.signedDocument(context: context, parameters: parameters);
    if(appState is AppStateDone)
    {
      SnackBarDesign.happySnack(CallLanguageKeyWords.get(context, LanguageCodes.UploadedSuccessfully));
      return true;
    }
    return false;
  }
}