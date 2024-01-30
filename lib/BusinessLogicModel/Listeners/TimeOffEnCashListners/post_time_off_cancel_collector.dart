import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/loader_class.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/post_timeoff_cancel_api.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/time_off_cancel_mapper.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/time_off_get_form_mapper.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/time_off_model.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/icons.dart';
import 'package:peopleqlik_debug/src/loader.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';

import '../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../ApiCalls/ApiCallers/show_error.dart';
import '../../ApiCalls/ApiGlobalModel/api_global_model.dart';
import '../../Enums/apistatus_enum.dart';

class TimeOffCancelCollector with GetLoader
{
  CancelLeaveMapper? cancelLeaveJson;
  TimeOffCancelCollector()
  {
    cancelLeaveJson = CancelLeaveMapper();
  }
  fillData(BuildContext context,LeavesDataList? leavesDataList)async
  {
    var list = [];
    cancelLeaveJson?.cancelLeaveDate = GetDateFormats().getMonthFormatDay(DateTime.now());
    cancelLeaveJson?.employeeCode = leavesDataList?.employeeCode;
    cancelLeaveJson?.companyCode = leavesDataList?.companyCode;
    cancelLeaveJson?.applicationCode = leavesDataList?.applicationCode;
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
    ApiResponse? apiResponse = await GetApisUrlCaller().postCancelTimeOff(context,map);
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