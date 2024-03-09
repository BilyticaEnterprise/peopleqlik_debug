import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/mainCommon.dart';

import 'package:peopleqlik_debug/utils/DropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/DatePickText/date_controller.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';
import '../../domain/repo/api_client_repo.dart';
import '../../domain/repo/qualification_view_controllers_repo.dart';
import '../../utils/enums/controller_enum.dart';

class QualificationViewControllersRepoImpl extends QualificationViewControllersRepo
{

  QualificationApiClientRepo? qualificationApiClientRepo;

  QualificationViewControllersRepoImpl(this.qualificationApiClientRepo);

  @override
  Future<AppState> initializeControllersWithNewData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await qualificationApiClientRepo?.getData(context);

    qualificationTypeDropDown = DropDownDataController(QualificationControllerEnum.qualificationCode, ['Married']);
    countryDropDown = DropDownDataController(QualificationControllerEnum.country, ['Married']);
    instituteNameEditTextController = TextFieldControllerCall();
    obtainedMarksEditTextController = TextFieldControllerCall();
    totalMarksEditTextController = TextFieldControllerCall();
    fromDateController = DateController(QualificationControllerEnum.fromDate,dateCallBack);
    toDateController = DateController(QualificationControllerEnum.toDate,dateCallBack);
    return AppStateDone();
  }

  @override
  Future<AppState> initializeControllersWithExistingData(dynamic data)async {
    BuildContext context = GetNavigatorStateContext.navigatorKey.currentState!.context;
    await qualificationApiClientRepo?.getData(context);
    qualificationTypeDropDown = DropDownDataController(QualificationControllerEnum.qualificationCode, ['Married']);
    countryDropDown = DropDownDataController(QualificationControllerEnum.country, ['Married']);
    instituteNameEditTextController = TextFieldControllerCall();
    obtainedMarksEditTextController = TextFieldControllerCall();
    totalMarksEditTextController = TextFieldControllerCall();
    fromDateController = DateController(QualificationControllerEnum.fromDate,dateCallBack);
    toDateController = DateController(QualificationControllerEnum.toDate,dateCallBack);
    return AppStateDone();
  }

  dateCallBack(DateReturn dateReturn){

  }
}