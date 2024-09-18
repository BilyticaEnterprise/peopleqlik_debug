import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/leave_detail_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/time_off_cancel_mapper.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';

import '../../../../../../../ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../../../../../ApiModule/domain/model/show_error.dart';
import '../../../../../../../ApiModule/domain/model/api_global_model.dart';

class TimeOffCancelCollector with GetLoader
{
  CancelLeaveMapper? cancelLeaveJson;
  TimeOffCancelCollector()
  {
    cancelLeaveJson = CancelLeaveMapper();
  }
  fillData(BuildContext context, LeaveDetailResult? leaveDetailResult, )async
  {
    var list = [];
    cancelLeaveJson?.cancelLeaveDate = GetDateFormats().getMonthFormatDay(DateTime.now());
    cancelLeaveJson?.employeeCode = leaveDetailResult?.employeeCode;
    cancelLeaveJson?.companyCode = leaveDetailResult?.companyCode;
    cancelLeaveJson?.applicationCode = leaveDetailResult?.applicationCode;
    cancelLeaveJson?.cultureID = 1;
    cancelLeaveJson?.laLeaveApplicationDocument = "";
    cancelLeaveJson?.laLeaveApplicationTimeoff = "";
    var j = jsonEncode(cancelLeaveJson?.toJson());
    CancelLeaveMapper s1 = CancelLeaveMapper.fromJson(await jsonDecode(j));
    s1.cultureID = 1;
    CancelLeaveMapper s2 = CancelLeaveMapper.fromJson(await jsonDecode(j));
    s2.cultureID = 2;
    list.add(s1.toJson());
    list.add(s2.toJson());
    // PrintLogs.printLogs('dasdasasdd ${list}');
    start(context,list);
  }
  Future? start(BuildContext context, List map)
  async {

    initLoader();
    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().postCancelTimeOff(context,map);
    await closeLoader();

    //PostTimeOffCancelData? postTimeOffCancelData = await PostTimeOffCancelApiCall().callApi(context,map);
    Future.delayed(const Duration(milliseconds: 100),(){
      if(apiResponse.apiStatus == ApiStatus.done)
      {
        if(apiResponse.data?.message!=null) {
          SnackBarDesign.happySnack(apiResponse.data?.message??'');
        }
        Navigator.pop(context,true);
      }
      else
      {
        ShowErrorMessage.show(apiResponse);
      }
    });
  }

}