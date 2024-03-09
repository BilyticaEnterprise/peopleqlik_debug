import 'package:peopleqlik_debug/utils/States/app_state.dart';

import '../repo/compensation_view_controllers_repo.dart';

class CompensationControllerUseCase
{
  CompensationViewControllersRepo compensationViewControllersRepo;
  CompensationControllerUseCase(this.compensationViewControllersRepo);

  Future<AppState> initializeControllersWithNewData(dynamic data)async{
    return await compensationViewControllersRepo.initializeControllersWithNewData(data);
  }

  Future<AppState> initializeControllersWithExistingData(dynamic data)async{
    return await compensationViewControllersRepo.initializeControllersWithExistingData(data);
  }

  CompensationViewControllersRepo getControllerWithName()
  {
    return compensationViewControllersRepo;
  }
}