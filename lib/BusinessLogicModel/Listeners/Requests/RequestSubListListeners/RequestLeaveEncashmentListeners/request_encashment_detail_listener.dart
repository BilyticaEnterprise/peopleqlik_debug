import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/get_request_separation_detail_api.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_separation_detail_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_request_encashment_detail_model.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import '../../../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../ApiCalls/ApiGlobalModel/api_global_model.dart';
import '../../../Approvals/get_approval_list.dart';

class GetRequestEncashmentDetailListener extends GetChangeNotifier
{
  EncashmentDetailResultSet? encashmentDetailResultSet;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<List<ApprovalHistory>>? approvalsList;
  List<ApprovalHistory>? uniqueList;

  Future? start(BuildContext context,dynamic id)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse? apiResponse = await GetApisUrlCaller().getEncashmentDetail(context,'?RequestCode=$id');

    if(apiResponse.apiStatus == ApiStatus.done)
    {
      encashmentDetailResultSet = apiResponse.data!.resultSet;
      if(encashmentDetailResultSet?.approvalHistory!=null)
      {
        uniqueList = apiResponse.data.resultSet.approvalHistory;
        approvalsList = getApprovalHistory(uniqueList);

        // uniqueList = history!.where((student) => seen.add(student.hierarchyID)).toList();
        // approvalsList = List.empty(growable: true);
        // for(int x=0;x<uniqueList!.length;x++)
        // {
        //   List<ApprovalHistory> l = List.empty(growable: true);
        //   for(int y=0;y<history.length;y++)
        //   {
        //     if(history[y].hierarchyID == uniqueList?[x].hierarchyID)
        //     {
        //       l.add(history[y]);
        //     }
        //   }
        //   if(l.isNotEmpty)
        //   {
        //     approvalsList?.add(l);
        //   }
        // }
      }
      apiStatus = ApiStatus.done;
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      encashmentDetailResultSet = null;
      apiStatus = ApiStatus.empty;
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
class RequestEncashmentDetailData
{
  dynamic id;
  RequestEncashmentDetailData(this.id);
}
