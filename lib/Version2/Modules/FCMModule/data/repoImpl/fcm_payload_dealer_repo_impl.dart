import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/moving_page_extensions.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/prints_logs.dart';
import '../../../../../mainCommon.dart';
import '../../../ModuleSetting/domain/repoImpl/settings_listeners.dart';
import '../../domain/models/fcm_notification_received_model.dart';
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
          NotificationReceivedModel fcmResultModel = NotificationReceivedModel.fromJson(model);
          BuildContext? currentContext = GetNavigatorStateContext.navigatorKey.currentState?.context;
          // if(currentContext != null)
          // {
          //   Provider.of<SettingsModelListener>(currentContext,listen: false);
          // }
        }catch(e){}
      }
  }

  @override
  onSelectedNotification(Map<String, dynamic>? message) {
    BuildContext? context = GetNavigatorStateContext.navigatorKey.currentState?.context;
    Future.delayed(const Duration(milliseconds: 200),(){
      if(context!=null && message != null)
      {
        NotificationReceivedModel notificationReceivedModel = NotificationReceivedModel.fromJson(message);
        SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
        settingsModelListener.selectPageByNotification(context,notificationReceivedModel);
      }
    });
  }

}