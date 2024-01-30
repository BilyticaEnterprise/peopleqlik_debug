import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TeamModel/get_team_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

import '../../../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../ApiCalls/ApiGlobalModel/api_global_model.dart';

class EmployeeOverTimeSearchBottomSheetListener extends GetChangeNotifier
{
  List<TeamDataList>? teamDataList;
  ApiStatus apiStatus = ApiStatus.nothing;
  Map<dynamic,dynamic>? multiEmployee;
  late int typeId;

  EmployeeOverTimeSearchBottomSheetListener(this.typeId, {List<TeamDataList>? previousSelectedList})
  {
    if(previousSelectedList!=null)
    {
      for (var element in previousSelectedList) {
        multiEmployee = {};
        multiEmployee?.putIfAbsent(element.employeeCode, () => element.toJson());
      }
    }
  }

  void searchEmployee(BuildContext context,String searchText) async{

    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse? apiResponse = await GetApisUrlCaller().getOverTimeTeamApiCall(context,1,searchText,typeId);
    if(apiResponse.apiStatus==ApiStatus.done)
    {
      apiStatus = ApiStatus.done;
      teamDataList = apiResponse.data?.resultSet?.dataList;
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      apiStatus = ApiStatus.empty;
      teamDataList = null;
      notifyListeners();
    }
    else
    {
      apiStatus = ApiStatus.error;
      teamDataList = null;

      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }

  void updateMultiSelectedIndex(int index)
  {
    multiEmployee ??= {};
    if(multiEmployee?.containsKey(teamDataList![index].employeeCode) == true)
    {
      multiEmployee?.remove(teamDataList![index].employeeCode);
    }
    else
    {
      multiEmployee?.putIfAbsent(teamDataList![index].employeeCode, () => teamDataList![index].toJson());
    }
    notifyListeners();
  }

  getMultiEmployee() {
    return multiEmployee;
  }

}
