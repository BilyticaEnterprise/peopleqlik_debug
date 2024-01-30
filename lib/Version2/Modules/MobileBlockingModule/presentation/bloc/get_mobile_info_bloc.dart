import 'package:peopleqlik_debug/Version2/utils/States/app_state.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';

import '../../../../utils/bloc_logic_utils/cubit_ingerited.dart';
import '../../domain/usecases/all_mobile_info_usecase.dart';

class GetMobileInfoBloc extends ExtendedCubit<AppState>
{
  late AllMobileInfoUseCase useCase;
  GetMobileInfoBloc(super.initialState)
  {
    useCase = AllMobileInfoUseCase();
  }

  start()async
  {
    PrintLogs.printLogs('satart');
    emit(AppStateDone(data: await useCase.getCurrentMobileInfo()));
  }
}