import 'package:peopleqlik_debug/utils/States/app_state.dart';

import '../repo/basic_profile_view_controllers_repo.dart';

class BasicProfileControllerUseCase
{
  BasicProfileViewControllersRepo basicProfileViewControllersRepo;
  BasicProfileControllerUseCase(this.basicProfileViewControllersRepo);

  Future<AppState> initializeControllersWithNewData(dynamic data)async{
    return await basicProfileViewControllersRepo.initializeControllersWithNewData(data);
  }

  Future<AppState> initializeControllersWithExistingData(dynamic data)async{
    return await basicProfileViewControllersRepo.initializeControllersWithExistingData(data);
  }

  BasicProfileViewControllersRepo getControllerWithName()
  {
    return basicProfileViewControllersRepo;
  }
}