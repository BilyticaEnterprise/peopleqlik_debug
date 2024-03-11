import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/get_approval_list_for_view.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleTimeRegulationAndMovement/subModules/timeRegulationModule/subModules/timeRegulationAndMovementDetailModule/domain/models/time_regulation_movement_detail_model.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class GetTimeRegulationMovementDetailRepo extends GetApprovalListForViewRepo
{
  Future<AppState> fetchTimeRegulationDetail(BuildContext context,AllRequestDetailMapper allRequestDetailMapper);
  TimeRegulationResult? getTimeRegulationDetailResult();
}