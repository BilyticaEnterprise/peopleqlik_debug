import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'dart:convert';

import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/ApiCalls/get_request_detail_api.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/Models/RequestsModel/get_request_detail_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import '../../../Models/ApprovalsModel/get_approvals_detail_model.dart';
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

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getRequestDetailApi(context,'?RequestManagerID=$managerId&RequestCode=$requestCode');

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

