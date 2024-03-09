import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/mainCommon.dart';

import 'package:peopleqlik_debug/utils/DropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/compensation_view_controllers_repo.dart';
import '../../utils/enums/controller_enum.dart';

class CompensationViewControllersRepoImpl extends CompensationViewControllersRepo
{

  CompensationApiClientRepo? basicProfileApiClientRepo;

  CompensationViewControllersRepoImpl(this.basicProfileApiClientRepo);

  @override
  Future<AppState> initializeControllersWithNewData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await basicProfileApiClientRepo?.getData(context);

    documentTypeDropDown = DropDownDataController(CompensationControllerEnum.type, ['Married']);
    documentNameEditTextController = TextFieldControllerCall();
    marEditTextController = TextFieldControllerCall();

    return AppStateDone();
  }

  @override
  Future<AppState> initializeControllersWithExistingData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await basicProfileApiClientRepo?.getData(context);
    documentTypeDropDown = DropDownDataController(CompensationControllerEnum.type, ['Married']);
    documentNameEditTextController = TextFieldControllerCall();
    marEditTextController = TextFieldControllerCall();
    return AppStateDone();
  }


}