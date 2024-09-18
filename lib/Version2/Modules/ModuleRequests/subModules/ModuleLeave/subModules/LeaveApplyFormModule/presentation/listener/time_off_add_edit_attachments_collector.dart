import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/uploaded_file_model.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

class TimeOffAddEditAttachments extends GetChangeNotifier
{
  List<GetFileType>? getFileTypeList;
  TimeOffAddEditAttachments()
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
class GetFileType
{
  PlatformFile? file;
  FileOrUrl? fileOrUrl;
  UploadedResultSet? uploadedResultSet;
  String? url;
  GetFileType(this.fileOrUrl,this.file,this.url,{this.uploadedResultSet});
}
enum FileOrUrl
{
  url,file,button
}