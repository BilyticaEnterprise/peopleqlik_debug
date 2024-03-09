import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/leave_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/repo/get_leave_detail_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class LeaveDetailUseCase extends GetLeaveDetailRepo
{
  GetLeaveDetailRepo getLeaveDetailRepo;
  LeaveDetailUseCase({required this.getLeaveDetailRepo});

  @override
  List<List<ApprovalList>>? getApprovalListForView() {
    return getLeaveDetailRepo.getApprovalListForView();
  }

  @override
  Future<AppState> fetchLeaveDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper)async {
    return await getLeaveDetailRepo.fetchLeaveDetail(context, allRequestDetailMapper);
  }

  @override
  LeaveDetailResult? getLeaveDetailResult() {
    return getLeaveDetailRepo.getLeaveDetailResult();
  }
}