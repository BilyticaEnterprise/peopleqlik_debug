import 'package:flutter/src/widgets/framework.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeDetailModule/domain/models/overtime_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeDetailModule/domain/models/overtime_detail_view_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeDetailModule/domain/repo/overtime_detail_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class OvertimeDetailUseCase{

  GetOvertimeDetailRepo repo;

  OvertimeDetailUseCase({required this.repo});

  Future<AppState> approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper, required String remarks, required int approveOrReject})async {
    return await repo.approveRejectRequest(context, allRequestDetailMapper: allRequestDetailMapper, remarks: remarks, approveOrReject: approveOrReject);
  }

  Future<AppState> fetchOvertimeDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper) async {
    return await repo.fetchOvertimeDetail(context, allRequestDetailMapper);
  }

  List<List<ApprovalList>>? getApprovalListForView() {
    return repo.getApprovalListForView();
  }

  List<OvertimeViewModel>? getOvertimeDetailResult() {
    return repo.getOvertimeDetailResult();
  }

  bool? canAdminApprove() {
    return repo.canAdminApproveRequest();
  }

}