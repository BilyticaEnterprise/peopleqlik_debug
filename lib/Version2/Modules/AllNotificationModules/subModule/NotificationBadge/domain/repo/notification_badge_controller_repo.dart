import 'dart:async';

import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationBadge/data/repoImpl/notification_badge_controller_repo_impl.dart';

abstract class NotificationBadgeControllerRepo
{
  StreamController<bool> streamController = StreamController.broadcast();

  static final NotificationBadgeControllerRepo _instance = NotificationBadgeControllerRepoImpl();
  static NotificationBadgeControllerRepo get instance => _instance;

  disposeNotificationStream();
  updateNotificationStream(bool update);
  checkLazily();
  writeNotificationReadPref(bool value);

  Stream getStream();

}