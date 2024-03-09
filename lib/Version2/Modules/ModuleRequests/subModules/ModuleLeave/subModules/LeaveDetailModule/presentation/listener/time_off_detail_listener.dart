import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/Models/RequestsModel/get_request_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/get_leave_detail_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../../../../../../ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../../../../../ApiModule/domain/model/show_error.dart';
import '../../../../../../../ApiModule/domain/model/api_global_model.dart';
import '../../../../../../../../../Version1/Models/ApprovalsModel/get_approvals_detail_model.dart';
import '../../../../../../../../../Version1/viewModel/Approvals/get_approval_list.dart';

class TimeOffDetailListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.started;
  LeaveDetailResultSet? timeOffDetailResultSet;
  List<List<ApprovalHistory>>? approvalsList;

  Future? start(BuildContext context,dynamic id,dynamic companyCode,dynamic employeeCode)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();

    PrintLogs.printLogs('timeoffstarted');
    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getLeaveDetailApi(context,'?ID=$id&CompanyCode=$companyCode&EmployeeCode=$employeeCode');
    PrintLogs.printLogs('timeoffDone ${apiResponse.apiStatus}');

    //GetLeaveDetailData? getLeaveDetailData = await GetLeaveDetailApiCall().callApi(context,applicationCode,companyCode,employeeCode);
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      timeOffDetailResultSet = apiResponse.data?.resultSet;
      if(timeOffDetailResultSet?.lObjApprovalHistory!=null)
      {
        List<ApprovalHistory>? uniqueList = apiResponse.data.resultSet.lObjApprovalHistory;
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