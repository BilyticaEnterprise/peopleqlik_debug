import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../../../utils/enums/enum_update_add.dart';
import '../../data/remote/api_client.dart';
import '../../data/repoImpl/contact_view_controller_repo_impl.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/contact_view_controllers_repo.dart';
import '../../domain/usecases/contact_controller_usecase.dart';

class ContactAddEditListener extends ExtendedCubit<AppState>
{
  late ContactControllerUseCase useCase;
  late UpdateAdd updateAdd;

  ContactAddEditListener(super.initialState,this.updateAdd){
    ContactApiClientRepo basicProfileApiClientRepo = ContactApiClientRepoImpl();
    ContactViewControllersRepo basicProfileViewControllersRepo = ContactViewControllersRepoImpl(basicProfileApiClientRepo);
    useCase = ContactControllerUseCase(basicProfileViewControllersRepo);
  }

  start(BuildContext context) async {
    switch(updateAdd)
    {
      case UpdateAdd.update:
        AppState appState = await useCase.initializeControllersWithExistingData('data');
        emit(appState);
        break;
      case UpdateAdd.addNew:
        AppState appState = await useCase.initializeControllersWithNewData('data');
        emit(appState);
        break;
      default:
        break;
    }
  }
}