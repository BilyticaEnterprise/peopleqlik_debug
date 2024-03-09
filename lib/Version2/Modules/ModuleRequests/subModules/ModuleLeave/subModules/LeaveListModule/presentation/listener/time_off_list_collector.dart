import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../../../../ApiModule/domain/model/show_error.dart';
import '../../../../../../../ApiModule/domain/model/api_global_model.dart';
import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';


class TimeOffModelListener extends GetChangeNotifier
{
  List<LeavesDataList>? leavesDataList;
  ApiStatus apiStatus = ApiStatus.nothing;
  bool reachedEnd=false;
  int page=0;

  Future? start(BuildContext context, ApiStatus status)
  async {

    leavesDataList ??= List.empty(growable: true);

    //PrintLogs.print('calleddd $status');
    apiStatus = status;
    page += 1; //and afterwards this list starts with page increment of 1
    if(apiStatus==ApiStatus.started)
    {
      reachedEnd = false;
      page = 1; //but if this list starts for the very first time then set to 1
      leavesDataList?.clear();
    }
    notifyListeners();

    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getTimeOffListApiCall(context,'?CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}&PageNo=$page&PerPage=10');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      updatedResponseAtReachedEndList();
      apiStatus = ApiStatus.done;
      for(int x=0;x<apiResponse.data!.resultSet!.dataList!.length;x++)
        {
          leavesDataList?.add(apiResponse.data!.resultSet!.dataList![x]);
        }
      reachedEnd = false;
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty&&leavesDataList!=null&&leavesDataList!.isNotEmpty)
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
      leavesDataList = null;
      notifyListeners();
    }
    else
    {
      apiStatus = ApiStatus.error;
      updatedResponseAtReachedEndList();
      reachedEnd = false;
      page -=1 ;
      apiStatus = ApiStatus.error;
      leavesDataList = null;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);

    }

  }
  void updateStep(bool event,BuildContext context)
  {
    if(reachedEnd==false&&event==true)
    {
      leavesDataList?.add(LeavesDataList());
      reachedEndList(true);
      start(context,ApiStatus.pagination);
    }
  }
  void updatedResponseAtReachedEndList()
  {
    int? length = leavesDataList?.length;
    if(apiStatus==ApiStatus.pagination&&length!=null&&length>0)
    {
      leavesDataList?.removeAt(length-1);
    }
  }
  void reachedEndList(bool reached)
  {
    reachedEnd = reached;
    notifyListeners();
  }
}

