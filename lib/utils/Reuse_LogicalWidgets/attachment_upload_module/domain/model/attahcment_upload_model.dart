import '../../../../../Version2/Modules/ApiModule/domain/model/model_decider.dart';

class AttachmentUploadMapper
{
  String uploadEndPoint;
  String baseUrl;
  ClassType model;
  AttachmentUploadMapper({required this.baseUrl,required this.uploadEndPoint,required this.model});
}