import '../models/device_add_remove_mapper.dart';
import '../repository/get_mobile_info_repository.dart';

class AllMobileInfoUseCase
{
  Future<MobileInfoModel?> createCurrentMobileInfo() async
  {
    return await GetMobileInfoRepository.instance.createCurrentMobileInfo();
  }

  MobileInfoModel? getCurrentMobileInfo()
  {
    return GetMobileInfoRepository.instance.getCurrentMobileInfo();
  }
}