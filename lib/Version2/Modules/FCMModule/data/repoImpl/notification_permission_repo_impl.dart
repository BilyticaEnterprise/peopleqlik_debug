import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/src/widgets/framework.dart';

import '../../../ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../../../mainCommon.dart';
import '../../domain/repo/notification_permission.dart';

class CheckFcmPermissionRepoImpl extends CheckFcmPermissionRepo
{
  @override
  Future<bool?>? checkPermission(BuildContext context, FirebaseMessaging firebaseMessaging) async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    if(settings.authorizationStatus == AuthorizationStatus.authorized)
    {
      UseCaseGetApisUrlCaller().postFCMTokenSetting(context,{"IsNotificationPermissionAllow": true});
      return true;
    }
    else
    {
      if(context!=null) {
        UseCaseGetApisUrlCaller().postFCMTokenSetting(context,{"IsNotificationPermissionAllow": false});
      }
    }
    return false;
  }

}