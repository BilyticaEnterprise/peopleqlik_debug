import 'package:peopleqlik_debug/Version2/Modules/MobileBlockingModule/domain/models/mobile_info_model.dart';

import '../../utils/page_state.dart';
import '../repository/mobile_page_repository.dart';

class PageUpdateUseCase
{
  MobileBlocPageState updatePage(MobileBlocPageState pageState){
    return MobilePageRepository.instance.updatePage(pageState);
  }

  MobileBlocPageState getCurrentPage(){
    return MobilePageRepository.instance.getCurrentPage();
  }

}