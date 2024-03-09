import 'package:flutter/material.dart';

import '../model/attachment_files_data.dart';
import '../repo/file_add_remove_repo.dart';

class FileAddRemoveUseCase
{
  late FileAddRemoveRepo fileAddRemoveRepo;
  FileAddRemoveUseCase({required this.fileAddRemoveRepo});

  addFile(BuildContext context,{Function()? notify}){
    fileAddRemoveRepo.addFile(context,notify: notify);
  }

  reUpload(BuildContext context,int index,{Function()? notify}){
    fileAddRemoveRepo.reUpload(context,index,notify: notify);
  }


  List<AttachmentFileData> removeFile(int index){
    return fileAddRemoveRepo.removeFile(index);
  }


  List<AttachmentFileData> getFilesList(){
    return fileAddRemoveRepo.getFilesList();
  }
}