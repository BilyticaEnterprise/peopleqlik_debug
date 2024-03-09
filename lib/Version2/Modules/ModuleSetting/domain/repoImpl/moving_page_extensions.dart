import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/move_to_approval_pages.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/move_to_user_request_pages.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';

import '../../../../../configs/routing/pages_name.dart';
import '../../../../../mainCommon.dart';
import '../../../FCMModule/domain/models/fcm_notification_received_model.dart';
import '../../../FCMModule/domain/repo/fcm_payload_dealer_repo.dart';

extension MovingToPages on SettingsModelListener
{
  // sendUserToBottomPage()async
  // {
  //   moveToBottomPage();
  //
  //   // if(PageMoverAuthoritySingleton().getCurrentSettingListenerCall() == true)
  //   //   {
  //   //     selectPageByNotification(GetNavigatorStateContext.navigatorKey.currentState!.context, PageMoverAuthoritySingleton().notificationReceivedModel);
  //   //   }
  //   // else
  //   //   {
  //   //     RemoteMessage? initialMessage = await _checkIfNotificationHasData();
  //   //     if(initialMessage!=null)
  //   //       {
  //   //         _handleInitialNotification(initialMessage);
  //   //       }
  //   //     else
  //   //       {
  //   //       }
  //   //   }
  // }

  moveToBottomPage()
  {
    Future.delayed(const Duration(milliseconds: 200),(){
      GetNavigatorStateContext.navigatorKey.currentState?.pushNamedAndRemoveUntil(CurrentPage.MainBottomBarPage, (route) => false);
    });
  }



  void selectPageByNotification(BuildContext context, NotificationReceivedModel? notificationReceivedModel) {
    switch(notificationReceivedModel?.notificationType)
    {
      case '0':
        moveToApprovalPages(notificationReceivedModel);
        break;
      case '1':
        moveToUserRequestPages(notificationReceivedModel);
        break;
      default:
        break;

    }

    ///moveToBottomPage();
  }


}