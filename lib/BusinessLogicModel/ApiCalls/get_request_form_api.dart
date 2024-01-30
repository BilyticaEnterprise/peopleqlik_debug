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
// import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/request_list_form_model.dart';
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
// class GetRequestFormApiCall
// {
//   Future<GetRequestFormData?> callApi(BuildContext context,int? requestManagerID)
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
//       PrintLogs.printLogs('comingggkhdsbfjsd');
//       //PrintLogs.print('sendingggg ${Uri.parse('https://app.peopleqlik.com/ServiceApiV1${RequestType.timeOff}?CompanyCode=${loginResultSet.headerInfo!.companyCode}&EmployeeCode=${loginResultSet.headerInfo!.employeeCode}&PageNo=$page&PerPage=10')}');
//       try{
//         response = await DioSetUp().getDio().get(
//           '${RequestType.baseUrl}${RequestType.getRequestForm}?RequestManagerID=$requestManagerID',
//           options: Options(
//             sendTimeout: const Duration(milliseconds: 55000),
//             receiveTimeout: const Duration(milliseconds: 55000),
//               headers: GetHeaders().getAuthHeader(context,loginResultSet)
//           ),
//         );
//         PrintLogs.printLogs('reposesnjaskda ${jsonEncode(response.data)}');
//         if(response.data!=null)
//         {
//           return GetRequestFormData(response.statusMessage!,response.statusCode!,GetRequestFormJson.fromJson(response.data));
//         }
//         else{
//           return GetRequestFormData(response.statusMessage!,response.statusCode!,null);
//         }
//       }on DioError catch(e)
//       {
//         PrintLogs.printLogs('yessss ttt ${jsonEncode(e.toString())}');
//         if (e.response != null) {
//           PrintLogs.printLogs(e.response?.statusCode);
//           PrintLogs.printLogs(e.response?.data);
//           PrintLogs.printLogs(e.response?.headers);
//           PrintLogs.printLogs(e.response?.requestOptions);
//           return GetRequestFormData(e.response?.statusMessage,e.response?.statusCode,null);
//         } else {
//           // Something happened in setting up or sending the request that triggered an Error
//           PrintLogs.printLogs(e.requestOptions);
//           PrintLogs.printLogs(e.message);
//           return GetRequestFormData(e.message,response?.statusCode,null);
//         }
//       }
//     }
//     else{
//       return GetRequestFormData('${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',-1,null);
//     }
//   }
// }
// class GetRequestFormData
// {
//   String? message;
//   int? code;
//   GetRequestFormJson? getRequestFormJson;
//   GetRequestFormData(this.message,this.code,this.getRequestFormJson);
// }