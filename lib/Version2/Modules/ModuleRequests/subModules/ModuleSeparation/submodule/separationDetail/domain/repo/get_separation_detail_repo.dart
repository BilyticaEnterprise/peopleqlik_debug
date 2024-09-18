import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/get_approval_list_for_view.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleSeparation/submodule/separationDetail/domain/models/separation_detail_model.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class GetSeparationDetailRepo extends GetApprovalListForViewRepo
{
  Future<AppState> fetchSeparationDetail(BuildContext context,AllRequestDetailMapper allRequestDetailMapper);
  Future<AppState> approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper,required String remarks,required int approveOrReject});
  SeparationResult? getSeparationDetailResult();
}