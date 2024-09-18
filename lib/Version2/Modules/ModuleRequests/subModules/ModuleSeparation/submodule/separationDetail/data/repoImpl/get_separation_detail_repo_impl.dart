import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/get_approval_list.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/all_request_detail_api_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleSeparation/submodule/separationDetail/domain/models/separation_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleSeparation/submodule/separationDetail/domain/repo/get_separation_detail_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';

class GetSeparationDetailRepoImpl extends GetSeparationDetailRepo with GetLoader
{
  AllRequestDetailApiClientRepo apiClientRepo;
  List<List<ApprovalList>>? _approvalsList;
  SeparationResult? _separationResult;

  GetSeparationDetailRepoImpl({required this.apiClientRepo});

  @override
  Future<AppState> fetchSeparationDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper) async {
    AppState appState = await apiClientRepo.getData(context, allRequestDetailMapper, ClassType<SeparationDetailModel>(SeparationDetailModel.fromJson));
    if(appState is AppStateDone)
    {
      SeparationDetailModel model = appState.data as SeparationDetailModel;
      _separationResult = model.resultSet?.data?.result;
      canAdminApprove = model.resultSet?.data?.statusID;
      if(model.resultSet?.data?.approvalList != null && model.resultSet!.data!.approvalList!.isNotEmpty)
      {
        _approvalsList = getApprovalList(model.resultSet!.data!.approvalList!);
      }
    }
    return appState;
  }

  @override
  Future<AppState> approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper, required String remarks, required int approveOrReject}) async {
    initLoader();
    AppState appState = await apiClientRepo.approveRejectRequest(context, allRequestDetailMapper: allRequestDetailMapper, remarks: remarks, approveOrReject: approveOrReject);
    await closeLoader();
    return appState;

  }

  @override
  List<List<ApprovalList>>? getApprovalListForView() {
    return _approvalsList;
  }

  @override
  SeparationResult? getSeparationDetailResult() {
    return _separationResult;
  }

}