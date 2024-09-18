import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/mainCommon.dart';

import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/datePickText/date_controller.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/family_view_controllers_repo.dart';
import '../../utils/enums/controller_enum.dart';

class FamilyViewControllersRepoImpl extends FamilyViewControllersRepo
{

  FamilyApiClientRepo? contactApiClientRepo;
  FamilyViewControllersRepoImpl(this.contactApiClientRepo);

  @override
  Future<AppState> initializeControllersWithNewData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await contactApiClientRepo?.getData(context);

    relationShipDropDown = DropDownDataController(FamilyControllerEnum.relationShip, ['Married']);
    genderDropDown = DropDownDataController(FamilyControllerEnum.gender, ['Married']);
    martialDropDown = DropDownDataController(FamilyControllerEnum.martialStatus, ['Married']);
    firstNameEditTextController = TextFieldControllerCall();
    lastNameEditTextController = TextFieldControllerCall();
    mobileNumberEditTextController = TextFieldControllerCall();
    emailEditTextController = TextFieldControllerCall();
    identificationNumberEditTextController = TextFieldControllerCall();
    passportNumberEditTextController = TextFieldControllerCall();
    remarksNumberEditTextController = TextFieldControllerCall();
    expiryDateController = DateController(FamilyControllerEnum.expiryDate,dateCallBack);
    dobDateController = DateController(FamilyControllerEnum.dobDate,dateCallBack);
    return AppStateDone();
  }

  @override
  Future<AppState> initializeControllersWithExistingData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await contactApiClientRepo?.getData(context);
    relationShipDropDown = DropDownDataController(FamilyControllerEnum.relationShip, ['Married']);
    genderDropDown = DropDownDataController(FamilyControllerEnum.gender, ['Married']);
    martialDropDown = DropDownDataController(FamilyControllerEnum.martialStatus, ['Married']);
    firstNameEditTextController = TextFieldControllerCall();
    lastNameEditTextController = TextFieldControllerCall();
    mobileNumberEditTextController = TextFieldControllerCall();
    emailEditTextController = TextFieldControllerCall();
    identificationNumberEditTextController = TextFieldControllerCall();
    passportNumberEditTextController = TextFieldControllerCall();
    remarksNumberEditTextController = TextFieldControllerCall();
    expiryDateController = DateController(FamilyControllerEnum.expiryDate,dateCallBack);
    dobDateController = DateController(FamilyControllerEnum.dobDate,dateCallBack);
    return AppStateDone();
  }

  dateCallBack(DateReturn dateReturn){

  }
}