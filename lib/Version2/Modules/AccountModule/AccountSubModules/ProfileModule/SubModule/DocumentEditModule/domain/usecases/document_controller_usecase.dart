import 'package:peopleqlik_debug/utils/States/app_state.dart';

import '../repo/document_view_controllers_repo.dart';

class DocumentControllerUseCase
{
  DocumentViewControllersRepo compensationViewControllersRepo;
  DocumentControllerUseCase(this.compensationViewControllersRepo);

  Future<AppState> initializeControllersWithNewData(dynamic data)async{
    return await compensationViewControllersRepo.initializeControllersWithNewData(data);
  }

  Future<AppState> initializeControllersWithExistingData(dynamic data)async{
    return await compensationViewControllersRepo.initializeControllersWithExistingData(data);
  }

  DocumentViewControllersRepo getControllerWithName()
  {
    return compensationViewControllersRepo;
  }
}