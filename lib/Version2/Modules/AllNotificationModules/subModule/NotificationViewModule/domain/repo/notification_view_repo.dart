import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/domain/model/notification_view_list_model.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class NotificationViewRepo
{
  int? _screenId;

  set screenId(int? value) {
    _screenId = value;
  }

  int? get screenId => _screenId;

  List<NotificationListResultSet>? getList();
  fetchListApi(BuildContext context, AppState status);
  readNotificationByScreenId(BuildContext context,{required int screenID});
  readNotificationByNotificationId(BuildContext context,{required int notificationID});

  updateStepNow(bool value, BuildContext context);
  bool isReachEnd();
}