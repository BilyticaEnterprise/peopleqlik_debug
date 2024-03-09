import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/BasicProfileEditModule/data/remote/api_client.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/BasicProfileEditModule/data/repoImpl/basic_profile_view_controller_repo_impl.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../../../utils/enums/enum_update_add.dart';
import '../../data/remote/api_client.dart';
import '../../data/repoImpl/compensation_view_controller_repo_impl.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/compensation_view_controllers_repo.dart';
import '../../domain/usecases/compensation_controller_usecase.dart';

class CompensationAddEditListener extends ExtendedCubit<AppState> with GetLoader
{
  late CompensationControllerUseCase useCase;
  late UpdateAdd updateAdd;

  CompensationAddEditListener(super.initialState,this.updateAdd){
    CompensationApiClientRepo basicProfileApiClientRepo = CompensationApiClientRepoImpl();
    CompensationViewControllersRepo basicProfileViewControllersRepo = CompensationViewControllersRepoImpl(basicProfileApiClientRepo);
    useCase = CompensationControllerUseCase(basicProfileViewControllersRepo);
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