import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/Version1/Models/ApprovalsModel/get_approvals_detail_model.dart';
import 'package:peopleqlik_debug/Version1/Models/ApprovalsModel/get_approvals_list.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';
import '../../Models/ApprovalsModel/approval_detail_mapper.dart';

class ApprovalsDetailCollector extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  ApprovalDetailMapper? approvalDetailMapper;
  GetApprovalDetailResultSet? getApprovalDetailResultSet;
  LoginResultSet? loginResultSet;
  String remarks = '';
  List<List<ApprovalHistory>>? approvalsList;
  List<ApprovalHistory>? uniqueList;

  AcceptReject acceptReject = AcceptReject.accept;

  Future? start(BuildContext context)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();
    loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));

    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getApprovalDetailsApiCall(context,'?ScreenID=${approvalDetailMapper?.screenID}&CompanyCode=${approvalDetailMapper?.companyCode}${AppConstants.getDocumentNumber(approvalDetailMapper!.documentNo!)}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      getApprovalDetailResultSet = apiResponse.data!.resultSet;
      if(getApprovalDetailResultSet?.approvalHistory!=null)
      {
        List<ApprovalHistory>? history = getApprovalDetailResultSet?.approvalHistory;
        var seen = <dynamic>{};
        uniqueList = history!.where((student) => seen.add(student.hierarchyID)).toList();
        approvalsList = List.empty(growable: true);
        for(int x=0;x<uniqueList!.length;x++)
        {
          List<ApprovalHistory> l = List.empty(growable: true);
          for(int y=0;y<history.length;y++)
          {
            if(history[y].hierarchyID == uniqueList?[x].hierarchyID)
            {
              l.add(history[y]);
            }
          }
          if(l.isNotEmpty)
          {
            approvalsList?.add(l);
          }
        }
      }
      apiStatus = ApiStatus.done;
      notifyListeners();

    }
    else
    {
      apiStatus = apiResponse.apiStatus!;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }

  }
  void remarksAdd(String remarks)
  {
    this.remarks = remarks;
  }

  void updateType(AcceptReject reject) {
    acceptReject = reject;
    notifyListeners();
  }
}
enum AcceptReject
{
  accept,reject
}