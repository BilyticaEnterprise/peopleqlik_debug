// import 'dart:convert';
// import 'dart:io';
//
// import 'package:device_info/device_info.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/Urls/urls.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/company_url_get_model.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/login_model.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/Notifications/notification_model.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_approvals_list.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_payslip_list.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_payslip_month.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/post_request_model.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/post_encashment_request_model.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/time_off_model.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/make_urls.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/company_urls_prefs.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/login_prefs.dart';
// import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
// import 'package:peopleqlik_debug/src/language_codes.dart';
// import 'package:peopleqlik_debug/src/prints_logs.dart';
// import 'package:peopleqlik_debug/src/strings.dart';
// import 'package:provider/provider.dart';
//
// import 'ApiCallers/calling_dio_apis.dart';
// import 'DioSetup/dio_setup.dart';
//
// class PostSpecialRequestApiCall
// {
//   Future<PostSpecialRequestData?> callApi(BuildContext context,var map)
//   async {
//     Response? response;
//     print('oallala $map');
//     if(Provider.of<CheckInternetConnection>(context,listen: false).internetConnectionEnum == InternetConnectionEnum.available)
//     {
//       if(RequestType.baseUrl==null)
//       {
//         await MakeUrls().saveUrl();
//       }
//       LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
//
//       PrintLogs.printLogs('ewewrewwewew ${jsonEncode(map)}');
//       try{
//         response = await DioSetUp().getDio().post(
//           '${RequestType.baseUrl}${RequestType.saveSpecialRequest}',
//           data: map,
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
//           return PostSpecialRequestData(response.statusMessage!,response.statusCode!,PostEncashmentRequestJson.fromJson(response.data));
//         }
//         else{
//           return PostSpecialRequestData(response.statusMessage!,response.statusCode!,null);
//         }
//       }on DioError catch(e)
//       {
//         if (e.response != null) {
//           PrintLogs.printLogs(e.response?.statusCode);
//           PrintLogs.printLogs(e.response?.data);
//           PrintLogs.printLogs(e.response?.headers);
//           PrintLogs.printLogs(e.response?.requestOptions);
//           return PostSpecialRequestData(e.response?.statusMessage,e.response?.statusCode,null);
//         } else {
//           // Something happened in setting up or sending the request that triggered an Error
//           PrintLogs.printLogs(e.requestOptions);
//           PrintLogs.printLogs(e.message);
//           return PostSpecialRequestData(e.message,response?.statusCode,null);
//         }
//       }
//     }
//     else{
//       return PostSpecialRequestData('${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',-1,null);
//     }
//   }
// }
// class PostSpecialRequestData
// {
//   String? message;
//   int? code;
//   PostEncashmentRequestJson? postRequestJson;
//   PostSpecialRequestData(this.message,this.code,this.postRequestJson);
// }