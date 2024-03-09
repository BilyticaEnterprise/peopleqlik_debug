import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/attachment_upload_module/domain/repo/file_add_remove_repo.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/attachment_upload_module/utils/file_type.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';

import '../../domain/model/attachment_files_data.dart';
import '../../domain/model/attahcment_upload_model.dart';
import '../../domain/repo/api_client_attachment_repo.dart';

class FileAddRemoveRepoImpl extends FileAddRemoveRepo with GetLoader
{
  late List<AttachmentFileData> _list;
  late ApiClientAttachmentRepo apiClientAttachmentRepo;
  late AttachmentUploadMapper attachmentUploadMapper;
  FileAddRemoveRepoImpl({required this.apiClientAttachmentRepo,required this.attachmentUploadMapper})
  {
    _list = [AttachmentFileData(dataType: DataType.button)];
  }

  @override
  addFile(BuildContext context,{Function()? notify}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png','jpg', 'pdf', 'doc', 'txt'],
    );


    if (result != null&&result.files.first.path!=null) {
      PlatformFile file = result.files.first;
      _list.add(AttachmentFileData(dataType: DataType.file,uploadedResultSet: null,file: file));
      if(notify!=null)
      {
        notify();
      }
      int lastindex = _list.length -1;
      _list[lastindex] = await uploadFile(context, file);
      if(notify!=null)
        {
          notify();
        }

    } else {
      if(notify!=null)
      {
        notify();
      }
    }
  }

  @override
  List<AttachmentFileData> removeFile(int index) {
    _list.removeAt(index);
    return _list;
  }

  @override
  Future<AttachmentFileData> uploadFile(BuildContext context,PlatformFile file)async {
    initLoader();
    ApiResponse apiResponse = await apiClientAttachmentRepo.uploadFile(context, file.path!, attachmentUploadMapper);
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      await closeLoader();
      return AttachmentFileData(dataType: DataType.url,uploadedResultSet: apiResponse.data,file: file);
    }
    else
    {
      await closeLoader();
      SnackBarDesign.errorSnack(apiResponse.message);
      return AttachmentFileData(dataType: DataType.failedFile,uploadedResultSet: null,file: file);
    }
  }

  @override
  reUpload(BuildContext context, int index, {Function()? notify}) async {
    PlatformFile? file = _list[index].file;
    if(file != null)
      {
        AttachmentFileData attachmentFileData = await uploadFile(context, file);
        _list[index] = attachmentFileData;
        if(notify != null)
          {
            notify();
          }
      }
  }

  @override
  List<AttachmentFileData> getFilesList() {
    return _list;
  }

}