import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/data/model/document_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DocumentPolicyModule/subModules/documentDetailPage/domain/model/document_policy_detail_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/timer_update_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/data/model/attendance_mapper.dart';
import 'package:peopleqlik_debug/Version1/models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/utils/UserLocation/get_user_location.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/date_formats.dart';
import '../../../../../utils/loader_utils/loader_class.dart';
import '../../../ApiModule/domain/usecase/apis_url_caller.dart';
import '../../data/model/attendance_model.dart';
import '../../data/model/dashboard_attendance_model.dart';
import '../../../../../Version1/models/TeamModel/get_employee_leave_balance_mapper.dart';
import 'attendance_logic_builder.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

class PostAttendanceListener extends GetChangeNotifier with GetLoader
{
  PostAttendanceResultSet? postAttendanceResultSet;
  List<ObjLeaveBalance>? objLeaveBalance;
  List<ObjDocument>? objDocumentList;
  ApiStatus? apiStatus = ApiStatus.nothing;
  CheckInOutBreakInStatus checkInOutBreakInStatus = CheckInOutBreakInStatus.nothing;
  double? _attendancePercent = 1;

  Future? start(BuildContext context,var map)
  async {

    initLoader();
    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().saveAttendanceApi(context,map);
    await closeLoader();
    // PostAttendanceData? postAttendanceData = await PostAttendanceApiCall().callApi(context,map);
    Future.delayed(const Duration(milliseconds: 100),(){
      if(apiResponse.apiStatus == ApiStatus.done)
      {
        postAttendanceResultSet = apiResponse.data!.resultSet![0];

        checkUserAttendanceStatus(postAttendanceResultSet!.checkStatus.toString());
        checkSpinnerCirclePercent(context);
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
      if(settingsModelListener.settingsResultSet?.shiftWorkingHours!=null&&settingsModelListener.settingsResultSet!.shiftWorkingHours!.isNotEmpty&&postAttendanceResultSet?.totalMinutes!=null)
      {
        TimerUpdateListener timerUpdateListener = Provider.of<TimerUpdateListener>(context,listen: false);
        timerUpdateListener.makeCircleSpinnerReady(context,postAttendanceResultSet?.totalMinutes,settingsModelListener.settingsResultSet!.shiftWorkingHours!.first.shiftStartTime!.toString(),settingsModelListener.settingsResultSet!.shiftWorkingHours!.first.shiftEndTime!.toString());
        if(checkInOutBreakInStatus == CheckInOutBreakInStatus.checkOut)
        {
          Future.delayed(const Duration(milliseconds: 200),(){timerUpdateListener.startTimer(postAttendanceResultSet?.firstCheckin,alreadyTotalMinutes: postAttendanceResultSet?.totalMinutes);});
        }
        else
          {
            timerUpdateListener.closeTimer();
          }

      }
    }
    catch(e){

    }
  }

  checkUserAttendanceStatus(String checkStatus)
  {
    PrintLogs.printLogs('checkstatus $checkStatus');
    switch(checkStatus)
    {
      case '${CheckInOutId.checkIn}':
        checkInOutBreakInStatus = CheckInOutBreakInStatus.checkIn;
        break;
      case '${CheckInOutId.checkOut}':
        checkInOutBreakInStatus = CheckInOutBreakInStatus.checkOut;
        break;
      default:
        checkInOutBreakInStatus = CheckInOutBreakInStatus.checkIn;
        break;

    }
  }
  Future? getDashBoard(BuildContext context)
  async {
    apiStatus = ApiStatus.started;
    notifyListeners();
    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getDashboardApiCall(context);
    if(apiResponse.apiStatus==ApiStatus.done)
    {
      postAttendanceResultSet = apiResponse.data!.resultSet.objAttendance![0];
      objLeaveBalance = apiResponse.data!.resultSet.objLeaveBalance;
      objDocumentList = apiResponse.data!.resultSet.objDocument;
      checkUserAttendanceStatus(postAttendanceResultSet!.checkStatus.toString());
      checkSpinnerCirclePercent(context);
      apiStatus = ApiStatus.done;
      notifyListeners();
    }
    else
    {
      apiStatus = apiResponse.apiStatus??ApiStatus.error;
      PrintLogs.printLogs('apistatusselse ${apiStatus}');
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

  getLeaveBalance() {

    double totalBalance = 0;
    if(objLeaveBalance!=null&&objLeaveBalance!.isNotEmpty)
      {
        objLeaveBalance?.forEach((element) {
          totalBalance = (element.nETbalance??0) + totalBalance;
        });

      }
    return totalBalance;
  }

  void gotToNextDetailPage(BuildContext context, int index) {
    PrintLogs.printLogs('sadas ${RequestType.documentUrl}${objDocumentList?[index].fileName}');
    Navigator.pushNamed(context, CurrentPage.documentDetailPage,
        arguments: DocumentPolicyDetailModel(
            documentTitle: objDocumentList?[index].documentTitle,
            fileName: '${RequestType.documentUrl}${objDocumentList?[index].fileName}',
            description: objDocumentList?[index].description,
            typeID: objDocumentList?[index].typeID,
            documentCode: objDocumentList?[index].documentCode,
            companyCode: objDocumentList?[index].companyCode,
            readAcknowledgement: objDocumentList?[index].readAcknowledgement,
            acknowledgementBody: objDocumentList?[index].acknowledgementBody,
            typeName: objDocumentList?[index].typeName,
            canDownload: objDocumentList?[index].canDownload,
            createdDate: objDocumentList?[index].createdDate,
          acknowledgement: objDocumentList?[index].acknowledgement
        )
    ).then((value){
      if(value != null && value is bool)
        {
          getDashBoard(context);
        }
    });
  }
}