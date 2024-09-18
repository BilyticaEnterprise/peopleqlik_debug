import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/data/remote/api_client.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/approval_action_button_pressed.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleGenericRequests/subModules/genericDetailModule/data/repoImpl/general_request_detail_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleGenericRequests/subModules/genericDetailModule/domain/usecase/general_request_detail_usecase.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_remarks_sheet/call_remarks_bottom_sheet.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class GeneralRequestDetailBloc extends ExtendedCubit<AppState> with ApprovalActionButton
{
  late GeneralRequestDetailUseCase useCase;
  late AllRequestDetailMapper allRequestDetailMapper;
  GeneralRequestDetailBloc(super.initialState,{required this.allRequestDetailMapper})
  {
    useCase = GeneralRequestDetailUseCase(repo: GeneralRequestDetailRepoImpl(apiClientRepo: AllRequestDetailApiClientRepoImpl()));
  }


  fetchGeneralRequestDetail(BuildContext context)async {
    emit(await useCase.repo.fetchGeneralRequestDetail(context, allRequestDetailMapper));
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