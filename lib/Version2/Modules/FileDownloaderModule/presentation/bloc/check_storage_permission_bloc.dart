import 'package:peopleqlik_debug/Version1/viewModel/FileDownloaderListener/file_downloader_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/data/repoImpl/storage_permission_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/usecase/repo/storage_usecase_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/usecase/repoImpl/storage_usecase_repoImpl.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/utils/storage_permission_enums.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class StoragePermissionBloc extends ExtendedCubit<StoragePermissionEnum>
{

  late StorageUseCaseRepo useCase;
  StoragePermissionBloc(super.initialState){
    useCase = StorageUseCaseRepoImpl(repo: StoragePermissionRepoImpl());
  }

  void checkPermission() async
  {
    StoragePermissionEnum storageEnum = StoragePermissionEnum.start;
    emit(storageEnum);

    emit(await useCase.checkPermission());
  }

}