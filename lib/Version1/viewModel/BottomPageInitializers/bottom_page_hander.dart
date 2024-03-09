import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/SummaryListeners/leave_calender_model_listener.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../../Version2/Modules/FCMModule/domain/repo/fcm_payload_dealer_repo.dart';
import '../../../Version2/Modules/ModuleAppVersion/presentation/bloc/version_checker_bloc.dart';
import '../../../utils/internetConnectionChecker/internet_connection.dart';

class BottomPageHandler with GetLoader
{

  void initializeAll(BuildContext context) {
    Provider.of<CheckInternetConnection>(context,listen: false).initConnectivity();
    Provider.of<LeaveCalenderModelListener>(context,listen: false).makeList();
    Provider.of<VersionCheckerNotifier>(context,listen: false).getVersionData(context);
    checkForFcmNotification();
  }

  Future<void> checkForFcmNotification()
  async {
    RemoteMessage? initialMessage = await _checkIfNotificationHasData();
    if(initialMessage!=null)
    {
      _handleInitialNotification(initialMessage);
    }
  }

  Future<RemoteMessage?> _checkIfNotificationHasData()
  async {
    return await FirebaseMessaging.instance.getInitialMessage();
  }
  Future<void> _handleInitialNotification(RemoteMessage initialMessage) async {

    print('Opened app from notification! ${initialMessage.data['payload']}');
    var model = initialMessage.data['payload'];
    FcmPayloadDealerRepo.instance.onSelectedNotification(jsonDecode(model));

  }

}