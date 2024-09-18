import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/model/file_downloader_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/repo/file_downloader_api_client_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/repo/file_downloader_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/repo/storage_permission_repo.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/checkFileTypeFromUrl/check_file_type.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class FileDownloaderRepoImpl extends FileDownloaderRepo with GetLoader
{

  FileDownloaderApiClientRepo apiClient;
  StoragePermissionRepo storagePermissionRepo;


  FileDownloaderRepoImpl({required this.apiClient,required this.storagePermissionRepo});

  @override
  Future<AppState> download({required FileDownloaderModel fileDownloaderModel}) async {
    try{
      BuildContext context = fileDownloaderModel.context??GetNavigatorStateContext.navigatorKey.currentState!.context;
      if(Platform.isAndroid)
      {
        if(await storagePermissionRepo.checkPermission() != true)
        {
          return AppStateError(data: CallLanguageKeyWords.get(context, LanguageCodes.directoryPermissionDenied));
        }
      }
      else
      {
        if(await storagePermissionRepo.checkPermission() != true)
        {
          return AppStateError(data: CallLanguageKeyWords.get(context, LanguageCodes.directoryPermissionDenied));
        }
      }
    }catch(e){
      return AppStateError(data: e.toString());
    }

    try{
      initLoader();
      BuildContext context = fileDownloaderModel.context??GetNavigatorStateContext.navigatorKey.currentState!.context;

      final dir = await getDirectory();
      final savePath = path.join(dir.path??'', '${fileDownloaderModel.fileName}.${CheckFileType.checkFileType(fileDownloaderModel.urlToDownload).name}');


      Response? response = await apiClient.startDownloading(savePath: savePath,url: fileDownloaderModel.urlToDownload,baseUrl: fileDownloaderModel.baseUrl);
      await closeLoader();

      if(response!=null&&response.statusCode == 200)
      {
        SnackBarDesign.happySnack('${CallLanguageKeyWords.get(context, LanguageCodes.D1)} $savePath');
        return AppStateDone(data: response.data);
      }
      else
      {
        SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.globalErrorValue)}');
        return AppStateError(data: response?.statusMessage);
      }
    }catch(e){
      await closeLoader();
      return AppStateError(data: e.toString());
    }

  }

  @override
  Future<AndroidDeviceInfo> getInfo()
  async {
    return await DeviceInfoPlugin().androidInfo;
  }

  @override
  Future<Directory> getDirectory() async {
    if (Platform.isAndroid) {

      Directory directory = Directory('/storage/emulated/0/Download/${flavorConfigSettings?.appTitle}');
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      return directory;
    }
    else if (Platform.isIOS) {
      return await getApplicationDocumentsDirectory();

    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

}