import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/models/ApprovalsModel/post_approval_model.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import 'approvals_detail_collector.dart';

class ApprovalsAcceptRejectCollector extends GetChangeNotifier with GetLoader
{
  PostApprovalAcceptRejectJson? postApprovalDetailJson;

  Future? start(BuildContext context,int statusID,String remarks,String? primaryVal, dynamic companyCode,int? screenID)
  async {

    initLoader();

    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().postApprovalAcceptRejectApi(context, '?ScreenID=$screenID&StatusID=$statusID&Remarks=$remarks&CompanyCode=$companyCode${AppConstants.getDocumentNumber(primaryVal!)}');

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
        start(context,3,approvalsDetailCollector.remarks, approvalsDetailCollector.approvalDetailMapper!.documentNo!, approvalsDetailCollector.approvalDetailMapper?.companyCode, approvalsDetailCollector.approvalDetailMapper?.screenID);
      });
    }
    else if(approvalsDetailCollector.acceptReject == AcceptReject.accept)
    {
      Future.delayed(const Duration(milliseconds: 200),(){
        start(context,2,approvalsDetailCollector.remarks, approvalsDetailCollector.approvalDetailMapper!.documentNo!, approvalsDetailCollector.approvalDetailMapper?.companyCode, approvalsDetailCollector.approvalDetailMapper?.screenID);
      });
    }
  }

}