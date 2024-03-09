import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../model/attachment_files_data.dart';

abstract class FileAddRemoveRepo
{
  addFile(BuildContext context,{Function()? notify});
  reUpload(BuildContext context,int index,{Function()? notify});
  List<AttachmentFileData> removeFile(int index);
  Future<AttachmentFileData> uploadFile(BuildContext context,PlatformFile file);
  List<AttachmentFileData> getFilesList();
}