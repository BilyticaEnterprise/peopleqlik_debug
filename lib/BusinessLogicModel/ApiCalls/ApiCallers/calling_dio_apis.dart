import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/validation_api_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/AuthListeners/save_cookie_globally.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/cookie_model.dart';
import 'package:provider/provider.dart';

import '../../../src/language_codes.dart';
import '../../../src/prints_logs.dart';
import '../../../src/strings.dart';
import '../../Enums/apistatus_enum.dart';
import '../../Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../Models/AuthModels/login_model.dart';
import '../../Models/TimeOffAndEnCashModel/apply_leave_model.dart';
import '../../Models/call_setting_data.dart';
import '../../Models/make_urls.dart';
import '../../SharedPrefs/login_prefs.dart';
import '../../internet_connection.dart';
import '../ApiGlobalModel/api_global_model.dart';
import '../DioSetup/dio_setup.dart';
import '../Urls/urls.dart';
import 'check_type_enums.dart';
import 'model_decider.dart';

class CallingDioApis<T>
{
  ClassType<T> type;
  String endPoint;
  bool? checkCookies;
  bool? isPost,authHeaders;
  String? baseUrl;
  CheckTypes checkTypes;
  dynamic headers;
  dynamic parameters;
  dynamic urlParameters;

  CallingDioApis(
      {
        required this.endPoint,
        required this.type,
        required this.checkTypes,
        this.isPost,
        this.baseUrl,
        this.checkCookies = true,
        this.authHeaders = true,
        this.urlParameters,
        this.parameters,
        this.headers});

  Future<ApiResponse> callApi(BuildContext context)
  async {
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

          PrintLogs.printLogs('ApisCallss ${jsonEncode(response.data)}');
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
class GetHeaders
{
  getAuthHeader(BuildContext context,LoginResultSet? loginResultSet)
  {
    return {
      Headers.acceptHeader: 'application/json',
      "authtokenKey":"${loginResultSet?.headerInfo?.authtokenKey}",
      "GlobalCompanyCode": Provider.of<GlobalSelectedEmployeeController>(context,listen: false).companyData?.company.companyCode??loginResultSet?.headerInfo?.companyCode,
      "Content-Type":"application/json",
      "UserCultureID":"${loginResultSet?.headerInfo?.userCultureID}",
      "CultureID":"${loginResultSet?.headerInfo?.cultureID}",
    };
  }
  getChangeCompanyHeader(LoginResultSet? loginResultSet,dynamic companyCode)
  {
    return {
      Headers.acceptHeader: 'application/json',
      "authtokenKey":"${loginResultSet?.headerInfo?.authtokenKey}",
      "GlobalCompanyCode": companyCode,
      "Content-Type":"application/json",
      "UserCultureID":"${loginResultSet?.headerInfo?.userCultureID}",
      "CultureID":"${loginResultSet?.headerInfo?.cultureID}",
    };
  }
  normalHeader(BuildContext context,LoginResultSet? loginResultSet)
  {
    return {
      Headers.acceptHeader: 'application/json',
      "CultureID":"${loginResultSet?.headerInfo?.cultureID}",
      "Content-Type":"application/json",
      "GlobalCompanyCode": Provider.of<GlobalSelectedEmployeeController>(context,listen: false).companyData?.company.companyCode??loginResultSet?.headerInfo?.companyCode,
    };
  }
}