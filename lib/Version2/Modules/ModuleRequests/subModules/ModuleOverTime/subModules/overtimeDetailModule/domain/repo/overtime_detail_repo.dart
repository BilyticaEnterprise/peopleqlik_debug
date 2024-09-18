import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/get_approval_list_for_view.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeDetailModule/domain/models/overtime_detail_view_mapper.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class GetOvertimeDetailRepo extends GetApprovalListForViewRepo
{
  Future<AppState> fetchOvertimeDetail(BuildContext context,AllRequestDetailMapper allRequestDetailMapper);
  Future<AppState> approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper,required String remarks,required int approveOrReject});
  List<OvertimeViewModel>? getOvertimeDetailResult();
}