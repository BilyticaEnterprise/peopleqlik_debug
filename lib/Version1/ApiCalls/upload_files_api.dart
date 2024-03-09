// import 'dart:convert';
// import 'dart:io';
//
// import 'package:dio/dio.dart';
// import 'package:peopleqlik_debug/Version1/Models/AuthModels/login_model.dart';
// import 'package:peopleqlik_debug/Version1/Models/uploaded_file_model.dart';
// import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
// import 'package:peopleqlik_debug/mainCommon.dart';
// import 'package:peopleqlik_debug/src/prints_logs.dart';
//
// import 'ApiCallers/api_client_repo_impl.dart';
// import 'DioSetup/dio_setup.dart';
//
// class UploadFile
// {
//   Future<UploadedData> start(String filePath,String url) async {
//     Response? response;
//     try{
//       LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
//       String fileName = filePath.split('/').last;
//     FormData formData = FormData.fromMap({
//       "file": await MultipartFile.fromFile(filePath, filename:fileName),
//     });
//     response = await DioSetUp().getDio().post(
//         url,
//         data: formData,
//       options: Options(
//         sendTimeout: const Duration(milliseconds: 55000),
//         receiveTimeout: const Duration(milliseconds: 55000),
//           headers: GetHeaders().getAuthHeader(GetNavigatorStateContext.navigatorKey.currentState!.context,loginResultSet)
//       ),
//     );
//     PrintLogs.printLogs('reqqqqqqqqqwqqq ${response.data}');
//     if(response.data!=null)
//     {
//       return UploadedData(response.statusMessage!,response.statusCode!,GetUploadedFileJson.fromJson(response.data));
//     }
//     else{
//       return UploadedData(response.statusMessage!,response.statusCode!,null);
//     }
//     }on DioError catch(e)
//     {
//       PrintLogs.printLogs('[iccc errrrr');
//       if (e.response != null) {
//         PrintLogs.printLogs(e.response?.statusCode);
//         PrintLogs.printLogs(e.response?.data);
//         PrintLogs.printLogs(e.response?.headers);
//         PrintLogs.printLogs(e.response?.requestOptions);
//         return UploadedData(e.response?.statusMessage,e.response?.statusCode,null);
//       } else {
//         // Something happened in setting up or sending the request that triggered an Error
//         PrintLogs.printLogs(e.requestOptions);
//         PrintLogs.printLogs(e.message);
//         return UploadedData(e.message,response?.statusCode,null);
//       }
//     }
//   }
// }
// class UploadedData
// {
//   String? message;
//   int? code;
//   GetUploadedFileJson? responseJson;
//   UploadedData(this.message,this.code,this.responseJson);
// }