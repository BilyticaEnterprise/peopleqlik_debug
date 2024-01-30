import '../models/mobile_info_model.dart';
import '../repository/get_mobile_info_repository.dart';

class AllMobileInfoUseCase
{
  Future<MobileInfoModel?> getCurrentMobileInfo() async
  {
    return await GetMobileInfoRepository.instance.getCurrentMobileInfo();
  }
}