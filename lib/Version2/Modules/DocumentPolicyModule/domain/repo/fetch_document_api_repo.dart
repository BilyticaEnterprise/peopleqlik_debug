import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/data/model/fetch_document_api_model.dart';

abstract class DocumentPolicyFetchApiRepo
{
  Future<ApiResponse> fetchDocument({required BuildContext context,required FetchDocumentApiModel model});
}