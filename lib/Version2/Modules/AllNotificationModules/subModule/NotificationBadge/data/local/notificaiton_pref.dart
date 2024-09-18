import 'package:shared_preferences/shared_preferences.dart';

class NotificationReadPref
{
  Future<void> writeNotificationReadPref(bool value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('NotificationReadPref', value);
  }

  Future<bool> getNotificationReadPref()async
  {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool d = prefs.getBool('NotificationReadPref')??false;
      return d;
    }catch(e){
      return false;
    }
  }
}