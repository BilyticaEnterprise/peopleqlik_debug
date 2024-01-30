import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'dart:convert';

import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/get_request_detail_api.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_detail_model.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import '../../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../ApiCalls/ApiGlobalModel/api_global_model.dart';
import '../../../Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';
import '../../Approvals/get_approval_list.dart';

class GetRequestDetailListener extends GetChangeNotifier
{
  List<GetRequestDetailsResultSet>? requestNamesResultSet;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<List<ApprovalHistory>>? approvalsList;
  List<ApprovalHistory>? uniqueList;

  Future? start(BuildContext context,dynamic requestCode,dynamic managerId)
  async {
    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse? apiResponse = await GetApisUrlCaller().getRequestDetailApi(context,'?RequestManagerID=$managerId&RequestCode=$requestCode');

    //GetRequestDetailsData? getRequestNamesData = await GetRequestDetailsApiCall().callApi(context,requestCode,managerId);
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      requestNamesResultSet = apiResponse.data!.resultSet!.lObjRequestResult;
      uniqueList = apiResponse.data.resultSet.lObjApprovalHistory;
      approvalsList = getApprovalHistory(uniqueList);
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
      requestNamesResultSet = null;
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

