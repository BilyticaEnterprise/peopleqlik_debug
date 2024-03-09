// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
// import 'package:peopleqlik_debug/Version1/Models/AuthModels/login_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/PaysSlipApprovalsRequest/RequestsModel/post_separation_from_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/PaysSlipApprovalsRequest/RequestsModel/save_request_separation_calendar_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
// import 'package:peopleqlik_debug/Version1/Models/make_urls.dart';
// import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
// import 'package:peopleqlik_debug/Version1/internet_connection.dart';
// import 'package:peopleqlik_debug/src/language_codes.dart';
// import 'package:peopleqlik_debug/src/prints_logs.dart';
// import 'package:provider/provider.dart';
//
// import 'ApiCallers/api_client_repo_impl.dart';
// import 'DioSetup/dio_setup.dart';
//
// class PostSeparationCalendarRequestApiCall
// {
//   Future<PostSeparationCalendarRequestData?> callApi(BuildContext context,var id,var date,var remarks)
//   async {
//     Response? response;
//     if(Provider.of<CheckInternetConnection>(context,listen: false).internetConnectionEnum == InternetConnectionEnum.available)
//     {
//       if(RequestType.baseUrl==null)
//       {
//         await MakeUrls().saveUrl();
//       }
//       LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
//
//       try{
//         response = await DioSetUp().getDio().get(
//           '${RequestType.baseUrl}${RequestType.saveSeparationCalendar}?ID=$id&LastWorkingDate=$date&NewRemarks=$remarks',
//           options: Options(
//             sendTimeout: const Duration(milliseconds: 55000),
//             receiveTimeout: const Duration(milliseconds: 55000),
//               headers: GetHeaders().getAuthHeader(context,loginResultSet)
//           ),
//         );
//         // PrintLogs.print('yessssis ${response.statusCode}');
//         // PrintLogs.print('yessss ${jsonEncode(response.data)}');
//         if(response.data!=null)
//         {
//           return PostSeparationCalendarRequestData(response.statusMessage!,response.statusCode!,SaveSeparationCalendarRequestJson.fromJson(response.data));
//         }
//         else{
//           return PostSeparationCalendarRequestData(response.statusMessage!,response.statusCode!,null);
//         }
//       }on DioError catch(e)
//       {
//         if (e.response != null) {
//           PrintLogs.printLogs(e.response?.statusCode);
//           PrintLogs.printLogs(e.response?.data);
//           PrintLogs.printLogs(e.response?.headers);
//           PrintLogs.printLogs(e.response?.requestOptions);
//           return PostSeparationCalendarRequestData(e.response?.statusMessage,e.response?.statusCode,null);
//         } else {
//           // Something happened in setting up or sending the request that triggered an Error
//           PrintLogs.printLogs(e.requestOptions);
//           PrintLogs.printLogs(e.message);
//           return PostSeparationCalendarRequestData(e.message,response?.statusCode,null);
//         }
//       }
//     }
//     else{
//       return PostSeparationCalendarRequestData('${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',-1,null);
//     }
//   }
// }
// class PostSeparationCalendarRequestData
// {
//   String? message;
//   int? code;
//   SaveSeparationCalendarRequestJson? postRequestJson;
//   PostSeparationCalendarRequestData(this.message,this.code,this.postRequestJson);
// }