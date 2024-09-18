import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version1/viewModel/FileDownloaderListener/file_download_permission.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as path;
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';


class FileDownloaderListener extends GetChangeNotifier
{
  StorageEnum storageEnum = StorageEnum.nothing;
  bool checkAppBackground = false;
  void stater() async
  {
    storageEnum = StorageEnum.start;
    notifyListeners();
    if(await Permission.manageExternalStorage.status.isPermanentlyDenied==true)
      {
        PrintLogs.printLogs('ifff');
        storageEnum = StorageEnum.permission;
        notifyListeners();
      }
    else
    {
      bool permission = await CheckFilePermission().askPermission();
      if(permission == true)
        {
          storageEnum = StorageEnum.success;
          notifyListeners();
        }
      else
        {
          PrintLogs.printLogs('elseifff');
          storageEnum = StorageEnum.goToSettings;
          notifyListeners();
        }
    }
  }
  Future<Directory?> _getDownloadDirectory() async {
    Directory? directory = Directory('/storage/emulated/0/Download');
    // Put file in global download folder, if for an unknown reason it didn't exist, we fallback
    // ignore: avoid_slow_async_io
    if (!await directory.exists()) {
      directory = await directory.create(recursive: true);
    }
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    if(androidInfo.version.sdkInt>11)
    {
      directory = await getApplicationDocumentsDirectory();
    }
    if (!await directory.exists()) directory = await getExternalStorageDirectory();
    return directory;
  }

  void downLoad(BuildContext context,String? fileName)async {

    if(fileName!=null)
      {
        final dir = await _getDownloadDirectory();
        final savePath = path.join(dir?.path??'', fileName);
        StreamController<bool> loadingStream = StreamController.broadcast();
        ShowLoaderPopUp.showExtra(context,loadingStream);
        Response? response = await _startDownload(savePath,fileName);
        if(response!=null&&response.statusCode == 200)
          {
            loadingStream.add(true);
            SnackBarDesign.happySnack('${CallLanguageKeyWords.get(context, LanguageCodes.D1)} $savePath');
            // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'${CallLanguageKeyWords.get(context, LanguageCodes.D1)} $savePath',color: MyColor.colorPrimary,icon: SvgPicturesData.done));
          }
        else
          {
            loadingStream.add(true);
            SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.D3)}');
            // ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,'${CallLanguageKeyWords.get(context, LanguageCodes.D3)}',color: MyColor.colorRed));
          }
      }
  }
  Future<Response?> _startDownload(String savePath, String fileName) async {
    PrintLogs.printLogs('file $fileName');
    try{
      Response? response = await Dio().download(
          '${RequestType.attachmentsUrl}$fileName',
          savePath
      );
      return response;
    }on DioError catch(e){
      return null;
    }

  }
}
enum StorageEnum
{
  nothing,start,success,failed,goToSettings,permission
}