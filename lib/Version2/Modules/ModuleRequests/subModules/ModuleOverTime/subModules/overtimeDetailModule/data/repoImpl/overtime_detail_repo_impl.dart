import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/get_approval_list.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/all_request_detail_api_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeDetailModule/domain/models/overtime_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeDetailModule/domain/models/overtime_detail_view_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeDetailModule/domain/repo/overtime_detail_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';

class GetOvertimeDetailRepoImpl extends GetOvertimeDetailRepo with GetLoader
{
  AllRequestDetailApiClientRepo apiClientRepo;
  List<List<ApprovalList>>? _approvalsList;
  List<OvertimeViewModel>? _overtimeResultIs;

  GetOvertimeDetailRepoImpl({required this.apiClientRepo});

  @override
  Future<AppState> fetchOvertimeDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper) async {
    AppState appState = await apiClientRepo.getData(context, allRequestDetailMapper, ClassType<OvertimeDetailModel>(OvertimeDetailModel.fromJson));
    if(appState is AppStateDone)
    {
      OvertimeDetailModel model = appState.data as OvertimeDetailModel;
      canAdminApprove = model.resultSet?.data?.statusID;
      if(model.resultSet?.data?.result?.overtimeDetailList!=null&&model.resultSet!.data!.result!.overtimeDetailList!.isNotEmpty)
        {
          _overtimeResultIs = _createMusicListByEmployee(model.resultSet!.data!.result!.overtimeDetailList!,model.resultSet?.data?.result?.approvalStatusID);

          if(model.resultSet?.data?.approvalList != null && model.resultSet!.data!.approvalList!.isNotEmpty)
          {
            _approvalsList = getApprovalList(model.resultSet!.data!.approvalList!);
          }
        }
      else
        {
          return AppStateError(data: 'Server error');
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
  List<OvertimeViewModel>? getOvertimeDetailResult() {
    return _overtimeResultIs;
  }

  /// Adding wrapper above mapped music list
  List<OvertimeViewModel> _createMusicListByEmployee(List<OvertimeDetailList> list, int? approvalStatusID)
  {
    Map<String, List<OvertimeDetailList>>? idLists = _createMapOfCategories(list);
    List<OvertimeViewModel> musicList = List.empty(growable: true);
    idLists?.forEach((key, value) {
      value.removeWhere((element) => element.overtimeMinutes==0);
      double sum = value.fold(0, (previousValue, element) => previousValue + (element.overtimeMinutes??0));
      musicList.add(OvertimeViewModel(value.first, value,sum.toInt(),approvalStatusID));
    });
    return musicList;
  }

  /// converting the whole music list into categories
  _createMapOfCategories(List<OvertimeDetailList> list)
  {
    Map<String, List<OvertimeDetailList>> idLists = {};
    for(int x=0;x<list.length;x++)
    {
      String id = list[x].employeeCode??'';
      if (!idLists.containsKey(id)) {
        idLists[id] = [];
      }
      idLists[id]!.add(list[x]);
    }
    return idLists;
  }

}