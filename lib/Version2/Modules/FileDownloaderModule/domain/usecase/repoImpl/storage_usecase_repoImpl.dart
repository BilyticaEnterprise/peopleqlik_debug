import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/data/repoImpl/storage_permission_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/usecase/repo/storage_usecase_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/utils/storage_permission_enums.dart';
import 'package:permission_handler/permission_handler.dart';

class StorageUseCaseRepoImpl extends StorageUseCaseRepo
{

  StoragePermissionRepoImpl repo;
  StorageUseCaseRepoImpl({required this.repo});

  @override
  Future<StoragePermissionEnum> checkPermission() async {

    if(await Permission.manageExternalStorage.status.isPermanentlyDenied==true)
    {
      return StoragePermissionEnum.permission;
    }
    else
    {
      bool permission = await repo.checkPermission();
      if(permission == true)
      {
        return StoragePermissionEnum.success;
      }
      else
      {
        return StoragePermissionEnum.goToSettings;
      }
    }
  }

}