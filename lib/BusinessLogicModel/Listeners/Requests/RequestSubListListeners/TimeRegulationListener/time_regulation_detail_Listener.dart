import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeRegulationModels/time_regulation_model.dart';
import 'package:provider/provider.dart';

import '../../../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../ApiCalls/ApiGlobalModel/api_global_model.dart';
import '../../../../Enums/apistatus_enum.dart';
import '../../../../Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';
import '../../../../Models/TimeRegulationModels/time_regulation_approval_detail_model.dart';
import '../../../Approvals/get_approval_list.dart';
import '../../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class TimeRegulationDetailListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  List<TimeRegulationLeaveDetail>? timeRegulationLeaveDetail;
  List<List<ApprovalHistory>>? approvalsList;
  List<ApprovalHistory>? uniqueList;
  TimeRegulationDataList? timeRegulationDataList;

  TimeRegulationDetailListener(this.timeRegulationDataList);

  void start(BuildContext context)async {

    apiStatus = ApiStatus.started;
    notifyListeners();
    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse apiResponse = await GetApisUrlCaller().getTimeRegulationDetailsApiCall(context,'?RequestCode=${timeRegulationDataList?.requestMID}&CompanyCode=${employeeInfoMapper.companyCode}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      timeRegulationLeaveDetail = apiResponse.data!.resultSet!.reuestDetail;
      if(apiResponse.data.resultSet.approvalHistory!=null)
      {
        uniqueList = apiResponse.data.resultSet.approvalHistory;
        approvalsList = getApprovalHistory(uniqueList);

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

}