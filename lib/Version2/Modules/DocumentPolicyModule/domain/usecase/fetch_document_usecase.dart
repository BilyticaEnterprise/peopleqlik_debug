import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/data/model/document_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/domain/repo/fetch_document_list_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class DocumentFetchUseCase
{
  DocumentFetchListRepo repo;

  DocumentFetchUseCase({required this.repo});

  startGettingResult(BuildContext context, AppState status){
    return repo.fetchListApi(context,status);
  }

  List<ObjDocument>? getList(){
    return repo.getList();
  }

  updateStep(bool value, BuildContext context)
  {
    repo.updateStepNow(value, context);
  }

  getIsReachEnd()
  {
    return repo.isReachEnd();
  }

  void updateFetchDocumentApiModel(int typeId) {
    return repo.updateFetchDocumentApiModel(typeId);
  }
}