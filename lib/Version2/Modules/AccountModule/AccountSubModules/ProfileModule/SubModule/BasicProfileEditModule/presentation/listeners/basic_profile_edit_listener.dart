import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/BasicProfileEditModule/data/remote/api_client.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/BasicProfileEditModule/data/repoImpl/basic_profile_view_controller_repo_impl.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../../../utils/enums/enum_update_add.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/basic_profile_view_controllers_repo.dart';
import '../../domain/usecases/basic_profile_controller_usecase.dart';

class BasicProfileAddEditListener extends ExtendedCubit<AppState> with GetLoader
{
  late BasicProfileControllerUseCase useCase;
  late UpdateAdd updateAdd;

  BasicProfileAddEditListener(super.initialState,this.updateAdd){
    BasicProfileApiClientRepo basicProfileApiClientRepo = BasicProfileApiClientRepoImpl();
    BasicProfileViewControllersRepo basicProfileViewControllersRepo = BasicProfileViewControllersRepoImpl(basicProfileApiClientRepo);
    useCase = BasicProfileControllerUseCase(basicProfileViewControllersRepo);
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