import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleTimeRegulationAndMovement/subModules/timeRegulationMovementModule/subModules/timeRegulationAndMovementDetailModule/domain/models/time_regulation_movement_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleTimeRegulationAndMovement/subModules/timeRegulationMovementModule/subModules/timeRegulationAndMovementDetailModule/domain/repo/time_regulation_detail_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class TimeRegulationAndMovementDetailUseCase
{
  GetTimeRegulationMovementDetailRepo repo;
  TimeRegulationAndMovementDetailUseCase({required this.repo});

  Future<AppState> fetchTimeRegulationDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper) async {
    return await repo.fetchTimeRegulationDetail(context, allRequestDetailMapper);
  }

  List<List<ApprovalList>>? getApprovalListForView() {
    return repo.getApprovalListForView();
  }

  TimeRegulationResult? getTimeRegulationDetailResult() {
    return repo.getTimeRegulationDetailResult();
  }

  Future<AppState> approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper, required String remarks, required int approveOrReject}) async
  {
    return repo.approveRejectRequest(context, allRequestDetailMapper: allRequestDetailMapper, remarks: remarks, approveOrReject: approveOrReject);
  }

  bool? canAdminApprove() {
    return repo.canAdminApproveRequest();
  }
}