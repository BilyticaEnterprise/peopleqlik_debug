// import 'package:flutter/material.dart';
// import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
// import 'package:peopleqlik_debug/Version1/Models/TimeRegulationModels/time_regulation_model.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../../../../../../ApiModule/domain/usecase/apis_url_caller.dart';
// import '../../../../../../../../../ApiModule/domain/model/show_error.dart';
// import '../../../../../../../../../ApiModule/domain/model/api_global_model.dart';
// import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
// import '../../../../../../../../../../../Version1/Models/ApprovalsModel/get_approvals_detail_model.dart';
// import '../../../../../../../../../../../Version1/Models/TimeRegulationModels/time_regulation_movement_detail_model.dart';
// import '../../../../../../../../../../../Version1/viewModel/Approvals/get_approval_list.dart';
// import '../../../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
// import '../../../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
//
// class TimeRegulationDetailListener extends GetChangeNotifier
// {
//   ApiStatus apiStatus = ApiStatus.nothing;
//   List<TimeRegulationLeaveDetail>? timeRegulationLeaveDetail;
//   List<List<ApprovalHistory>>? approvalsList;
//   List<ApprovalHistory>? uniqueList;
//   dynamic documentNumber;
//
//   TimeRegulationDetailListener(this.documentNumber);
//
//   void start(BuildContext context)async {
//
//     apiStatus = ApiStatus.started;
//     notifyListeners();
//     EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();
//
//     ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getTimeRegulationDetailsApiCall(context,'?RequestCode=$documentNumber&CompanyCode=${employeeInfoMapper.companyCode}');
//     if(apiResponse.apiStatus == ApiStatus.done)
//     {
//       timeRegulationLeaveDetail = apiResponse.data!.resultSet!.reuestDetail;
//       if(apiResponse.data.resultSet.approvalHistory!=null)
//       {
//         uniqueList = apiResponse.data.resultSet.approvalHistory;
//         approvalsList = getApprovalHistory(uniqueList);
//
//       }
//
//       apiStatus = ApiStatus.done;
//       notifyListeners();
//     }
//     else
//     {
//       apiStatus = apiResponse.apiStatus!;
//       notifyListeners();
//       ShowErrorMessage.show(apiResponse);
//     }
//   }
//
// }