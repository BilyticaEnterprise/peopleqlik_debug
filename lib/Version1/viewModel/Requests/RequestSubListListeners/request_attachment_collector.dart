import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/time_off_add_edit_attachments_collector.dart';
import 'package:peopleqlik_debug/Version1/Models/uploaded_file_model.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

class RequestAttachments extends GetChangeNotifier
{
  List<GetFileType>? getFileTypeList;
  RequestAttachments()
  {
    getFileTypeList = List.empty(growable: true);
    getFileTypeList?.add(GetFileType(FileOrUrl.button,null,null));
  }
  addUrl(String url)
  {
    getFileTypeList?.add(GetFileType(FileOrUrl.url,null,url));
  }
  addFile(PlatformFile platformFile,UploadedResultSet uploadedResultSet)
  {
    getFileTypeList?.add(GetFileType(FileOrUrl.file,platformFile,null,uploadedResultSet: uploadedResultSet));
  }
  removeItem(int index)
  {
    getFileTypeList?.removeAt(index);
    notifyListeners();
  }
  notify()
  {
    notifyListeners();
  }
}