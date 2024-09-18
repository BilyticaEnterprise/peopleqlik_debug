import 'package:device_info_plus/device_info_plus.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/repo/storage_permission_repo.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermissionRepoImpl extends StoragePermissionRepo
{
  @override
  Future<bool> checkPermission() async {
    Permission permission;
    if((await getInfo()).version.sdkInt>11)
      {
        permission = Permission.manageExternalStorage;
      }
    else
      {
        permission = Permission.storage;
      }
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      return result == PermissionStatus.granted;
    }
  }

  @override
  Future<AndroidDeviceInfo> getInfo()
  async {
    return await DeviceInfoPlugin().androidInfo;
  }
}