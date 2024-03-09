// import 'dart:convert';
// import 'dart:io';
//
// import 'package:device_info/device_info.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
// import 'package:peopleqlik_debug/Version1/Models/AuthModels/company_url_get_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/AuthModels/login_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/Language/update_language_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/TimeOffAndEnCashModel/time_off_get_form_mapper.dart';
// import 'package:peopleqlik_debug/Version1/Models/TimeOffAndEnCashModel/time_off_leave_balance.dart';
// import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
// import 'package:peopleqlik_debug/Version1/Models/make_urls.dart';
// import 'package:peopleqlik_debug/utils/SharedPrefs/company_urls_prefs.dart';
// import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
// import 'package:peopleqlik_debug/Version1/internet_connection.dart';
// import 'package:peopleqlik_debug/src/language_codes.dart';
// import 'package:peopleqlik_debug/src/prints_logs.dart';
// import 'package:peopleqlik_debug/src/strings.dart';
// import 'package:provider/provider.dart';
//
// import 'ApiCallers/api_client_repo_impl.dart';
// import 'DioSetup/dio_setup.dart';
//
// class UpdateLanguageApiCall
// {
//   Future<UpdateLanguageData?> callApi(BuildContext context,int code)
//   async {
//     Response? response;
//     if(Provider.of<CheckInternetConnection>(context,listen: false).internetConnectionEnum == InternetConnectionEnum.available)
//     {
//       if(RequestType.baseUrl==null)
//       {
//         await MakeUrls().saveUrl();
//       }
//       LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
//       try{
//         response = await DioSetUp().getDio().post(
//           '${RequestType.baseUrl}${RequestType.updateLanguage}?UserCultureID=$code',
//           options: Options(
//             sendTimeout: const Duration(milliseconds: 55000),
//             receiveTimeout: const Duration(milliseconds: 55000),
//               headers: GetHeaders().getAuthHeader(context,loginResultSet)
//           ),
//         );
//         //PrintLogs.print('yessss ${jsonEncode(response.data)}');
//         if(response.data!=null)
//         {
//           return UpdateLanguageData(response.statusMessage!,response.statusCode!,UpdateLanguageJson.fromJson(response.data));
//         }
//         else{
//           return UpdateLanguageData(response.statusMessage!,response.statusCode!,null);
//         }
//       }on DioError catch(e)
//       {
//         if (e.response != null) {
//           PrintLogs.printLogs(e.response?.statusCode);
//           PrintLogs.printLogs(e.response?.data);
//           PrintLogs.printLogs(e.response?.headers);
//           PrintLogs.printLogs(e.response?.requestOptions);
//           return UpdateLanguageData(e.response?.statusMessage,e.response?.statusCode,null);
//         } else {
//           // Something happened in setting up or sending the request that triggered an Error
//           PrintLogs.printLogs(e.requestOptions);
//           PrintLogs.printLogs(e.message);
//           return UpdateLanguageData(e.message,response?.statusCode,null);
//         }
//       }
//     }
//     else{
//       return UpdateLanguageData('${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',-1,null);
//     }
//   }
// }
// class UpdateLanguageData
// {
//   String? message;
//   int? code;
//   UpdateLanguageJson? updateLanguageJson;
//   UpdateLanguageData(this.message,this.code,this.updateLanguageJson);
// }