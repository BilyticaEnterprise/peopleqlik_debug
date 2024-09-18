import 'package:dio/dio.dart';
import 'package:dio/src/response.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/repo/file_downloader_api_client_repo.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';

class FileDownloaderApiClientRepoImpl extends FileDownloaderApiClientRepo
{
  @override
  Future<Response?> startDownloading({String? baseUrl, required String url, required String savePath}) async {
    try{
      Response? response = await Dio().download(
          '${baseUrl??RequestType.fileUrl}$url',
          savePath
      );
      return response;
    }on DioException catch(e){
      rethrow;
    }
  }

}