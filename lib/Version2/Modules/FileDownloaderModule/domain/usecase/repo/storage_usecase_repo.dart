import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/utils/storage_permission_enums.dart';

abstract class StorageUseCaseRepo
{
  Future<StoragePermissionEnum> checkPermission();
}