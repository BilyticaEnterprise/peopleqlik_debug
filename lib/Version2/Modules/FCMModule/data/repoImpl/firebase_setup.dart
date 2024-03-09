import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/FCMModule/domain/repo/notification_permission.dart';

import '../../../../../mainCommon.dart';
import '../../domain/repo/fcm_payload_dealer_repo.dart';

class FirebaseSetup
{
  static late BuildContext context;
  static Future init(BuildContext contextIs,{String? deviceId}) async {
    context = contextIs;

    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    if (await CheckFcmPermissionRepo.instance.checkPermission(contextIs, _firebaseMessaging) == true) {

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        //print('messsshelooPEN ${message}');
        FcmPayloadDealerRepo.instance.onSelectedNotification(message.data);
      });

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        try{
          // Provider.of<NotificationDataSender>(context,listen: false).getCurrentRouteName(context);
          //print('messsshelo ${jsonEncode(message.data).toString()}');
          showNotification(message.data,message.notification);

        }catch(e){
          //print(e.toString());
        }
      });
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      String? token;

      if (Platform.isIOS) {
        String? apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken != null) {
          token = await _firebaseMessaging.getToken();
        } else {
          await Future<void>.delayed(
            const Duration(
              seconds: 3,
            ),
          );
          apnsToken = await _firebaseMessaging.getAPNSToken();
          if (apnsToken != null) {
            token = await _firebaseMessaging.getToken();
          }
        }
      } else {
        token = await _firebaseMessaging.getToken();
      }
      // For testing purposes print the Firebase Messaging token
      //print("FirebaseMessaging token: $token");
      await Future(()async{
        await UseCaseGetApisUrlCaller().postFCMToken(GetNavigatorStateContext.navigatorKey.currentState!.context,{
          "DeviceID" : deviceId,
          "Token" : token
        });
      });
    } else {

      //print('User declined or has not accepted permission');
    }

  }
  static Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.

    //showNotification(message.data,message.notification);
    FcmPayloadDealerRepo.instance.dealWithRealNotifications(message.data);
    //print('Handling a background message ${message.messageId}');
  }

  static showNotification(Map<dynamic, dynamic>? message, RemoteNotification? notification)async
  {
    showNotificationWithSound(notification?.title,notification?.body,message);
    FcmPayloadDealerRepo.instance.dealWithRealNotifications(message);
  }
}

