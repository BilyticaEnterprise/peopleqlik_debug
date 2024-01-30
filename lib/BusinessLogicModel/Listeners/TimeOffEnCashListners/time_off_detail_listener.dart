import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_detail_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/get_leave_detail_model.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import '../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../ApiCalls/ApiCallers/show_error.dart';
import '../../ApiCalls/ApiGlobalModel/api_global_model.dart';
import '../../Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';
import '../Approvals/get_approval_list.dart';

class TimeOffDetailListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.started;
  LeaveDetailResultSet? timeOffDetailResultSet;
  List<List<ApprovalHistory>>? approvalsList;
  List<ApprovalHistory>? uniqueList;

  Future? start(BuildContext context,dynamic applicationCode,dynamic companyCode,dynamic employeeCode)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse? apiResponse = await GetApisUrlCaller().getLeaveDetailApi(context,'?ApplicationCode=$applicationCode&CompanyCode=$companyCode&EmployeeCode=$employeeCode');

    //GetLeaveDetailData? getLeaveDetailData = await GetLeaveDetailApiCall().callApi(context,applicationCode,companyCode,employeeCode);
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      timeOffDetailResultSet = apiResponse.data?.resultSet;
      if(timeOffDetailResultSet?.lObjApprovalHistory!=null)
      {
        uniqueList = apiResponse.data.resultSet.lObjApprovalHistory;
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
      timeOffDetailResultSet = null;
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