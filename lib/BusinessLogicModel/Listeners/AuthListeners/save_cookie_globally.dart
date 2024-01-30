import 'package:dio/dio.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';

import '../../Models/AuthModels/cookie_model.dart';

class SaveCookieGlobally
{
  CookieJson? cookieJson;

  bool _cookieApiCalled = false;

  bool get cookieApiCalled => _cookieApiCalled;

  set cookieApiCalled(bool cookieApiCalled) => _cookieApiCalled = cookieApiCalled;


  saveCookie(CookieJson? cookieJson)
  {
    this.cookieJson = cookieJson;
  }
}
getCookieClass(Response? response)
{
  final cookies = response?.headers.map['set-cookie'];
  if (cookies!=null && cookies.isNotEmpty) {
    try{
      PrintLogs.printLogs('cokasdasdas ${cookies}');
      var cookie = cookies.where((element) => element.contains('XRF_TOKEN'));
      PrintLogs.printLogs('cokasdasdas2 ${cookie}');
      final authToken = cookie.toString().split(';')[0].split('=')[1]; //it depends on how your server sending cookie
      PrintLogs.printLogs('cokasdasdas3 ${authToken}');
      return CookieJson(cookie: authToken);
    }catch(e){
      return null;
    }
  }
}