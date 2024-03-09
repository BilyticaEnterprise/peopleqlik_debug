
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/ApiCalls/get_request_separation_detail_api.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/Models/RequestsModel/get_request_separation_detail_model.dart';
import 'package:peopleqlik_debug/Version1/Models/ApprovalsModel/get_approvals_detail_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
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

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getSeperationRequestDetail(context,'?ID=$id');

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
