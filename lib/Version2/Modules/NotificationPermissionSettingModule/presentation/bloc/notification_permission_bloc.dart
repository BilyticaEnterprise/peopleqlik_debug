import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../domain/models/notification_permission_get_model.dart';
import '../../domain/usecases/notification_permission_usecase.dart';

class NotificationGetBloc extends ExtendedCubit<bool> with GetLoader
{
  late NotificationPermissionUseCase useCase;
  late bool currentSetting;
  NotificationGetBloc(super.initialState){
    useCase = NotificationPermissionUseCase();
    currentSetting = super.state;
  }

  getNotificationStatusOnline(BuildContext context)async
  {
    initLoader();
    ApiResponse apiResponse = await useCase.getNotificationSettings(context);
    await closeLoader();
    if(apiResponse.apiStatus == ApiStatus.done)
      {
        NotificationPermissionResultSet? data = apiResponse.data.resultSet as NotificationPermissionResultSet?;
        emit(data?.isNotificationPermissionAllow??false);
      }
    else
      {
        emit(false);
      }
  }

  updateNotificationMapper(bool value){
    currentSetting = value;
    useCase.updateNotificationMapper(currentSetting);
  }

  updateNotificationStatusOnline(BuildContext context)async
  {

    initLoader();
    ApiResponse apiResponse = await useCase.updateNotificationSetting(context);
    await closeLoader();
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      emit(currentSetting);
    }
    else
    {
      emit(false);
    }
  }
}

class NotificationUpdateBloc extends ExtendedCubit<AppState>
{
  NotificationUpdateBloc(super.initialState);

}