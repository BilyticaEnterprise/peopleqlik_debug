import 'package:shared_preferences/shared_preferences.dart';

class SettingsPrefs
{
  Future<void> writeSettingsPrefs(var value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('SettingsPrefs', value);
  }

  Future? getSettingsPrefs()async
  {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String d = prefs.getString('SettingsPrefs')??'{}';
      return d;
    }catch(e){
      return null;
    }
  }
  Future? removeSettingsPrefs()async
  {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('SettingsPrefs');
    }catch(e){
      return null;
    }
  }
}