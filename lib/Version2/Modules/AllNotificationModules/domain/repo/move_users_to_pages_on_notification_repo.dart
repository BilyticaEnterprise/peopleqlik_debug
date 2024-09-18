import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/data/repoImpl/move_user_to_pages_on_notification_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/FCMModule/domain/models/common_notification_received_model.dart';

abstract class MoveUserToPagesFromNotificationsRepo
{
  static final MoveUserToPagesFromNotificationsRepo _instance = MoveUserToPagesFromNotificationsRepoImpl();
  static MoveUserToPagesFromNotificationsRepo get instance => _instance;

  selectPageByNotification(BuildContext context, CommonNotificationModel? notificationReceivedModel);
}