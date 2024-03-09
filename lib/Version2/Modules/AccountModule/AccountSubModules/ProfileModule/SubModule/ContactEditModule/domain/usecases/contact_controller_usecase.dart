import 'package:peopleqlik_debug/utils/States/app_state.dart';

import '../repo/contact_view_controllers_repo.dart';

class ContactControllerUseCase
{
  ContactViewControllersRepo compensationViewControllersRepo;
  ContactControllerUseCase(this.compensationViewControllersRepo);

  Future<AppState> initializeControllersWithNewData(dynamic data)async{
    return await compensationViewControllersRepo.initializeControllersWithNewData(data);
  }

  Future<AppState> initializeControllersWithExistingData(dynamic data)async{
    return await compensationViewControllersRepo.initializeControllersWithExistingData(data);
  }

  ContactViewControllersRepo getControllerWithName()
  {
    return compensationViewControllersRepo;
  }
}