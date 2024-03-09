import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';

import '../model/attahcment_upload_model.dart';

abstract class ApiClientAttachmentRepo
{
  Future<ApiResponse> uploadFile(BuildContext context,String filePath,AttachmentUploadMapper attachmentUploadMapper);
}