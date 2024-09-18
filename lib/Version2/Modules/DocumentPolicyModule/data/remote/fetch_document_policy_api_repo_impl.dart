import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/repo/api_client_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/check_type_enums.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/data/model/document_list_api_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/data/model/fetch_document_api_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/domain/repo/fetch_document_api_repo.dart';

class DocumentPolicyFetchApiRepoImpl extends DocumentPolicyFetchApiRepo
{
  @override
  Future<ApiResponse> fetchDocument({required BuildContext context,required FetchDocumentApiModel model}) async{
    return await GlobalApiCallerRepo.instance.callApi(
        context,
        endPoint: RequestType.getDocumentPolicyList,
        urlParameters: '?CompanyCode=${model.companyCode}&TypeID=${model.typeID}&PageNo=${model.pageNumber}&PerPage=10',
        authHeaders: true,
        isPost: false,
        type: ClassType<DocumentPolicyListModel>(DocumentPolicyListModel.fromJson),
        checkTypes: CheckTypes.includeListInsideData
    );
  }

}