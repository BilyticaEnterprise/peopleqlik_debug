import 'package:dio/dio.dart';

abstract class FileDownloaderApiClientRepo
{
  Future<Response?> startDownloading({
    String? baseUrl,
    required String url,
    required String savePath
  });
}