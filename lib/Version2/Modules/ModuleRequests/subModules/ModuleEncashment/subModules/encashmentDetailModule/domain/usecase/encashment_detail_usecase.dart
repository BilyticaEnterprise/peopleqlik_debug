import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleEncashment/subModules/encashmentDetailModule/domain/models/encashment_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleEncashment/subModules/encashmentDetailModule/domain/repo/get_encashment_detail_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class EncashmentDetailUseCase{

  GetEncashmentDetailRepo repo;

  EncashmentDetailUseCase({required this.repo});

  Future<AppState> approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper, required String remarks, required int approveOrReject}) async {
    return await repo.approveRejectRequest(context, allRequestDetailMapper: allRequestDetailMapper, remarks: remarks, approveOrReject: approveOrReject);
  }

  Future<AppState> fetchTimeRegulationDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper) async {
    return await repo.fetchTimeRegulationDetail(context, allRequestDetailMapper);
  }

  List<List<ApprovalList>>? getApprovalListForView() {
    return repo.getApprovalListForView();
  }

  EncashmentResult? getEncashmentDetailResult() {
    return repo.getEncashmentDetailResult();
  }

  bool? canAdminApprove() {
    return repo.canAdminApproveRequest();
  }
}