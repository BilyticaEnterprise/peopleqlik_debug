import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/mainCommon.dart';

import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/payment_controllers_repo.dart';
import '../../utils/enums/controller_enum.dart';


class PaymentControllersRepoImpl extends PaymentControllersRepo
{

  PaymentApiClientRepo? paymentApiClientRepo;

  PaymentControllersRepoImpl(this.paymentApiClientRepo);

  @override
  Future<AppState> initializeControllersWithNewData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await paymentApiClientRepo?.getData(context);

    paymentMethodDropDown = DropDownDataController(PaymentControllerEnum.paymentMethod, ['Married']);
    accountTypeDropDown = DropDownDataController(PaymentControllerEnum.accountType, ['Married']);
    beneficiaryBankDropDown = DropDownDataController(PaymentControllerEnum.beneficiaryBank, ['Married']);
    beneficiaryBranchDropDown = DropDownDataController(PaymentControllerEnum.beneficiaryBranch, ['Married']);
    employeeAccountEditTextController = TextFieldControllerCall();
    iBANCodeEditTextController = TextFieldControllerCall();

    return AppStateDone();
  }

  @override
  Future<AppState> initializeControllersWithExistingData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await paymentApiClientRepo?.getData(context);
    paymentMethodDropDown = DropDownDataController(PaymentControllerEnum.paymentMethod, ['Married']);
    accountTypeDropDown = DropDownDataController(PaymentControllerEnum.accountType, ['Married']);
    beneficiaryBankDropDown = DropDownDataController(PaymentControllerEnum.beneficiaryBank, ['Married']);
    beneficiaryBranchDropDown = DropDownDataController(PaymentControllerEnum.beneficiaryBranch, ['Married']);
    employeeAccountEditTextController = TextFieldControllerCall();
    iBANCodeEditTextController = TextFieldControllerCall();
    return AppStateDone();
  }


}