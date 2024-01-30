import 'package:shared_preferences/shared_preferences.dart';

class LeaveCalenderPrefs
{
  Future<void> writeLeaveCalenderPrefs(var value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('LeaveCalenderPrefs', value);
  }

  Future? getLeaveCalenderPrefs()async
  {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? d = prefs.getString('LeaveCalenderPrefs');
      return d;
    }catch(e){
      return null;
    }
  }
  Future? removeLeaveCalenderPrefs()async
  {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('LeaveCalenderPrefs');
    }catch(e){
      return null;
    }
  }
}