import 'package:flutter/src/widgets/framework.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/get_approval_list.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/all_request_detail_api_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleShift/subModules/shiftDetaiApprovalModule/domain/model/shift_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleShift/subModules/shiftDetaiApprovalModule/domain/repo/shift_detail_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:provider/provider.dart';

class GetShiftDetailRepoImpl extends GetShiftDetailRepo with GetLoader
{
  AllRequestDetailApiClientRepo apiClientRepo;
  List<List<ApprovalList>>? _approvalsList;
  ShiftResult? _shiftResult;

  GetShiftDetailRepoImpl({required this.apiClientRepo});

  @override
  Future<AppState> fetchShiftDetail(BuildContext context, AllRequestDetailMapper allRequestDetailMapper) async {
    AppState appState = await apiClientRepo.getData(context, allRequestDetailMapper, ClassType<ShiftDetailModel>(ShiftDetailModel.fromJson));
    if(appState is AppStateDone)
    {
      ShiftDetailModel model = appState.data as ShiftDetailModel;
      _shiftResult = model.resultSet?.data?.result;
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
  ShiftResult? getShiftDetailResult() {
    return _shiftResult;
  }

  @override
  List<String?>? offDaysList(BuildContext context) {
    if(_shiftResult != null)
      {
        List<String?>? list = Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.weekDayList?.map((e) => (_shiftResult?.offDays?.contains(e.weekDayID)==true)?e.dayName:null).toList();
        list?.removeWhere((element) => element == null);
        return list;
      }
    return null;
  }

}