import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/data/extensions/move_to_approval_pages.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/data/extensions/move_to_user_request_pages.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/domain/repo/move_users_to_pages_on_notification_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/FCMModule/domain/models/common_notification_received_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/FCMModule/domain/models/notificationEachTypeModel/approval_request_common_model.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';

class MoveUserToPagesFromNotificationsRepoImpl extends MoveUserToPagesFromNotificationsRepo
{
  @override
  selectPageByNotification(BuildContext context, CommonNotificationModel? notificationReceivedModel) {
    PrintLogs.printLogs('notifcationcalled ${notificationReceivedModel?.data}');
    switch(notificationReceivedModel?.notificationType)
    {
      case 0:
        moveToApprovalPages(ApprovalRequestCommonModel.fromJson(notificationReceivedModel?.data));
        break;
      case 1:
        moveToUserRequestPages(ApprovalRequestCommonModel.fromJson(notificationReceivedModel?.data));
        break;
      default:
        break;

    }

  }

}