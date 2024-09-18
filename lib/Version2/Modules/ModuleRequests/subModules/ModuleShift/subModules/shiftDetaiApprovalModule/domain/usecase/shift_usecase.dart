import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleShift/subModules/shiftDetaiApprovalModule/domain/model/shift_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleShift/subModules/shiftDetaiApprovalModule/domain/repo/shift_detail_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class GetShiftDetailUseCase
{
  GetShiftDetailRepo repo;
  GetShiftDetailUseCase({required this.repo});

  Future<AppState> approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper, required String remarks, required int approveOrReject}) async {
    return await repo.approveRejectRequest(context, allRequestDetailMapper: allRequestDetailMapper, remarks: remarks, approveOrReject: approveOrReject);
  }

  Future<AppState> fetchShiftDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper) async {
    return await repo.fetchShiftDetail(context, allRequestDetailMapper);
  }

  List<List<ApprovalList>>? getApprovalListForView() {
    return repo.getApprovalListForView();
  }

  ShiftResult? getShiftDetailResult() {
    return repo.getShiftDetailResult();
  }

  List<String?>? getOffDaysList(BuildContext context) {
    return repo.offDaysList(context);
  }

  bool? canAdminApprove() {
    return repo.canAdminApproveRequest();
  }
}