import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/data/remote/api_client.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleShift/subModules/shiftDetaiApprovalModule/data/repoImpl/shift_detail_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleShift/subModules/shiftDetaiApprovalModule/domain/usecase/shift_usecase.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_remarks_sheet/call_remarks_bottom_sheet.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';
import 'package:provider/provider.dart';

class GetShiftDetailBloc extends ExtendedCubit<AppState>
{
  late GetShiftDetailUseCase useCase;
  late AllRequestDetailMapper allRequestDetailMapper;
  List<String?>? _offDaysNameList;
  GetShiftDetailBloc(super.initialState,{required this.allRequestDetailMapper})
  {
    useCase = GetShiftDetailUseCase(repo: GetShiftDetailRepoImpl(apiClientRepo: AllRequestDetailApiClientRepoImpl()));

  }


  fetchShiftDetail(BuildContext context)async {
    emit(await useCase.fetchShiftDetail(context, allRequestDetailMapper));
  }

  approveRejectRequest(BuildContext context, {required String remarks, required int approveOrReject}) async
  {
    AppState appState = await useCase.approveRejectRequest(context, allRequestDetailMapper: allRequestDetailMapper, remarks: remarks, approveOrReject: approveOrReject);
    if(appState is AppStateDone)
    {
      Navigator.pop(context,true);
    }
  }

  List<String?>? getOffDays(BuildContext context)
  {
    _offDaysNameList ??= useCase.getOffDaysList(context);
    return _offDaysNameList;
  }

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