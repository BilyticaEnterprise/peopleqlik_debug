import 'package:file_picker/file_picker.dart';

import '../../utils/file_type.dart';

class AttachmentFileData<T>
{
  PlatformFile? file;
  DataType dataType;
  T? uploadedResultSet;
  AttachmentFileData({required this.dataType,this.file,this.uploadedResultSet});
}