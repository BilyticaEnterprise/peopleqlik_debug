import 'package:device_info_plus/device_info_plus.dart';

abstract class StoragePermissionRepo
{
  Future<bool> checkPermission();
  Future<AndroidDeviceInfo> getInfo();
}