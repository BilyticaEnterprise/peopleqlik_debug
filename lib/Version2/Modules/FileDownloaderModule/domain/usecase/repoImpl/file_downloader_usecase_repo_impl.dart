import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/model/file_downloader_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/repo/file_downloader_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/FileDownloaderModule/domain/usecase/repo/file_downloader_usecase.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class FileDownloaderUseCaseImpl extends FileDownloaderUseCase
{
  FileDownloaderRepo repo;
  FileDownloaderUseCaseImpl({required this.repo});

  @override
  Future<AppState> initializeDownloading({required FileDownloaderModel fileDownloaderModel}) async {
    return await repo.download(fileDownloaderModel: fileDownloaderModel);
  }

}