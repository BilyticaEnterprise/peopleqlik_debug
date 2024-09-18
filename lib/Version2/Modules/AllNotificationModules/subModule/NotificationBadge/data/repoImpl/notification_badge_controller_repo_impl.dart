import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationBadge/data/local/notificaiton_pref.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationBadge/domain/repo/notification_badge_controller_repo.dart';

class NotificationBadgeControllerRepoImpl extends NotificationBadgeControllerRepo
{
  @override
  disposeNotificationStream() {
    streamController.close();
  }

  @override
  updateNotificationStream(bool update) {
    print('kjansjdnasdasjhas $update');
    streamController.add(update);
  }

  @override
  Stream getStream() {
    return streamController.stream;
  }

  @override
  checkLazily() async {
    updateNotificationStream(await NotificationReadPref().getNotificationReadPref());
  }

  @override
  writeNotificationReadPref(bool value) async {
    await NotificationReadPref().writeNotificationReadPref(value);
    checkLazily();
  }
}