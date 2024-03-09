import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/AuthListeners/save_cookie_globally.dart';
import 'package:peopleqlik_debug/Version1/Models/AuthModels/cookie_model.dart';
import 'package:provider/provider.dart';

import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

class CookieModelListener
{
  CookieJson? cookieJson;

  Future? start(BuildContext context)
  async {

    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getCookieToken(context);

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

