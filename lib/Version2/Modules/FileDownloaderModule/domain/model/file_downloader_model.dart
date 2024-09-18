import 'package:flutter/material.dart';

class FileDownloaderModel
{
  BuildContext? context;
  String urlToDownload;
  String fileName;
  String? baseUrl;
  FileDownloaderModel({this.context,required this.fileName,required this.urlToDownload,this.baseUrl});
}