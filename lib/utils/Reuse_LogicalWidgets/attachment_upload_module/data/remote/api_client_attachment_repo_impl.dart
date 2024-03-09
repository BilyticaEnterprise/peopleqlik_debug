
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/repo/api_client_repo.dart';

import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/attachment_upload_module/domain/model/attahcment_upload_model.dart';

import '../../../../../Version2/Modules/ApiModule/data/repoImpl/api_client_repo_impl.dart';
import '../../../../../Version2/Modules/ApiModule/utils/check_type_enums.dart';
import '../../../../../Version2/Modules/ApiModule/domain/model/model_decider.dart';
import '../../domain/repo/api_client_attachment_repo.dart';

class ApiClientAttachmentRepoImpl extends ApiClientAttachmentRepo
{
  @override
  Future<ApiResponse> uploadFile(
      BuildContext context,
      String filePath,
      AttachmentUploadMapper attachmentUploadMapper
      )
  async {
    String fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath, filename:fileName),
    });
    return await GlobalApiCallerRepo.instance.callApi(context,baseUrl: attachmentUploadMapper.baseUrl,endPoint: attachmentUploadMapper.uploadEndPoint,checkTypes: CheckTypes.includeData,isPost: true,parameters: formData, type: attachmentUploadMapper.model);

  }

}