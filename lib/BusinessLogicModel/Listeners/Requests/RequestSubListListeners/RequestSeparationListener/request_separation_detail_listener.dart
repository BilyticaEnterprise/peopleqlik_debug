
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/get_request_separation_detail_api.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_separation_detail_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import '../../../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../ApiCalls/ApiGlobalModel/api_global_model.dart';
import '../../../Approvals/get_approval_list.dart';

class GetRequestSeparationDetailListener extends GetChangeNotifier
{
  RequestSeparationDetailResultSet? requestSeparationDetailResultSet;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<List<ApprovalHistory>>? approvalsList;
  List<ApprovalHistory>? uniqueList;
  Future? start(BuildContext context,dynamic id)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse? apiResponse = await GetApisUrlCaller().getSeperationRequestDetail(context,'?ID=$id');

   // GetRequestSeparationDetailsData? getRequestSeparationDetailsData = await GetRequestSeparationDetailsApiCall().callApi(context,id);
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      requestSeparationDetailResultSet = apiResponse.data!.resultSet;
      if(requestSeparationDetailResultSet?.approvalHistory!=null)
      {
        uniqueList = apiResponse.data.resultSet.approvalHistory;
        approvalsList = getApprovalHistory(uniqueList);
      }
      apiStatus = ApiStatus.done;
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      apiStatus = ApiStatus.empty;
      if(apiResponse.data!=null&&apiResponse.data?.errorMessage!=null)
      {
        SnackBarDesign.errorSnack(apiResponse.data!.errorMessage);
      }
      requestSeparationDetailResultSet = null;
      notifyListeners();
    }
    else
    {
      apiStatus = apiResponse.apiStatus!;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }

  }
}
class RequestSeparationDetailData
{
  dynamic id;
  dynamic lastWorkingDate;
  dynamic remarks;
  RequestSeparationDetailData(this.id,{this.lastWorkingDate,this.remarks});
}
