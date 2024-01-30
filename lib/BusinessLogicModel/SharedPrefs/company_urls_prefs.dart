import 'package:shared_preferences/shared_preferences.dart';

class CompanyInfoPrefs
{
  Future<void> writeCompanyInfoPrefs(var value) async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('CompanyInfoPrefs', value);
  }

  Future? getCompanyInfoPrefs()async
  {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String d = prefs.getString('CompanyInfoPrefs')??'{}';
      return d;
    }catch(e){
      return null;
    }
  }
  Future? removeCompanyInfoPrefs()async
  {
    try{
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.remove('CompanyInfoPrefs');
    }catch(e){
      return null;
    }
  }

}