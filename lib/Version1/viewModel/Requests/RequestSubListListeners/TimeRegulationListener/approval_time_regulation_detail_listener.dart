// import 'package:flutter/material.dart';
// import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
// import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
// import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
// import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
// import 'package:peopleqlik_debug/Version1/models/ApprovalsModel/get_approvals_list.dart';
//
// import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';
// import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
// import '../../../../models/ApprovalsModel/approval_detail_mapper.dart';
// import '../../../../models/ApprovalsModel/get_approvals_detail_model.dart';
// import '../../../../models/TimeRegulationModels/time_regulation_movement_detail_model.dart';
//
// class ApprovalAcceptanceTimeRegulationListener extends GetChangeNotifier
// {
//   ApiStatus apiStatus = ApiStatus.nothing;
//   List<TimeRegulationLeaveDetail>? timeRegulationLeaveDetail;
//   List<List<ApprovalHistory>>? approvalsList;
//   List<ApprovalHistory>? uniqueList;
//
//   void start(BuildContext context, ApprovalDetailMapper? approvalResultSet)async {
//     apiStatus = ApiStatus.started;
//     notifyListeners();
//
//     ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getTimeRegularizationApprovalDetailsApiCall(context,'?ScreenID=${approvalResultSet?.screenID}&CompanyCode=${approvalResultSet?.companyCode}${AppConstants.getDocumentNumber(approvalResultSet!.documentNo!)}');
//     if(apiResponse.apiStatus == ApiStatus.done)
//     {
//       if(apiResponse.data!=null&&apiResponse.data.resultSet.leaveDetail!=null&&apiResponse.data.resultSet.leaveDetail.isNotEmpty)
//         {
//           timeRegulationLeaveDetail = apiResponse.data!.resultSet!.leaveDetail;
//           if(apiResponse.data.resultSet.approvalHistory!=null)
//           {
//             List<ApprovalHistory>? history = apiResponse.data.resultSet.approvalHistory;
//             var seen = <dynamic>{};
//             uniqueList = history!.where((student) => seen.add(student.hierarchyID)).toList();
//             approvalsList = List.empty(growable: true);
//             for(int x=0;x<uniqueList!.length;x++)
//             {
//               List<ApprovalHistory> l = List.empty(growable: true);
//               for(int y=0;y<history.length;y++)
//               {
//                 if(history[y].hierarchyID == uniqueList?[x].hierarchyID)
//                 {
//                   l.add(history[y]);
//                 }
//               }
//               if(l.isNotEmpty)
//               {
//                 approvalsList?.add(l);
//               }
//             }
//           }
//
//           apiStatus = ApiStatus.done;
//           notifyListeners();
//         }
//       else
//         {
//           apiStatus = ApiStatus.error;
//           notifyListeners();
//         }
//
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