import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/show_error.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_approvals_list.dart';

import '../../../../AppConstants/app_constants.dart';
import '../../../../Enums/apistatus_enum.dart';
import '../../../../Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';
import '../../../../Models/TimeRegulationModels/time_regulation_approval_detail_model.dart';

class ApprovalAcceptanceTimeRegulationListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  List<TimeRegulationLeaveDetail>? timeRegulationLeaveDetail;
  List<List<ApprovalHistory>>? approvalsList;
  List<ApprovalHistory>? uniqueList;

  void start(BuildContext context, ApprovalResultSet? approvalResultSet)async {
    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse apiResponse = await GetApisUrlCaller().getTimeRegularizationApprovalDetailsApiCall(context,'?ScreenID=${approvalResultSet?.screenID}&CompanyCode=${approvalResultSet?.companyCode}${AppConstants.getDocumentNumber(approvalResultSet!.documentNo!)}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      if(apiResponse.data!=null&&apiResponse.data.resultSet.leaveDetail!=null&&apiResponse.data.resultSet.leaveDetail.isNotEmpty)
        {
          timeRegulationLeaveDetail = apiResponse.data!.resultSet!.leaveDetail;
          if(apiResponse.data.resultSet.approvalHistory!=null)
          {
            List<ApprovalHistory>? history = apiResponse.data.resultSet.approvalHistory;
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
          apiStatus = ApiStatus.error;
          notifyListeners();
        }

    }
    else
    {
      apiStatus = apiResponse.apiStatus!;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }

}