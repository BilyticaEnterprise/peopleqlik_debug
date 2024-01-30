import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/loader_class.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/Urls/urls.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/upload_files_api.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/uploaded_file_model.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/loader.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';

import '../../ApiCalls/ApiCallers/show_error.dart';
import '../../Enums/apistatus_enum.dart';

class UploadFileListener with GetLoader
{
  Future<UploadedResultSet?> start(String filePath,FileTypeServer fileType,BuildContext context)
  async {
    var url;
    if(fileType == FileTypeServer.leave)
      {
        url = '${RequestType.uploadLeaveFile}';
      }
    else if(fileType == FileTypeServer.request)
      {
        url = '${RequestType.uploadRequestFile}';
      }
    else if(fileType == FileTypeServer.requestSpecial)
    {
      url = '${RequestType.uploadRequestSpecialFile}';
    }

    initLoader();
    ApiResponse? apiResponse = await GetApisUrlCaller().uploadFileApi(context,filePath, url);
    await Future.delayed(const Duration(milliseconds: 100));
    await closeLoader();

    await Future.delayed(const Duration(milliseconds: 100));
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      PrintLogs.printLogs('helaknsdjkasa ${apiResponse.apiStatus} ${apiResponse.data?.resultSet?.toJson()}');
      return apiResponse.data?.resultSet;
    }
    else
    {
      ShowErrorMessage.show(apiResponse);
      return null;
    }
    // if(uploadedData.responseJson!=null&&uploadedData.responseJson?.resultSet!=null)
    //   {
    //     loadingStream.add(true);
    //     return uploadedData.responseJson?.resultSet;
    //   }
    // else
    //   {
    //     loadingStream.add(true);
    //     if(uploadedData.responseJson!=null&&uploadedData.responseJson?.errorMessage!=null)
    //       {
    //         ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,uploadedData.responseJson!.errorMessage!,color: MyColor.colorRed));
    //       }
    //     else
    //       {
    //         ScaffoldMessenger.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,uploadedData.message!,color: MyColor.colorRed));
    //       }
    //     if(uploadedData.code == GetVariable.fourZeroOne)
    //       {
    //         Navigator.pushNamedAndRemoveUntil(context, CurrentPage.CompanyPage, ModalRoute.withName(CurrentPage.LoginPage));
    //       }
    //     return null;
    //   }
  }
}
enum FileTypeServer
{
  leave,request,requestSpecial
}