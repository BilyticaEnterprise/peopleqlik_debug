import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/data/model/document_model.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class DocumentFetchListRepo
{
  List<ObjDocument>? getList();
  fetchListApi(BuildContext context, AppState status);
  updateStepNow(bool value, BuildContext context);
  bool isReachEnd();
  updateFetchDocumentApiModel(int typeId);
}