import '../../data/repoImplementation/get_mobile_info_repo_impl.dart';
import '../models/device_add_remove_mapper.dart';

abstract class GetMobileInfoRepository
{

  static final GetMobileInfoRepository _instance = GetMobileInfoRepoImpl();
  static GetMobileInfoRepository get instance => _instance;

  Future<MobileInfoModel?> createCurrentMobileInfo();
  MobileInfoModel? getCurrentMobileInfo();

}