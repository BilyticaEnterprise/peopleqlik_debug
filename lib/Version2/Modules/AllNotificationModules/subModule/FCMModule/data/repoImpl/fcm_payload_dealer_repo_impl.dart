import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/domain/repo/move_users_to_pages_on_notification_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/FCMModule/domain/models/common_notification_received_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationBadge/domain/repo/notification_badge_controller_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/moving_page_extensions.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/configs/routing/get_current_route_name.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:provider/provider.dart';

import '../../domain/repo/fcm_payload_dealer_repo.dart';

class FcmPayloadDealerRepoImpl extends FcmPayloadDealerRepo
{
  @override
  dealWithRealNotifications(Map<dynamic, dynamic>? message) async {
    if(message!=null)
      {
        try{
          var model = await jsonDecode(message['payload']);
          PrintLogs.printLogs('firebasePayLoadIs ${message} ${message['payload']}');
          if(GetNavigatorStateContext.navigatorKey.currentState?.context !=null && GetNavigatorStateContext.navigatorKey.currentState!.context.mounted == true && getCurrentRouteName(GetNavigatorStateContext.navigatorKey.currentState!.context) != CurrentPage.NotificationPage)
            {
              NotificationBadgeControllerRepo.instance.writeNotificationReadPref(true);
            }
        }catch(e){}
      }
  }

  @override
  onSelectedNotification(Map<String, dynamic>? message) {
    BuildContext? context = GetNavigatorStateContext.navigatorKey.currentState?.context;
    Future.delayed(const Duration(milliseconds: 200),(){
      if(context!=null && message != null)
      {
        CommonNotificationModel notificationReceivedModel = CommonNotificationModel.fromJson(message);
        MoveUserToPagesFromNotificationsRepo.instance.selectPageByNotification(context,notificationReceivedModel);
      }
    });
  }

}