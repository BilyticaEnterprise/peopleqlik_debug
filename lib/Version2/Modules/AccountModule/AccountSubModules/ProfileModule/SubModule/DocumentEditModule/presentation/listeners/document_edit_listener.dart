import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../../../utils/enums/enum_update_add.dart';
import '../../data/remote/api_client.dart';
import '../../data/repoImpl/document_view_controller_repo_impl.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/document_view_controllers_repo.dart';
import '../../domain/usecases/document_controller_usecase.dart';

class DocumentAddEditListener extends ExtendedCubit<AppState> with GetLoader
{
  late DocumentControllerUseCase useCase;
  late UpdateAdd updateAdd;

  DocumentAddEditListener(super.initialState,this.updateAdd){
    DocumentApiClientRepo basicProfileApiClientRepo = DocumentApiClientRepoImpl();
    DocumentViewControllersRepo basicProfileViewControllersRepo = DocumentViewControllersRepoImpl(basicProfileApiClientRepo);
    useCase = DocumentControllerUseCase(basicProfileViewControllersRepo);
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