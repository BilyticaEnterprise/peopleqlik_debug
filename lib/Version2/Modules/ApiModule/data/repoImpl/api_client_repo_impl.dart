import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/validation_api_data.dart';
import 'package:peopleqlik_debug/Version1/viewModel/AuthListeners/save_cookie_globally.dart';
import 'package:peopleqlik_debug/Version1/Models/AuthModels/cookie_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/repo/api_client_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/headers.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/language_codes.dart';
import '../../../../../configs/prints_logs.dart';
import '../../../../../utils/strings.dart';
import '../../../../../Version1/Models/AuthModels/login_model.dart';
import '../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../Version1/Models/make_urls.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import '../../../../../utils/internetConnectionChecker/internet_connection.dart';
import '../../domain/model/api_global_model.dart';
import '../../utils/dio_setup.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import '../../utils/check_type_enums.dart';

class GlobalApiCallerRepoImpl<T> extends GlobalApiCallerRepo
{

  @override
  Future<ApiResponse> callApi(BuildContext context, {required String endPoint, required ClassType type, required CheckTypes checkTypes, bool? isPost, String? baseUrl, bool? checkCookies = true, bool? authHeaders = true, urlParameters, parameters, headers}) async {
    Response? response;
    SaveCookieGlobally saveCookieGlobally = Provider.of<SaveCookieGlobally>(context,listen: false);

    if(Provider.of<CheckInternetConnection>(context,listen: false).internetConnectionEnum == InternetConnectionEnum.available)
    {
      LoginResultSet? loginResultSet;
      if(RequestType.baseUrl==null)
      {
        await MakeUrls().saveUrl();
      }

      if(authHeaders==true)
      {
        try{
          loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
          if(loginResultSet.headerInfo==null)
          {
            return ApiResponse(CallLanguageKeyWords.get(context, LanguageCodes.reLogin),401,ApiStatus.unAuthorized,null);
          }
        }catch(e){
          return ApiResponse(CallLanguageKeyWords.get(context, LanguageCodes.reLogin),401,ApiStatus.unAuthorized,null);
        }
      }

      // PrintLogs.printLogs('authashjdbasb ${GetHeaders().getAuthHeader(context,loginResultSet)}');
      try{
        if(isPost==true)
        {
          PrintLogs.printLogs(urlParameters!=null?'${baseUrl??RequestType.baseUrl}$endPoint$urlParameters':'${baseUrl??RequestType.baseUrl}$endPoint');
          response = await DioSetUp().getDio(cookieToken: saveCookieGlobally.cookieJson?.cookie).post(
            urlParameters!=null?'${baseUrl??RequestType.baseUrl}$endPoint$urlParameters':'${baseUrl??RequestType.baseUrl}$endPoint',
            data: parameters,
            options: Options(
              sendTimeout: RequestType.timeOut,
              receiveTimeout: RequestType.timeOut,
              headers: headers??(authHeaders==true?GetHeaders().getAuthHeader(context,loginResultSet):GetHeaders().normalHeader(context,loginResultSet)),
            ),
          );
        }
        else
        {
          PrintLogs.printLogs(urlParameters!=null?'${baseUrl??RequestType.baseUrl}$endPoint$urlParameters':'${baseUrl??RequestType.baseUrl}$endPoint');
          response = await DioSetUp().getDio(cookieToken: saveCookieGlobally.cookieJson?.cookie).get(
            urlParameters!=null?'${baseUrl??RequestType.baseUrl}$endPoint$urlParameters':'${baseUrl??RequestType.baseUrl}$endPoint',
            options: Options(
              sendTimeout: RequestType.timeOut,
              receiveTimeout: RequestType.timeOut,
              headers: headers??(authHeaders==true?GetHeaders().getAuthHeader(context,loginResultSet):GetHeaders().normalHeader(context,loginResultSet)),
            ),
          );
        }
        if(response.data!=null)
        {
          if(checkCookies==true)
          {
            PrintLogs.printLogs('ApisCallsscookie ${jsonEncode(response.data)}');
            CookieJson? cookieJson = getCookieClass(response);

            if(cookieJson!=null)
            {
              saveCookieGlobally.saveCookie(cookieJson);
            }
            else
            {
              return ApiResponse('Anti Forgery Token Error. ${GetVariable.errorValue}',401,ApiStatus.unAuthorized,null);
            }
          }

          PrintLogs.printLogs('ApisCallss $endPoint ${jsonEncode(response.data)}');
          if(checkTypes == CheckTypes.cookie)
          {
            return ValidationApiData().getCookie(ApiResponse(response.statusMessage,response.statusCode,ApiStatus.error,null), response);
          }
          ApiResponse apiResponse = ApiResponse(response.statusMessage!,response.statusCode!,ApiStatus.done,type.callCConstructor(response.data));
          if(checkTypes == CheckTypes.includeData)
          {
            return ValidationApiData().includeData(apiResponse);
          }
          else if(checkTypes == CheckTypes.includeListData)
          {
            return ValidationApiData().includeListData(apiResponse);
          }
          else if(checkTypes == CheckTypes.includeListInsideData)
          {
            return ValidationApiData().includeListInsideData(apiResponse);
          }
          else if(checkTypes == CheckTypes.includeEntityData)
          {
            return ValidationApiData().includeEntityData(apiResponse);
          }
          else
          {
            return ValidationApiData().onlyBool(apiResponse);
          }

        }
        else{
          if(checkTypes == CheckTypes.cookie)
          {
            return ValidationApiData().getCookie(ApiResponse(response.statusMessage,response.statusCode,ApiStatus.error,null), response);
          }
          else
          {
            return ApiResponse(response.statusMessage,response.statusCode,ApiStatus.empty,null);
          }
        }
      }on DioException catch(e)
      {
        if (e.response != null) {
          //PrintLogs.printLogs('${e.response?.statusCode}');
          PrintLogs.printLogs('iasdjnasndjkas ${e.response?.statusMessage} ${e.response?.statusCode}');
          // PrintLogs.printLogs(e.response?.headers);
          // PrintLogs.printLogs(e.response?.requestOptions);
          if(e.response?.statusCode==401)
          {
            return ApiResponse(CallLanguageKeyWords.get(context, LanguageCodes.reLogin),e.response?.statusCode,ApiStatus.unAuthorized,null);
          }
          return ApiResponse(e.response?.statusMessage,e.response?.statusCode,ApiStatus.error,null);
        } else {
          PrintLogs.printLogs('elseiasdjnasndjkas ${e.toString()}');
          // Something happened in setting up or sending the request that triggered an Error
          // PrintLogs.printLogs(e.requestOptions);
          // PrintLogs.printLogs(e.message);
          if(response?.statusCode==401)
          {
            return ApiResponse(CallLanguageKeyWords.get(context, LanguageCodes.reLogin),e.response?.statusCode,ApiStatus.unAuthorized,null);
          }
          return ApiResponse(e.message??e.toString(),response?.statusCode,ApiStatus.error,null);
        }
      }
    }
    else{
      PrintLogs.printLogs('elseinternetasdas ${CallLanguageKeyWords.get(context, LanguageCodes.stringInternet)} ${ApiStatus.noInternet}');
      return ApiResponse('${CallLanguageKeyWords.get(context, LanguageCodes.stringInternet)}',-1,ApiStatus.noInternet,null);
    }
  }
}
