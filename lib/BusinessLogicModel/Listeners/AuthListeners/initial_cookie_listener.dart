import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/AuthListeners/save_cookie_globally.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/cookie_model.dart';
import 'package:provider/provider.dart';

import '../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../ApiCalls/ApiCallers/show_error.dart';
import '../../ApiCalls/ApiGlobalModel/api_global_model.dart';
import '../../ApiCalls/Urls/urls.dart';
import '../../Enums/apistatus_enum.dart';

class CookieModelListener
{
  CookieJson? cookieJson;

  Future? start(BuildContext context)
  async {

    ApiResponse apiResponse = await GetApisUrlCaller().getCookieToken(context);

    if(apiResponse.apiStatus == ApiStatus.done)
    {
      cookieJson = apiResponse.data!;
      Provider.of<SaveCookieGlobally>(context,listen: false).cookieApiCalled = true;
      Provider.of<SaveCookieGlobally>(context,listen: false).saveCookie(cookieJson);
      // await CompanyInfoPrefs().writeCompanyInfoPrefs(jsonEncode(companyDataSet!.toJson()));
      // Future.delayed(const Duration(milliseconds: 100),(){
      //   Navigator.pushNamed(context, CurrentPage.LoginPage);
      // });
    }
    else
    {
      // CompanyInfoPrefs().removeCompanyInfoPrefs();
      ShowErrorMessage.show(apiResponse);
    }
  }
}

