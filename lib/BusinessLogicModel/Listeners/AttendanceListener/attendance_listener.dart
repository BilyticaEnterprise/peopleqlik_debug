import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/show_error.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/post_attendance_api.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AttendanceModel/attendance_mapper.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AttendanceModel/attendance_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/UserLocation/get_user_location.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/icons.dart';
import 'package:peopleqlik_debug/src/loader.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import '../../../src/date_formats.dart';
import '../../AbstractClasses/loader_class.dart';
import '../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../Models/TeamModel/get_employee_leave_balance_mapper.dart';
import 'attendance_logic_builder.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

class PostAttendanceListener extends GetChangeNotifier with GetLoader
{
  PostAttendanceResultSet? postAttendanceResultSet;
  ApiStatus? apiStatus = ApiStatus.nothing;
  CheckInOutBreakInStatus checkInOutBreakInStatus = CheckInOutBreakInStatus.nothing;
  double? attendancePercent = 1;

  Future? start(BuildContext context,var map)
  async {

    initLoader();
    ApiResponse? apiResponse = await GetApisUrlCaller().saveAttendanceApi(context,map);
    await closeLoader();
    // PostAttendanceData? postAttendanceData = await PostAttendanceApiCall().callApi(context,map);
    Future.delayed(const Duration(milliseconds: 100),(){
      if(apiResponse.apiStatus == ApiStatus.done)
      {
        postAttendanceResultSet = apiResponse.data!.resultSet![0];

        checkSpinnerCirclePercent(context);
        checkUserAttendanceStatus(postAttendanceResultSet!.checkStatus.toString());
        apiStatus = ApiStatus.done;
        notifyListeners();
      }
      else if(apiResponse.apiStatus == ApiStatus.empty)
      {
        apiStatus = ApiStatus.empty;
        if(apiResponse.data!=null&&apiResponse.data?.errorMessage!=null)
        {
          SnackBarDesign.errorSnack(apiResponse.data!.errorMessage);
        }
        postAttendanceResultSet = null;
        notifyListeners();
      }
      else
      {
        apiStatus = apiResponse.apiStatus!;
        notifyListeners();
        ShowErrorMessage.show(apiResponse);
      }
    });
  }

  checkSpinnerCirclePercent(BuildContext context)
  {
    try{
      SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
      if(settingsModelListener.settingsResultSet?.shiftWorkingHours!=null&&settingsModelListener.settingsResultSet!.shiftWorkingHours!.isNotEmpty&&postAttendanceResultSet?.totalMinutes!=null&&(postAttendanceResultSet?.totalMinutes??0)>0)
      {
        int? totalMinutes = GetDateFormats().formatCalculateTimeOnly(settingsModelListener.settingsResultSet!.shiftWorkingHours!.first.shiftStartTime!.toString(),settingsModelListener.settingsResultSet!.shiftWorkingHours!.first.shiftEndTime!.toString());
        attendancePercent = ((postAttendanceResultSet?.totalMinutes??0)/(totalMinutes??100))*100;
        if((attendancePercent??0) < 1.0)
        {
          attendancePercent = 1;
        }
      }
    }
    catch(e){
      attendancePercent = 1;
    }
  }
  checkUserAttendanceStatus(String checkStatus)
  {
    switch(checkStatus)
    {
      case '0':
        checkInOutBreakInStatus = CheckInOutBreakInStatus.checkIn;
        break;
      case '1':
        checkInOutBreakInStatus = CheckInOutBreakInStatus.checkOut;
        break;
      default:
        checkInOutBreakInStatus = CheckInOutBreakInStatus.checkOut;
        break;

    }
  }
  Future? getDashBoard(BuildContext context)
  async {
    apiStatus = ApiStatus.started;
    notifyListeners();
    ApiResponse? apiResponse = await GetApisUrlCaller().getDashboardApiCall(context);
    if(apiResponse.apiStatus==ApiStatus.done)
    {
      postAttendanceResultSet = apiResponse.data!.resultSet![0];
      //PrintLogs.printLogs('asdasndjkas ${postAttendanceResultSet?.companyCode}');
      checkSpinnerCirclePercent(context);
      checkUserAttendanceStatus(postAttendanceResultSet!.checkStatus.toString());
      apiStatus = ApiStatus.done;
      notifyListeners();
    }
    else
    {
      apiStatus = apiResponse.apiStatus??ApiStatus.error;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }

  void makePostMapper(BuildContext context,int checkInCheckOut) async
  {
    CheckUserLocation checkUserLocation = Provider.of(context,listen: false);
    LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    PostAttendanceMapper postAttendanceMapper = PostAttendanceMapper();
    postAttendanceMapper.companyCode = loginResultSet.headerInfo?.companyCode;
    postAttendanceMapper.employeeCode = loginResultSet.headerInfo?.attendanceCode??0;
    postAttendanceMapper.cultureID = loginResultSet.headerInfo?.cultureID.toString();
    postAttendanceMapper.remarks = '';
    postAttendanceMapper.modifiedBy = loginResultSet.headerInfo?.userID;
    postAttendanceMapper.createdBy = loginResultSet.headerInfo?.userID;
    postAttendanceMapper.attendanceMode = checkInCheckOut;
    postAttendanceMapper.attendanceTime = DateTime.now().toString();
    postAttendanceMapper.iPAddress = '99.99.99.99';
    postAttendanceMapper.isTransfered = true;
    postAttendanceMapper.isTransferedEBS = false;
    postAttendanceMapper.latitude = checkUserLocation.position?.latitude.toString();
    postAttendanceMapper.longitude = checkUserLocation.position?.longitude.toString();

    start(context,postAttendanceMapper.toJson());

  }

  void goToLeaveBalancePage(BuildContext context) {
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    Navigator.pushNamed(context, CurrentPage.leaveBalancePage,arguments: ForBalanceEmployeeInfo(companyCode: settingsModelListener.settingsResultSet?.headerInfo?.companyCode,employeeCode: settingsModelListener.settingsResultSet?.headerInfo?.employeeCode));
  }
}