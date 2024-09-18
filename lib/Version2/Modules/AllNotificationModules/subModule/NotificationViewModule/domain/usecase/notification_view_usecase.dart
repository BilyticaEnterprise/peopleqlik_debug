import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/domain/model/notification_view_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/domain/repo/notification_view_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class NotificationViewUseCase
{
  NotificationViewRepo repo;

  NotificationViewUseCase({required this.repo});

  startGettingResult(BuildContext context, AppState status){
    return repo.fetchListApi(context,status);
  }

  List<NotificationListResultSet>? getList(){
    return repo.getList();
  }

  updateStep(bool value, BuildContext context)
  {
    repo.updateStepNow(value, context);
  }
  getIsReachEnd()
  {
    return repo.isReachEnd();
  }
}