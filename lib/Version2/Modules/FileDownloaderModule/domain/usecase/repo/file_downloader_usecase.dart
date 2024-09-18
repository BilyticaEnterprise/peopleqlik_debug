import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/model/file_downloader_model.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class FileDownloaderUseCase
{
  Future<AppState> initializeDownloading({required FileDownloaderModel fileDownloaderModel});
}