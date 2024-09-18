import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleGenericRequests/subModules/genericDetailModule/domain/models/general_request_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleGenericRequests/subModules/genericDetailModule/domain/repo/general_request_detail_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class GeneralRequestDetailUseCase {
  GeneralRequestDetailRepo repo;

  GeneralRequestDetailUseCase({required this.repo});

  Future<AppState> approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper, required String remarks, required int approveOrReject}) async {
    return await repo.approveRejectRequest(context, allRequestDetailMapper: allRequestDetailMapper, remarks: remarks, approveOrReject: approveOrReject);
  }

  Future<AppState> fetchGeneralRequestDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper) async {
    return await repo.fetchGeneralRequestDetail(context, allRequestDetailMapper);
  }

  List<List<ApprovalList>>? getApprovalListForView() {
    return repo.getApprovalListForView();
  }

  GeneralRequestResult? getGeneralRequestDetailResult() {
    return repo.getGeneralRequestDetailResult();
  }

  canAdminApprove()
  {
    return repo.canAdminApproveRequest();
  }

}