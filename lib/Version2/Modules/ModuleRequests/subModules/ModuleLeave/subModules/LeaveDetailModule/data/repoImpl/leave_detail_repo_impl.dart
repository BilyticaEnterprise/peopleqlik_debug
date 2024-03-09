
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/get_approval_list.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/all_request_detail_api_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/leave_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/repo/get_leave_detail_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class GetLeaveDetailRepoImpl extends GetLeaveDetailRepo with GetLoader
{
  AllRequestDetailApiClientRepo apiClientRepo;
  List<List<ApprovalList>>? _approvalsList;
  LeaveDetailResult? _leaveDetailResult;

  GetLeaveDetailRepoImpl({required this.apiClientRepo});

  @override
  Future<AppState> fetchLeaveDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper) async {
    initLoader();
    AppState appState = await apiClientRepo.getData(context, allRequestDetailMapper, ClassType<LeaveDetailModel>(LeaveDetailModel.fromJson));
    await closeLoader();
    if(appState is AppStateDone)
      {
        LeaveDetailModel model = appState.data as LeaveDetailModel;
        _leaveDetailResult = model.resultSet?.data?.result;
        if(model.resultSet?.data?.approvalList != null && model.resultSet!.data!.approvalList!.isNotEmpty)
          {
            _approvalsList = getApprovalList(model.resultSet!.data!.approvalList!);
          }
      }
    return appState;
  }

  @override
  List<List<ApprovalList>>? getApprovalListForView() {
    return _approvalsList;
  }

  @override
  LeaveDetailResult? getLeaveDetailResult() {
    return _leaveDetailResult;
  }

}