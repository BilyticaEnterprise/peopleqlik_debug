import 'package:flutter/src/widgets/framework.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/get_approval_list.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/all_request_detail_api_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleTimeRegulationAndMovement/subModules/timeRegulationModule/subModules/timeRegulationAndMovementDetailModule/domain/models/time_regulation_movement_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleTimeRegulationAndMovement/subModules/timeRegulationModule/subModules/timeRegulationAndMovementDetailModule/domain/repo/time_regulation_detail_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';

class GetTimeRegulationMovementDetailRepoImpl extends GetTimeRegulationMovementDetailRepo with GetLoader
{

  AllRequestDetailApiClientRepo apiClientRepo;
  List<List<ApprovalList>>? _approvalsList;
  TimeRegulationResult? _timeRegulationResult;

  GetTimeRegulationMovementDetailRepoImpl({required this.apiClientRepo});

  @override
  Future<AppState> fetchTimeRegulationDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper) async {
    initLoader();
    AppState appState = await apiClientRepo.getData(context, allRequestDetailMapper, ClassType<TimeRegulationMovementDetailModel>(TimeRegulationMovementDetailModel.fromJson));
    await closeLoader();
    if(appState is AppStateDone)
    {
      TimeRegulationMovementDetailModel model = appState.data as TimeRegulationMovementDetailModel;
      _timeRegulationResult = model.resultSet?.data?.result;
      if(model.resultSet?.data?.approvalList != null && model.resultSet!.data!.approvalList!.isNotEmpty)
      {
        _approvalsList = getApprovalList(model.resultSet!.data!.approvalList!);
      }
    }
    return appState;
  }

  @override
  List<List<ApprovalList>>? getApprovalListForView() {
    return _approvalsList;
  }

  @override
  TimeRegulationResult? getTimeRegulationDetailResult() {
    return _timeRegulationResult;
  }

}