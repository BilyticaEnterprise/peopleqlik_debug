import '../../data/repoImplementation/mobile_page_repositoryImpl.dart';
import '../../utils/page_state.dart';
import '../models/mobile_info_model.dart';

abstract class MobilePageRepository
{
  MobileBlocPageState currentPageState = MobilePageStateFirstRegister();

  static final MobilePageRepository _instance = MobilePageRepositoryImpl();
  static MobilePageRepository get instance => _instance;

  MobileBlocPageState updatePage(MobileBlocPageState pageState);
  MobileBlocPageState getCurrentPage();
}