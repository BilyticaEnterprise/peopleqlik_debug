import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/get_approval_list_for_view.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleShift/subModules/shiftDetaiApprovalModule/domain/model/shift_detail_model.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class GetShiftDetailRepo extends GetApprovalListForViewRepo
{
  Future<AppState> fetchShiftDetail(BuildContext context,AllRequestDetailMapper allRequestDetailMapper);
  Future<AppState> approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper,required String remarks,required int approveOrReject});
  ShiftResult? getShiftDetailResult();
  List<String?>? offDaysList(BuildContext context);
}