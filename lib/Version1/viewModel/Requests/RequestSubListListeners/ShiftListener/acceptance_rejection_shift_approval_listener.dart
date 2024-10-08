// import 'package:flutter/material.dart';
// import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
// import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
// import '../../../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
// import '../../../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
// import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';
// import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
// import '../../../../models/ApprovalsModel/approval_detail_mapper.dart';
// import '../../../../models/ApprovalsModel/get_approvals_detail_model.dart';
// import '../../../../models/ApprovalsModel/get_approvals_list.dart';
// import '../../../../models/TimeOffAndEnCashModel/shift_detail_model.dart';
// import '../../../Approvals/get_approval_list.dart';
//
// class AcceptanceRejectionShiftApproval extends GetChangeNotifier
// {
//   ApiStatus apiStatus = ApiStatus.nothing;
//   ShiftRequestDetail? requestDetail;
//   List<List<ApprovalHistory>>? approvalsList;
//   List<ApprovalHistory>? uniqueList;
//
//   void start(BuildContext context, ApprovalDetailMapper? approvalResultSet)async
//   {
//     apiStatus = ApiStatus.started;
//     notifyListeners();
//
//     ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getShiftApprovalDetailsApiCall(context,'?ScreenID=${approvalResultSet?.screenID}&CompanyCode=${approvalResultSet?.companyCode}${AppConstants.getDocumentNumber(approvalResultSet!.documentNo!)}');
//     if(apiResponse.apiStatus == ApiStatus.done)
//     {
//       requestDetail = apiResponse.data.resultSet.dataList.first;
//       List<String?>? offDaysNameList = Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.weekDayList?.map((e) => (requestDetail?.offDays?.contains(e.weekDayID)==true)?e.dayName:null).toList();
//       offDaysNameList?.removeWhere((element) => element==null);
//       requestDetail?.offDaysName = offDaysNameList;
//       if(apiResponse.data.resultSet.approvalHistory!=null)
//       {
//         uniqueList = apiResponse.data.resultSet.approvalHistory;
//         approvalsList = getApprovalHistory(uniqueList);
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