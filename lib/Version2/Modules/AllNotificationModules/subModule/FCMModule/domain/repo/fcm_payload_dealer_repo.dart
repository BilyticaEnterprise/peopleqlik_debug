import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/FCMModule/data/repoImpl/fcm_payload_dealer_repo_impl.dart';

import '../models/fcm_notification_received_model.dart';

abstract class FcmPayloadDealerRepo
{
  static final FcmPayloadDealerRepo _instance = FcmPayloadDealerRepoImpl();
  static FcmPayloadDealerRepo get instance => _instance;

  onSelectedNotification(Map<String, dynamic>? message);
  dealWithRealNotifications(Map<dynamic, dynamic>? message);
}