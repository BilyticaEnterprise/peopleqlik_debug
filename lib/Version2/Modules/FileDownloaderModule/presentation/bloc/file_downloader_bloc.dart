import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/data/remote/fiile_api_client.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/data/repoImpl/file_downloader_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/data/repoImpl/storage_permission_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/model/file_downloader_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/usecase/repoImpl/file_downloader_usecase_repo_impl.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';

class FileDownloaderBloc extends ExtendedCubit<AppState>
{
  late FileDownloaderUseCaseImpl useCase;
  FileDownloaderBloc(super.initialState)
  {
    useCase = FileDownloaderUseCaseImpl(repo: FileDownloaderRepoImpl(apiClient: FileDownloaderApiClientRepoImpl(),storagePermissionRepo: StoragePermissionRepoImpl()));
  }

  Future initializeDownloading({required BuildContext context,required FileDownloaderModel fileDownloaderModel})
  async {
    AppState appState = await useCase.initializeDownloading(fileDownloaderModel: fileDownloaderModel);
    if(appState is AppStateDone)
      {
        /// For now do nothing with response
      }
    else
      {
        if(appState is AppStateError && (appState as AppStateError).data != null)
          {
            SnackBarDesign.errorSnack('${(appState as AppStateError).data}');
          }
      }
  }
}