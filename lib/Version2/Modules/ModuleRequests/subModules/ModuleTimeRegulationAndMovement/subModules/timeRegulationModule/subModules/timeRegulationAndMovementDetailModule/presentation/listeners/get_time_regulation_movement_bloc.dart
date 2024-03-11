import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/data/remote/api_client.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleTimeRegulationAndMovement/subModules/timeRegulationModule/subModules/timeRegulationAndMovementDetailModule/data/repoImpl/time_regulation_movement_detail_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleTimeRegulationAndMovement/subModules/timeRegulationModule/subModules/timeRegulationAndMovementDetailModule/domain/usecase/time_regulation_leave_module_usecase.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class GetTimeRegulationMovementDetailBloc extends ExtendedCubit<AppState>
{
  late TimeRegulationAndMovementDetailUseCase useCase;
  late AllRequestDetailMapper allRequestDetailMapper;
  GetTimeRegulationMovementDetailBloc(super.initialState,{required this.allRequestDetailMapper})
  {
    useCase = TimeRegulationAndMovementDetailUseCase(repo: GetTimeRegulationMovementDetailRepoImpl(apiClientRepo: AllRequestDetailApiClientRepoImpl()));
  }


  fetchLeaveDetail(BuildContext context)async {
    emit(await useCase.fetchTimeRegulationDetail(context, allRequestDetailMapper));
  }

}