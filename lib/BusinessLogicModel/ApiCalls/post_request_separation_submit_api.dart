// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/Urls/urls.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/login_model.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/post_separation_from_model.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/make_urls.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/login_prefs.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
// import 'package:peopleqlik_debug/src/language_codes.dart';
// import 'package:peopleqlik_debug/src/prints_logs.dart';
// import 'package:provider/provider.dart';
//
// import 'ApiCallers/calling_dio_apis.dart';
// import 'DioSetup/dio_setup.dart';
//
// class PostSeparationRequestApiCall
// {
//   Future<PostSeparationRequestData?> callApi(BuildContext context,var map)
//   async {
//     Response? response;
//     if(Provider.of<CheckInternetConnection>(context,listen: false).internetConnectionEnum == InternetConnectionEnum.available)
//     {
//       //PrintLogs.printLogs('ewewrewwewew firts');
//       if(RequestType.baseUrl==null)
//       {
//         await MakeUrls().saveUrl();
//       }
//       LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
//
//       PrintLogs.printLogs('ewewrewwewew ${jsonEncode(map)}');
//       try{
//         response = await DioSetUp().getDio().post(
//           '${RequestType.baseUrl}${RequestType.saveSeparationRequest}',
//           data: map,
//           options: Options(
//             sendTimeout: const Duration(milliseconds: 55000),
//             receiveTimeout: const Duration(milliseconds: 55000),
//               headers: GetHeaders().getAuthHeader(context,loginResultSet)
//           ),
//         );
//         // PrintLogs.print('yessssis ${response.statusCode}');
//          PrintLogs.printLogs('sepeerate ${jsonEncode(response.data)}');
//         if(response.data!=null)
//         {
//           return PostSeparationRequestData(response.statusMessage!,response.statusCode!,SaveSeparationRequestJson.fromJson(response.data));
//         }
//         else{
//           return PostSeparationRequestData(response.statusMessage!,response.statusCode!,null);
//         }
//       }on DioError catch(e)
//       {
//         if (e.response != null) {
//           PrintLogs.printLogs(e.response?.statusCode);
//           PrintLogs.printLogs(e.response?.data);
//           PrintLogs.printLogs(e.response?.headers);
//           PrintLogs.printLogs(e.response?.requestOptions);
//           return PostSeparationRequestData(e.response?.statusMessage,e.response?.statusCode,null);
//         } else {
//           // Something happened in setting up or sending the request that triggered an Error
//           PrintLogs.printLogs(e.requestOptions);
//           PrintLogs.printLogs(e.message);
//           return PostSeparationRequestData(e.message,response?.statusCode,null);
//         }
//       }
//     }
//     else{
//       return PostSeparationRequestData('${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',-1,null);
//     }
//   }
// }
// class PostSeparationRequestData
// {
//   String? message;
//   int? code;
//   SaveSeparationRequestJson? postRequestJson;
//   PostSeparationRequestData(this.message,this.code,this.postRequestJson);
// }