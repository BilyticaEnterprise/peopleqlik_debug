import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/model/file_downloader_model.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class FileDownloaderRepo
{

  Future<AndroidDeviceInfo> getInfo();
  Future<AppState> download({required FileDownloaderModel fileDownloaderModel});
  Future<Directory> getDirectory();
}