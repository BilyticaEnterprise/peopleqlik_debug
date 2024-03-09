import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../../../utils/enums/enum_update_add.dart';
import '../../data/remote/api_client.dart';
import '../../data/repoImpl/payment_controller_repo_impl.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/payment_controllers_repo.dart';
import '../../domain/usecases/payment_controller_usecase.dart';

class PaymentAddEditListener extends ExtendedCubit<AppState>
{
  late PaymentControllerUseCase useCase;
  late UpdateAdd updateAdd;

  PaymentAddEditListener(super.initialState,this.updateAdd){
    PaymentApiClientRepo basicProfileApiClientRepo = PaymentApiClientRepoImpl();
    PaymentControllersRepo basicProfileViewControllersRepo = PaymentControllersRepoImpl(basicProfileApiClientRepo);
    useCase = PaymentControllerUseCase(basicProfileViewControllersRepo);
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