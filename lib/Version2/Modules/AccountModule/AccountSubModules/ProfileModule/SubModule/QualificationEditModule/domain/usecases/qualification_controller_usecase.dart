import 'package:peopleqlik_debug/utils/States/app_state.dart';

import '../repo/qualification_view_controllers_repo.dart';

class QualificationControllerUseCase
{
  QualificationViewControllersRepo compensationViewControllersRepo;
  QualificationControllerUseCase(this.compensationViewControllersRepo);

  Future<AppState> initializeControllersWithNewData(dynamic data)async{
    return await compensationViewControllersRepo.initializeControllersWithNewData(data);
  }

  Future<AppState> initializeControllersWithExistingData(dynamic data)async{
    return await compensationViewControllersRepo.initializeControllersWithExistingData(data);
  }

  QualificationViewControllersRepo getControllerWithName()
  {
    return compensationViewControllersRepo;
  }
}