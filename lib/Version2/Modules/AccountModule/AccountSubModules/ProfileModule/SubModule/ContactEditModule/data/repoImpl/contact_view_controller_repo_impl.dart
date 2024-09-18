import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/mainCommon.dart';

import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/datePickText/date_controller.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/contact_view_controllers_repo.dart';
import '../../utils/enums/controller_enum.dart';

class ContactViewControllersRepoImpl extends ContactViewControllersRepo
{

  ContactApiClientRepo? contactApiClientRepo;

  ContactViewControllersRepoImpl(this.contactApiClientRepo);

  @override
  Future<AppState> initializeControllersWithNewData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await contactApiClientRepo?.getData(context);

    contactTypeDropDown = DropDownDataController(ContactControllerEnum.type, ['Married']);
    countryDropDown = DropDownDataController(ContactControllerEnum.country, ['Married']);
    cityDropDown = DropDownDataController(ContactControllerEnum.city, ['Married']);
    addressEditTextController = TextFieldControllerCall();
    phoneNumberEditTextController = TextFieldControllerCall();
    mobileNumberEditTextController = TextFieldControllerCall();
    emailEditTextController = TextFieldControllerCall();
    fromDateController = DateController(ContactControllerEnum.fromDate,dateCallBack);
    toDateController = DateController(ContactControllerEnum.toDate,dateCallBack);
    return AppStateDone();
  }

  @override
  Future<AppState> initializeControllersWithExistingData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await contactApiClientRepo?.getData(context);
    contactTypeDropDown = DropDownDataController(ContactControllerEnum.type, ['Married']);
    countryDropDown = DropDownDataController(ContactControllerEnum.country, ['Married']);
    cityDropDown = DropDownDataController(ContactControllerEnum.city, ['Married']);
    addressEditTextController = TextFieldControllerCall();
    phoneNumberEditTextController = TextFieldControllerCall();
    mobileNumberEditTextController = TextFieldControllerCall();
    emailEditTextController = TextFieldControllerCall();
    fromDateController = DateController(ContactControllerEnum.fromDate,dateCallBack);
    toDateController = DateController(ContactControllerEnum.toDate,dateCallBack);
    return AppStateDone();
  }

  dateCallBack(DateReturn dateReturn){

  }
}