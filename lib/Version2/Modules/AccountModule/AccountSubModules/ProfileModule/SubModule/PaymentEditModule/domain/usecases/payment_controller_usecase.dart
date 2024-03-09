import 'package:peopleqlik_debug/utils/States/app_state.dart';

import '../repo/payment_controllers_repo.dart';

class PaymentControllerUseCase
{
  PaymentControllersRepo paymentControllerRepo;

  PaymentControllerUseCase(this.paymentControllerRepo);

  Future<AppState> initializeControllersWithNewData(dynamic data)async{
    return await paymentControllerRepo.initializeControllersWithNewData(data);
  }

  Future<AppState> initializeControllersWithExistingData(dynamic data)async{
    return await paymentControllerRepo.initializeControllersWithExistingData(data);
  }

  PaymentControllersRepo getControllerWithName()
  {
    return paymentControllerRepo;
  }
}