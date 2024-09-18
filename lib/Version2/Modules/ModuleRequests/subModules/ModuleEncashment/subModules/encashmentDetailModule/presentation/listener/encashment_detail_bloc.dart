import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/data/remote/api_client.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/approval_action_button_pressed.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleEncashment/subModules/encashmentDetailModule/data/repoImpl/get_encashement_detail_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleEncashment/subModules/encashmentDetailModule/domain/usecase/encashment_detail_usecase.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_remarks_sheet/call_remarks_bottom_sheet.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class GetEncashmentDetailBloc extends ExtendedCubit<AppState> with ApprovalActionButton
{
  late EncashmentDetailUseCase useCase;
  late AllRequestDetailMapper allRequestDetailMapper;
  GetEncashmentDetailBloc(super.initialState,{required this.allRequestDetailMapper})
  {
    useCase = EncashmentDetailUseCase(repo: GetEncashmentDetailRepoImpl(apiClientRepo: AllRequestDetailApiClientRepoImpl()));
  }

  fetchTimeRegulationMovementDetail(BuildContext context)async {
    emit(await useCase.fetchTimeRegulationDetail(context, allRequestDetailMapper));
  }

  approveRejectRequest(BuildContext context, {required String remarks, required int approveOrReject}) async
  {
    AppState appState = await useCase.approveRejectRequest(context, allRequestDetailMapper: allRequestDetailMapper, remarks: remarks, approveOrReject: approveOrReject);
    if(appState is AppStateDone)
    {
      Navigator.pop(context,true);
    }
  }

  @override
  void actionButtonPressed(BuildContext context, AcceptReject acceptReject, int statusId) {
    CallApprovalRemarksBottomSheet.show(
        context,
        remarksCallBack: (value){
          approveRejectRequest(context, remarks: value, approveOrReject: statusId);
        },
        acceptReject: acceptReject
    );
  }

}