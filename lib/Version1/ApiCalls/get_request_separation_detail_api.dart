// import 'dart:convert';
// import 'dart:io';
//
// import 'package:device_info/device_info.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
// import 'package:peopleqlik_debug/Version1/Models/AuthModels/company_url_get_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/AuthModels/login_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/Notifications/notification_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_detail_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_name_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_separation_detail_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/TimeOffAndEnCashModel/time_off_model.dart';
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
// class GetRequestSeparationDetailsApiCall
// {
//   Future<GetRequestSeparationDetailsData?> callApi(BuildContext context, dynamic id)
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
//      // PrintLogs.printLogs('sendingggg ${Uri.parse('${RequestType.baseUrl}${RequestType.requestDetailUrl}?RequestManagerID=$managerId&RequestCode=$requestCode')}');
//       try{
//         response = await DioSetUp().getDio().get(
//           '${RequestType.baseUrl}${RequestType.getSeparationRequestDetailApi}?ID=$id',
//           options: Options(
//             sendTimeout: const Duration(milliseconds: 55000),
//             receiveTimeout: const Duration(milliseconds: 55000),
//               headers: GetHeaders().getAuthHeader(context,loginResultSet)
//           ),
//         );
//         PrintLogs.printLogs('yessss ${jsonEncode(response.data)}');
//         if(response.data!=null)
//         {
//           return GetRequestSeparationDetailsData(response.statusMessage!,response.statusCode!,GetRequestSeparationDetailsJson.fromJson(response.data));
//         }
//         else{
//           return GetRequestSeparationDetailsData(response.statusMessage!,response.statusCode!,null);
//         }
//       }on DioError catch(e)
//       {
//         if (e.response != null) {
//           PrintLogs.printLogs(e.response?.statusCode);
//           PrintLogs.printLogs(e.response?.data);
//           PrintLogs.printLogs(e.response?.headers);
//           PrintLogs.printLogs(e.response?.requestOptions);
//           return GetRequestSeparationDetailsData(e.response?.statusMessage,e.response?.statusCode,null);
//         } else {
//           // Something happened in setting up or sending the request that triggered an Error
//           PrintLogs.printLogs(e.requestOptions);
//           PrintLogs.printLogs(e.message);
//           return GetRequestSeparationDetailsData(e.message,response?.statusCode,null);
//         }
//       }
//     }
//     else{
//       return GetRequestSeparationDetailsData('${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',-1,null);
//     }
//   }
// }
// class GetRequestSeparationDetailsData
// {
//   String? message;
//   int? code;
//   GetRequestSeparationDetailsJson? getRequestSeparationDetailsJson;
//   GetRequestSeparationDetailsData(this.message,this.code,this.getRequestSeparationDetailsJson);
// }