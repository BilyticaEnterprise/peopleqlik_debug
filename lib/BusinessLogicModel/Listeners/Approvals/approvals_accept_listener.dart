import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/loader_class.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/show_error.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AppConstants/app_constants.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/post_approval_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import 'approvals_detail_collector.dart';

class ApprovalsAcceptRejectCollector extends GetChangeNotifier with GetLoader
{
  PostApprovalAcceptRejectJson? postApprovalDetailJson;

  Future? start(BuildContext context,int statusID,String remarks,String? primaryVal, dynamic companyCode,int? screenID)
  async {

    initLoader();

    ApiResponse apiResponse = await GetApisUrlCaller().postApprovalAcceptRejectApi(context, '?ScreenID=$screenID&StatusID=$statusID&Remarks=$remarks&CompanyCode=$companyCode${AppConstants.getDocumentNumber(primaryVal!)}');

    if(apiResponse.apiStatus == ApiStatus.done&&apiResponse.data?.objEntity?.isSuccess==true)
    {
      postApprovalDetailJson = apiResponse.data;
      await closeLoader();

      Future.delayed(const Duration(milliseconds: 200),(){
        if(apiResponse.data!=null&&apiResponse.data?.objEntity!=null&&apiResponse.data!.objEntity!.errorResourceName!=null)
        {
          SnackBarDesign.happySnack(CallLanguageKeyWords.get(GetNavigatorStateContext.navigatorKey.currentState!.context, apiResponse.data!.objEntity!.errorResourceName!)??'');
        }
        Navigator.pop(context,true);
      });
    }
    else
    {
      await closeLoader();
      // if(apiResponse.data!=null&&apiResponse.data?.objEntity!=null&&apiResponse.data!.objEntity!.errorResourceName!=null)
      // {
      //   //PrintLogs.printLogs('elseeaaaaaasdasdas ${getApprovalsListData.getApprovalJson?.objEntity?.errorResourceName}');
      //   SnackBarDesign.errorSnack(CallLanguageKeyWords.get(GetNavigatorStateContext.navigatorKey.currentState!.context, apiResponse.data!.objEntity!.errorResourceName!)??'');
      // }
      ShowErrorMessage.show(apiResponse);

      notifyListeners();

    }

  }
  void callApi(BuildContext context,ApprovalsDetailCollector approvalsDetailCollector)
  {
    if(approvalsDetailCollector.acceptReject == AcceptReject.reject)
    {
      Future.delayed(const Duration(milliseconds: 200),(){
        start(context,3,approvalsDetailCollector.remarks, approvalsDetailCollector.approvalResultSet!.documentNo!, approvalsDetailCollector.approvalResultSet?.companyCode, approvalsDetailCollector.approvalResultSet?.screenID);
      });
    }
    else if(approvalsDetailCollector.acceptReject == AcceptReject.accept)
    {
      Future.delayed(const Duration(milliseconds: 200),(){
        start(context,2,approvalsDetailCollector.remarks, approvalsDetailCollector.approvalResultSet!.documentNo!, approvalsDetailCollector.approvalResultSet?.companyCode, approvalsDetailCollector.approvalResultSet?.screenID);
      });
    }
  }

}