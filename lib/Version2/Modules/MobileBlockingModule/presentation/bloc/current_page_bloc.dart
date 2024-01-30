import 'package:peopleqlik_debug/Version2/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../domain/usecases/page_update_usecase.dart';
import '../../utils/page_state.dart';

class CurrentMobileBlockModulePage extends ExtendedCubit<MobileBlocPageState>
{
  late PageUpdateUseCase useCase;
  CurrentMobileBlockModulePage(super.initialState)
  {
    useCase = PageUpdateUseCase();
  }

  updatePage(MobileBlocPageState pageState){
    emit(useCase.updatePage(pageState));
  }

  MobileBlocPageState getCurrentPage(){
    return useCase.getCurrentPage();
  }



}