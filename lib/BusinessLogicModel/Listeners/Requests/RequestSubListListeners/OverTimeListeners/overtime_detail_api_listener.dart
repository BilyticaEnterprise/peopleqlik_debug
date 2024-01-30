import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';

import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../Enums/apistatus_enum.dart';
import '../../../../Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';
import '../../../../Models/TimeOffAndEnCashModel/overtime_detail_model.dart';
import '../../../../Models/TimeOffAndEnCashModel/overtime_list_model.dart';
import '../../../../Models/TimeOffAndEnCashModel/overtime_team_model.dart';
import '../../../Approvals/get_approval_list.dart';

class OvertimeDetailListener extends GetChangeNotifier
{
  final OvertimeListData? _overtimeListData;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<OvertimeViewModel>? overTimeEmployeeModel;
  List<List<ApprovalHistory>>? approvalsList;
  List<ApprovalHistory>? uniqueList;

  OvertimeDetailListener(this._overtimeListData);

  void start(BuildContext context)async
  {
    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse apiResponse = await GetApisUrlCaller().getOvertimeDetail(context, '?StartDate=${GetDateFormats().getFilterMonth1(_overtimeListData?.minDate)}&EndDate=${GetDateFormats().getFilterMonth1(_overtimeListData?.maxDate)}&RequestID=${_overtimeListData?.documentNo}');
    if(apiResponse.apiStatus == ApiStatus.done)
      {
        overTimeEmployeeModel = _createMusicListByEmployee(apiResponse.data.resultSet.requestDetail);
        uniqueList = apiResponse.data.resultSet.approvalHistory;
        approvalsList = getApprovalHistory(uniqueList);
        apiStatus = ApiStatus.done;
        notifyListeners();
      }
    else
      {
        apiStatus = apiResponse.apiStatus!;
        notifyListeners();
        ShowErrorMessage.show(apiResponse);
      }
  }
  /// Adding wrapper above mapped music list
  _createMusicListByEmployee(List<OvertimeTeamListDataList> list)
  {
    Map<String, List<OvertimeTeamListDataList>>? idLists = _createMapOfCategories(list);
    List<OvertimeViewModel> musicList = List.empty(growable: true);
    idLists?.forEach((key, value) {
      value.removeWhere((element) => element.overtimeMinutes==0);
      double sum = value.fold(0, (previousValue, element) => previousValue + (element.overtimeMinutes??0));
      musicList.add(OvertimeViewModel(value.first, value,sum.toInt()));
    });
    return musicList;
  }

  /// converting the whole music list into categories
  _createMapOfCategories(List<OvertimeTeamListDataList> list)
  {
    Map<String, List<OvertimeTeamListDataList>> idLists = {};
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
class OvertimeViewModel
{
  List<OvertimeTeamListDataList>? datesList;
  OvertimeTeamListDataList? employeeData;
  int totalMinutes;

  OvertimeViewModel(this.employeeData,this.datesList,this.totalMinutes);
}