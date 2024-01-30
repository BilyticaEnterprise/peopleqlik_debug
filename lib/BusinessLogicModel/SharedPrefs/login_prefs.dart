import 'package:shared_preferences/shared_preferences.dart';

class UserInfoPrefs
{
  Future<void> writeUserInfoPrefs(var value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('UserInfoPrefs', value);
  }

  Future? getUserInfoPrefs()async
  {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String d = prefs.getString('UserInfoPrefs')??'{}';
      return d;
    }catch(e){
      return null;
    }
  }
  Future? removeUserInfoPrefs()async
  {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('UserInfoPrefs');
    }catch(e){
      return null;
    }
  }


  Future<void> writeUserPersonalInfoPrefs(var value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('UserPersonalInfoPrefs', value);
  }

  Future? getUserPersonalInfoPrefs()async
  {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String d = prefs.getString('UserPersonalInfoPrefs')??'{}';
      return d;
    }catch(e){
      return null;
    }
  }
  Future? removeUserPersonalInfoPrefs()async
  {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('UserPersonalInfoPrefs');
    }catch(e){
      return null;
    }
  }
}