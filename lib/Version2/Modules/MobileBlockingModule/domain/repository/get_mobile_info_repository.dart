import '../../data/repoImplementation/get_mobile_info_repo_impl.dart';
import '../models/mobile_info_model.dart';

abstract class GetMobileInfoRepository
{


  static final GetMobileInfoRepository _instance = GetMobileInfoRepoImpl();
  static GetMobileInfoRepository get instance => _instance;

  Future<MobileInfoModel?> getCurrentMobileInfo();

}