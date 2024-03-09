import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/get_approval_list_for_view.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/leave_detail_model.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class GetLeaveDetailRepo extends GetApprovalListForViewRepo
{
  Future<AppState> fetchLeaveDetail(BuildContext context,AllRequestDetailMapper allRequestDetailMapper);
  LeaveDetailResult? getLeaveDetailResult();
}