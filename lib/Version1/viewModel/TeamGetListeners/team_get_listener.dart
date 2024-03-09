import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/Models/TeamModel/get_team_model.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';


class GetTeamListModelListener extends GetChangeNotifier
{
  List<TeamDataList>? teamDataList;
  ApiStatus apiStatus = ApiStatus.nothing;
  bool reachedEnd=false;
  int page=0;

  Future? start(BuildContext context, ApiStatus status,String? searchText)
  async {

    teamDataList ??= List.empty(growable: true);

    //print('calleddd $status');
    apiStatus = status;
    page += 1; //and afterwards this list starts with page increment of 1
    if(apiStatus==ApiStatus.started)
    {
      reachedEnd = false;
      page = 1; //but if this list starts for the very first time then set to 1
      teamDataList?.clear();
    }
    notifyListeners();

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getTeamApiCall(context,page,searchText);
    if(apiResponse.apiStatus==ApiStatus.done)
    {
      updatedResponseAtReachedEndList();
      apiStatus = ApiStatus.done;
      for(int x=0;x<apiResponse.data!.resultSet!.dataList!.length;x++)
      {
        teamDataList?.add(apiResponse.data!.resultSet!.dataList![x]);
      }
      reachedEnd = false;
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty&&teamDataList!.isNotEmpty)
    {
      updatedResponseAtReachedEndList();
      reachedEnd = false;
      apiStatus = ApiStatus.done;
      page -=1 ;
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      apiStatus = ApiStatus.empty;
      updatedResponseAtReachedEndList();

      reachedEnd = false;
      page -=1 ;
      apiStatus = ApiStatus.empty;
      teamDataList = null;
      notifyListeners();
    }
    else
    {
      apiStatus = ApiStatus.error;
      updatedResponseAtReachedEndList();
      reachedEnd = false;
      page -=1 ;
      apiStatus = ApiStatus.error;
      teamDataList = null;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }

  }
  void updateStep(bool event,BuildContext context,{String? searchText})
  {
    if(reachedEnd==false&&event==true)
    {
      teamDataList?.add(TeamDataList());
      reachedEndList(true);
      start(context,ApiStatus.pagination,searchText);
    }
  }
  void updatedResponseAtReachedEndList()
  {
    int? length = teamDataList?.length;
    if(apiStatus==ApiStatus.pagination&&length!=null&&length>0)
    {
      teamDataList?.removeAt(length-1);
    }
  }
  void reachedEndList(bool reached)
  {
    reachedEnd = reached;
    notifyListeners();
  }
}

