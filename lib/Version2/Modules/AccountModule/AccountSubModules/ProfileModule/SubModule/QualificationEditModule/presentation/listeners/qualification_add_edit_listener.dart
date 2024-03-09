import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../../../utils/enums/enum_update_add.dart';
import '../../data/remote/api_client.dart';
import '../../data/repoImpl/qualification_view_controller_repo_impl.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/qualification_view_controllers_repo.dart';
import '../../domain/usecases/qualification_controller_usecase.dart';

class QualificationAddEditListener extends ExtendedCubit<AppState>
{
  late QualificationControllerUseCase useCase;
  late UpdateAdd updateAdd;

  QualificationAddEditListener(super.initialState,this.updateAdd){
    QualificationApiClientRepo basicProfileApiClientRepo = QualificationApiClientRepoImpl();
    QualificationViewControllersRepo basicProfileViewControllersRepo = QualificationViewControllersRepoImpl(basicProfileApiClientRepo);
    useCase = QualificationControllerUseCase(basicProfileViewControllersRepo);
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