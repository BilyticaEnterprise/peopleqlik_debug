import 'package:flutter/cupertino.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_encashment_list_model.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class GetEncashmentRequestListListener extends GetChangeNotifier
{
  List<RequestSpecialDataList>? requestDataList;
  ApiStatus apiStatus = ApiStatus.nothing;
  bool reachedEnd=false;
  int page=0;

  Future? start(BuildContext context,ApiStatus status)
  async {
    requestDataList ??= List.empty(growable: true);

    //PrintLogs.print('calleddd $status');
    apiStatus = status;
    page += 1; //and afterwards this list starts with page increment of 1
    if(apiStatus==ApiStatus.started)
    {
      reachedEnd = false;
      page = 1; //but if this list starts for the very first time then set to 1
      requestDataList?.clear();
    }
    notifyListeners();
    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse? apiResponse = await GetApisUrlCaller().getEncashmentListApiCall(context,'?PageNo=$page&PerPage=10&CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      updatedResponseAtReachedEndList();
      apiStatus = ApiStatus.done;
      for(int x=0;x<apiResponse.data!.resultSet!.dataList!.length;x++)
      {
        requestDataList?.add(apiResponse.data!.resultSet!.dataList![x]);
      }
      reachedEnd = false;
      notifyListeners();

    }
    else if(apiResponse.apiStatus == ApiStatus.empty&&requestDataList!=null&&requestDataList!.isNotEmpty)
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
      requestDataList = null;
      notifyListeners();
    }
    else
    {
      updatedResponseAtReachedEndList();
      reachedEnd = false;
      page -=1 ;
      apiStatus = ApiStatus.error;
      requestDataList = null;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);

    }
  }
  void updateStep(bool event,BuildContext context)
  {
    if(reachedEnd==false&&event==true)
    {
      requestDataList?.add(RequestSpecialDataList());
      reachedEndList(true);
      start(context,ApiStatus.pagination);
    }
  }
  void reachedEndList(bool reached)
  {
    reachedEnd = reached;
    notifyListeners();
  }

  void updatedResponseAtReachedEndList()
  {
    int? length = requestDataList?.length;
    if(apiStatus==ApiStatus.pagination&&length!=null&&length>0)
    {
      requestDataList?.removeAt(length-1);
    }
  }
}

