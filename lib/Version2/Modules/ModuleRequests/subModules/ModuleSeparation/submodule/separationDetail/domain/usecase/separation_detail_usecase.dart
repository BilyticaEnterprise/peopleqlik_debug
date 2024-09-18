import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleSeparation/submodule/separationDetail/domain/models/separation_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleSeparation/submodule/separationDetail/domain/repo/get_separation_detail_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class SeparationDetailUseCase
{
  GetSeparationDetailRepo repo;
  SeparationDetailUseCase({required this.repo});

  Future<AppState> fetchSeparationDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper) async {
    return await repo.fetchSeparationDetail(context, allRequestDetailMapper);
  }

  List<List<ApprovalList>>? getApprovalListForView() {
    return repo.getApprovalListForView();
  }

  SeparationResult? getSeparationDetailResult() {
    return repo.getSeparationDetailResult();
  }

  Future<AppState> approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper, required String remarks, required int approveOrReject}) async
  {
    return repo.approveRejectRequest(context, allRequestDetailMapper: allRequestDetailMapper, remarks: remarks, approveOrReject: approveOrReject);
  }

  bool? canAdminApprove() {
    return repo.canAdminApproveRequest();
  }

}