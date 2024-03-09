import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/mainCommon.dart';

import 'package:peopleqlik_debug/utils/DropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/basic_profile_view_controllers_repo.dart';
import '../../utils/enums/controller_enum.dart';

class BasicProfileViewControllersRepoImpl extends BasicProfileViewControllersRepo
{

  BasicProfileApiClientRepo? basicProfileApiClientRepo;

  BasicProfileViewControllersRepoImpl(this.basicProfileApiClientRepo);

  @override
  Future<AppState> initializeControllersWithNewData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await basicProfileApiClientRepo?.getData(context);

    martialStatusDropDown = DropDownDataController(BasicProfileControllerEnum.martialStatusEnum, ['Married']);
    genderDropDown = DropDownDataController(BasicProfileControllerEnum.gender, ['Married']);
    religionDropDown = DropDownDataController(BasicProfileControllerEnum.religion, ['Married']);
    ethnicityDropDown = DropDownDataController(BasicProfileControllerEnum.ethnicity, ['Married']);
    identificationNoEditTextController = TextFieldControllerCall();
    officialEmailEditTextController = TextFieldControllerCall();

    return AppStateDone();
  }

  @override
  Future<AppState> initializeControllersWithExistingData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await basicProfileApiClientRepo?.getData(context);
    martialStatusDropDown = DropDownDataController(BasicProfileControllerEnum.martialStatusEnum, ['Married']);
    genderDropDown = DropDownDataController(BasicProfileControllerEnum.gender, ['Married']);
    religionDropDown = DropDownDataController(BasicProfileControllerEnum.religion, ['Married']);
    ethnicityDropDown = DropDownDataController(BasicProfileControllerEnum.ethnicity, ['Married']);
    identificationNoEditTextController = TextFieldControllerCall();
    officialEmailEditTextController = TextFieldControllerCall();
    return AppStateDone();
  }


}