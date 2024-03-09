import 'package:peopleqlik_debug/utils/States/app_state.dart';

import '../repo/family_view_controllers_repo.dart';

class FamilyControllerUseCase
{
  FamilyViewControllersRepo compensationViewControllersRepo;
  FamilyControllerUseCase(this.compensationViewControllersRepo);

  Future<AppState> initializeControllersWithNewData(dynamic data)async{
    return await compensationViewControllersRepo.initializeControllersWithNewData(data);
  }

  Future<AppState> initializeControllersWithExistingData(dynamic data)async{
    return await compensationViewControllersRepo.initializeControllersWithExistingData(data);
  }

  FamilyViewControllersRepo getControllerWithName()
  {
    return compensationViewControllersRepo;
  }
}