import 'package:file_picker/src/platform_file.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/attachment_upload_module/data/remote/api_client_attachment_repo_impl.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/attachment_upload_module/data/repoImpl/file_add_remove_repo_impl.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/attachment_upload_module/domain/model/attachment_files_data.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/attachment_upload_module/utils/file_type.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../domain/model/attahcment_upload_model.dart';
import '../../domain/repo/api_client_attachment_repo.dart';
import '../../domain/repo/file_add_remove_repo.dart';
import '../../domain/usecase/file_add_remove_usecase.dart';

class AttachmentBloc extends ExtendedCubit<AppState>
{
  late FileAddRemoveUseCase useCase;

  AttachmentBloc(super.initialState,AttachmentUploadMapper attachmentUploadMapper){
    ApiClientAttachmentRepo apiClientAttachmentRepo = ApiClientAttachmentRepoImpl();
    FileAddRemoveRepo repo = FileAddRemoveRepoImpl(apiClientAttachmentRepo: apiClientAttachmentRepo, attachmentUploadMapper: attachmentUploadMapper);
    useCase = FileAddRemoveUseCase(fileAddRemoveRepo: repo);
  }

  IconData getIconType(PlatformFile? file)
  {
    return file?.extension?.toLowerCase()=='png'||file?.extension=='jpg'?Icons.photo_outlined:Icons.file_copy_outlined;
  }

  void removeFile(int index)
  {
    emit(AppStateDone(data: useCase.removeFile(index)));
  }

  void addFile(BuildContext context) {
    useCase.addFile(
        context,
        notify: (){
      emit(AppStateDone(data: useCase.getFilesList()));
    });
  }

  void reUpload(BuildContext context,int index) {
    useCase.reUpload(
        context,
        index,
        notify: (){
          emit(AppStateDone(data: useCase.getFilesList()));
        });
  }

  List<dynamic>? prepareDataForResult()
  {
    if(useCase.getFilesList().length>1)
      {
        List<AttachmentFileData> list = List.generate(useCase.getFilesList().length, (index) => useCase.getFilesList()[index]);
        list.removeWhere((element) => element.dataType == DataType.button||element.dataType == DataType.file||element.dataType == DataType.failedFile);
        if(list.isNotEmpty)
          {
            List<dynamic> uploadedResultSet = [];
            for (var element in list) {
              uploadedResultSet.add(element.uploadedResultSet);
            }
            return uploadedResultSet;
          }
      }
    return null;
  }
  @override
  Future<void> close() {
    try{
      useCase.getFilesList().forEach((element) {

      });
    }catch(e){}
    return super.close();
  }

}