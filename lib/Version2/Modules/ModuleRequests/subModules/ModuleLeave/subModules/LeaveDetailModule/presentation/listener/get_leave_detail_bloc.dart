import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/data/remote/api_client.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/data/repoImpl/leave_detail_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/usecase/leave_detail_usecase.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class GetLeaveDetailBloc extends ExtendedCubit<AppState>
{
  late LeaveDetailUseCase useCase;
  late AllRequestDetailMapper allRequestDetailMapper;
  GetLeaveDetailBloc(super.initialState,{required this.allRequestDetailMapper})
  {
    useCase = LeaveDetailUseCase(getLeaveDetailRepo: GetLeaveDetailRepoImpl(apiClientRepo: AllRequestDetailApiClientRepoImpl()));
  }


  fetchLeaveDetail(BuildContext context)async {
    emit(await useCase.getLeaveDetailRepo.fetchLeaveDetail(context, allRequestDetailMapper));
  }

}