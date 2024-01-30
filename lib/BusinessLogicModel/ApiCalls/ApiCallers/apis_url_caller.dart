import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import '../../Models/AttendanceModel/attendance_model.dart';
import '../../Models/AttendanceModel/dashboard_attendance_model.dart';
import '../../Models/AuthModels/company_url_get_model.dart';
import '../../Models/AuthModels/cookie_model.dart';
import '../../Models/AuthModels/login_model.dart';
import '../../Models/Language/update_language_model.dart';
import '../../Models/Notifications/announcement_detail_model.dart';
import '../../Models/Notifications/announcement_list_model.dart';
import '../../Models/Notifications/notification_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/get_request_detail_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/get_request_encashment_balance_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/get_request_encashment_list_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/get_request_form_data.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/get_request_list_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/get_request_name_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/get_request_separation_detail_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/get_request_separation_form_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/get_request_separation_list_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/post_encashment_request_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/post_request_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/post_separation_from_model.dart';
import '../../Models/PaysSlipApprovalsRequest/RequestsModel/save_request_separation_calendar_model.dart';
import '../../Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';
import '../../Models/PaysSlipApprovalsRequest/get_approvals_list.dart';
import '../../Models/PaysSlipApprovalsRequest/get_payslip_list.dart';
import '../../Models/PaysSlipApprovalsRequest/get_payslip_month.dart';
import '../../Models/PaysSlipApprovalsRequest/get_request_encashment_detail_model.dart';
import '../../Models/PaysSlipApprovalsRequest/post_approval_model.dart';
import '../../Models/PaysSlipApprovalsRequest/request_list_form_model.dart';
import '../../Models/TeamModel/get_team_model.dart';
import '../../Models/TeamModel/leave_balance_model.dart';
import '../../Models/TimeOffAndEnCashModel/apply_leave_model.dart';
import '../../Models/TimeOffAndEnCashModel/get_holidays_model.dart';
import '../../Models/TimeOffAndEnCashModel/get_leave_detail_model.dart';
import '../../Models/TimeOffAndEnCashModel/leave_summary_model.dart';
import '../../Models/TimeOffAndEnCashModel/overtime_detail_model.dart';
import '../../Models/TimeOffAndEnCashModel/overtime_list_model.dart';
import '../../Models/TimeOffAndEnCashModel/overtime_submit_model.dart';
import '../../Models/TimeOffAndEnCashModel/overtime_team_model.dart';
import '../../Models/TimeOffAndEnCashModel/overtime_time_range_model.dart';
import '../../Models/TimeOffAndEnCashModel/shift_detail_model.dart';
import '../../Models/TimeOffAndEnCashModel/shift_list_model.dart';
import '../../Models/TimeOffAndEnCashModel/time_off_cancel_model.dart';
import '../../Models/TimeOffAndEnCashModel/time_off_get_form_mapper.dart';
import '../../Models/TimeOffAndEnCashModel/time_off_leave_balance.dart';
import '../../Models/TimeOffAndEnCashModel/time_off_model.dart';
import '../../Models/TimeRegulationModels/date_select_movement_slip_model.dart';
import '../../Models/TimeRegulationModels/time_regulation_approval_detail_model.dart';
import '../../Models/TimeRegulationModels/time_regulation_model.dart';
import '../../Models/TimeRegulationModels/time_regulation_monthly_model.dart';
import '../../Models/TimeRegulationModels/time_regulation_movement_submitted_model.dart';
import '../../Models/TimeRegulationModels/timeregulation_detail_model.dart';
import '../../Models/TimeSheetModel/get_time_sheet_model.dart';
import '../../Models/settings_model.dart';
import '../../Models/uploaded_file_model.dart';
import '../../SharedPrefs/login_prefs.dart';
import '../ApiGlobalModel/api_global_model.dart';
import '../Urls/urls.dart';
import 'calling_dio_apis.dart';
import 'check_type_enums.dart';
import 'model_decider.dart';

class GetApisUrlCaller
{
  Future<ApiResponse> getCompanyApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(baseUrl: RequestType.firstUrl,endPoint: '',checkTypes: CheckTypes.includeData,isPost: false,authHeaders: false,urlParameters: parameters,checkCookies: false, type: ClassType<CompanyJson>(CompanyJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getLoginApi(BuildContext context,dynamic parameters)async
  {
    ApiResponse apiResponse =  await CallingDioApis(endPoint: RequestType.loginUrl,checkTypes: CheckTypes.includeData,isPost: false,authHeaders: false,urlParameters: parameters,checkCookies: false, type: ClassType<LoginJson>(LoginJson.fromJson)).callApi(context);
    PrintLogs.printLogs('resakksdas ${apiResponse.apiStatus}');
    return apiResponse;
  }
  Future<ApiResponse> getCookieToken(BuildContext context)async
  {
    return await CallingDioApis(endPoint: RequestType.cookieCall,authHeaders: false,checkTypes: CheckTypes.cookie,isPost: false,checkCookies: false, type: ClassType<CookieJson>(CookieJson.fromJson)).callApi(context);
  }

  Future<ApiResponse> getSettingDataApi(BuildContext context,{dynamic header})async
  {
    return await CallingDioApis(endPoint: RequestType.settingsApi,isPost: false,headers: header,checkTypes: CheckTypes.includeData, type: ClassType<GetSettingsJson>(GetSettingsJson.fromJson)).callApi(context);
  }

  Future<ApiResponse> postLeaveApiApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.applyLeaveUrl,isPost: true,parameters: parameters,checkTypes: CheckTypes.onlyBool, type: ClassType<LeaveApplyJson>(LeaveApplyJson.fromJson)).callApi(context);
  }

  //
  Future<ApiResponse> getAnnouncementDetailApiCall(BuildContext context,dynamic urlParameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getAnnouncementDetail,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: urlParameters, type: ClassType<GetAnnouncementDetailJson>(GetAnnouncementDetailJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getAnnouncementListApiCall(BuildContext context)async
  {
    return await CallingDioApis(endPoint: RequestType.getAnnouncementList,checkTypes: CheckTypes.includeData,isPost: false, type: ClassType<GetAnnouncementListJson>(GetAnnouncementListJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getDashboardApiCall(BuildContext context)async
  {
    LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    return await CallingDioApis(endPoint: RequestType.getDashboard,checkTypes: CheckTypes.includeListData,urlParameters: '?CompanyCode=${loginResultSet.headerInfo?.companyCode}&EmployeeCode=${loginResultSet.headerInfo?.employeeCode}',isPost: false, type: ClassType<GetDashBoardJson>(GetDashBoardJson.fromJson)).callApi(context);
  }

  Future<ApiResponse> getTeamApiCall(BuildContext context,int page,String? searchText)async
  {
    return await CallingDioApis(endPoint: RequestType.teamApi,checkTypes: CheckTypes.includeListInsideData,urlParameters: '?Name=${searchText??''}&PageNo=$page&PerPage=10',isPost: false, type: ClassType<GetTeamJson>(GetTeamJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getOverTimeTeamApiCall(BuildContext context,int page,String? searchText,int? typeId)async
  {
    return await CallingDioApis(endPoint: RequestType.getEmployeeOverTime,checkTypes: CheckTypes.includeListInsideData,urlParameters: '?Name=${searchText??''}&PageNo=$page&PerPage=10&TypeID=$typeId',isPost: false, type: ClassType<GetTeamJson>(GetTeamJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getTimeRegulationOfficeApiCall(BuildContext context,int page,{required dynamic employeeCode,required dynamic companyCode,required dynamic typeId})async
  {
    return await CallingDioApis(endPoint: RequestType.timeRegulation,checkTypes: CheckTypes.includeListInsideData,urlParameters: '?PageNo=$page&PerPage=10&CompanyCode=$companyCode&EmployeeCode=$employeeCode&TypeID=$typeId',isPost: false, type: ClassType<TimeRegulationListModel>(TimeRegulationListModel.fromJson)).callApi(context);
  }
  Future<ApiResponse> getMovementSlipDataAgainstDateApiCall(BuildContext context,dynamic urlParameters)async
  {
    return await CallingDioApis(endPoint: RequestType.dateSelectMovementSlip,checkTypes: CheckTypes.includeListData,urlParameters: urlParameters,isPost: false, type: ClassType<DateSelectMovementSlipModel>(DateSelectMovementSlipModel.fromJson)).callApi(context);
  }
  Future<ApiResponse> postMovementSlipApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.submitMovementSlip,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<TimeRegulationAndMovementSubmittedModel>(TimeRegulationAndMovementSubmittedModel.fromJson)).callApi(context);
  }
  Future<ApiResponse> getMonthlyTimeRegulationApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getMonthlyTimeRegulationListApi,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<TimeRegulationMonthlyModel>(TimeRegulationMonthlyModel.fromJson)).callApi(context);
  }

  Future<ApiResponse> getApprovalDetailsApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getApprovalsDetails,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetApprovalDetailJson>(GetApprovalDetailJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getTimeRegularizationApprovalDetailsApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getApprovalsDetails,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<TimeRegulationApprovalDetailModel>(TimeRegulationApprovalDetailModel.fromJson)).callApi(context);
  }

  ///
  Future<ApiResponse> getRequestListApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getRequestList,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestListsJson>(GetRequestListsJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getEncashmentListApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getSpecialRequestList,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<GetEncashmentRequestListsJson>(GetEncashmentRequestListsJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getSeparationListApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getSeparationRequestList,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<GetSeparationRequestListsJson>(GetSeparationRequestListsJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getTimeSheetApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getTimeSheet,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<GetTimeSheetJson>(GetTimeSheetJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getTimeOffListApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.timeOff,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<TimeOffJson>(TimeOffJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getSeparationEmployeeFormApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getSeparationRequestApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetSeparationEmployeeListJson>(GetSeparationEmployeeListJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getLeaveFormDataApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getLeaveFormDataUrl,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<LeaveCreateFormJson>(LeaveCreateFormJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getLeaveSummaryApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getLeaveSummaryUrl,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<LeaveSummaryJson>(LeaveSummaryJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getLeaveBalanceApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getLeaveBalanceUrl,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetLeaveBalanceJson>(GetLeaveBalanceJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getEncashmentRequestFormApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getSpecialRequestForm,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetSpecialRequestFormJson>(GetSpecialRequestFormJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getEncashmentBalanceFormApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getSpecialRequestBalance,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<GetEncashmentRequestBalanceJson>(GetEncashmentRequestBalanceJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getTimeRegulationDetailsApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getTimeRegulationDetails,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<TimeRegulationDetailsModel>(TimeRegulationDetailsModel.fromJson)).callApi(context);
  }
  Future<ApiResponse> getTeamOverTime(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getMyTeamOvertime,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<OvertimeTeamListMapper>(OvertimeTeamListMapper.fromJson)).callApi(context);
  }
  Future<ApiResponse> getOvertimeTimeRange(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.overtimeTimeRange,checkTypes: CheckTypes.includeListData,isPost: true,parameters: parameters, type: ClassType<OvertimeTimeRangeModel>(OvertimeTimeRangeModel.fromJson)).callApi(context);
  }

  Future<ApiResponse> applyOvertimeTime(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.overtimeApply,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<OverTimeSubmitModel>(OverTimeSubmitModel.fromJson)).callApi(context);
  }
  Future<ApiResponse> getOvertimeTimeList(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getOvertimeList,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<OvertimeListModel>(OvertimeListModel.fromJson)).callApi(context);
  }
  Future<ApiResponse> getOvertimeDetail(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getOverTimeDetail,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<OvertimeDetailModel>(OvertimeDetailModel.fromJson)).callApi(context);
  }
  Future<ApiResponse> submitShift(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.submitShiftApi,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<OverTimeSubmitModel>(OverTimeSubmitModel.fromJson)).callApi(context);
  }

  Future<ApiResponse> getPlaySlipListRange(BuildContext context,dynamic urlParameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getPayListSlip,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: urlParameters, type: ClassType<GetPaySlipListJson>(GetPaySlipListJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getRequestNameList(BuildContext context)async
  {
    return await CallingDioApis(endPoint: RequestType.requestNameUrl,checkTypes: CheckTypes.includeListData,isPost: false,type: ClassType<GetRequestNamesJson>(GetRequestNamesJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> postApprovalAcceptRejectApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.postApprovalsAcceptReject,checkTypes: CheckTypes.includeEntityData,isPost: false,urlParameters: parameters, type: ClassType<PostApprovalAcceptRejectJson>(PostApprovalAcceptRejectJson.fromJson)).callApi(context);  /// Api Structure not good Ask Ahsan to update
  }
  Future<ApiResponse> getApprovalListApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getApprovals,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<GetApprovalJson>(GetApprovalJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getHolidaysList(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.holidays,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<GetHolidaysJson>(GetHolidaysJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getNotificationList(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getNotificationsUrl,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<NotificationJson>(NotificationJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getPaySlipByMonthApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getPayslip,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<GetPaySlipMonthJson>(GetPaySlipMonthJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getLeaveDetailApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getLeaveDetailUrl,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetLeaveDetailsJson>(GetLeaveDetailsJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getEncashmentDetail(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getEncashmentRequestDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestEncashmentDetailsJson>(GetRequestEncashmentDetailsJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getRequestDetailApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.requestDetailUrl,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestDetailsJson>(GetRequestDetailsJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getRequestFormApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getRequestForm,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestFormJson>(GetRequestFormJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getSeperationRequestDetail(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getSeparationRequestDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestSeparationDetailsJson>(GetRequestSeparationDetailsJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> saveAttendanceApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.saveAttendance,checkTypes: CheckTypes.includeListData,isPost: true,parameters: parameters, type: ClassType<PostAttendanceJson>(PostAttendanceJson.fromJson)).callApi(context);
  }

  Future<ApiResponse> postLanguageApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.updateLanguage,checkTypes: CheckTypes.onlyBool,isPost: true,urlParameters: parameters, type: ClassType<UpdateLanguageJson>(UpdateLanguageJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> postRequestApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.saveRequest,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<PostRequestJson>(PostRequestJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> saveEncashmentRequestApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.saveSpecialRequest,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<PostEncashmentRequestJson>(PostEncashmentRequestJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> saveSeparationRequestApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.saveSeparationRequest,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<SaveSeparationRequestJson>(SaveSeparationRequestJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> getSeparationCalendar(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.saveSeparationCalendar,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<SaveSeparationCalendarRequestJson>(SaveSeparationCalendarRequestJson.fromJson)).callApi(context);
  }
  Future<ApiResponse> postCancelTimeOff(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.cancelTimeOff,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<CancelLeaveJson>(CancelLeaveJson.fromJson)).callApi(context);
  }

  Future<ApiResponse> getShiftListApi(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getShiftListApi,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<ShiftListModel>(ShiftListModel.fromJson)).callApi(context);
  }
  Future<ApiResponse> getOvertimeApprovalDetailsApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getApprovalsDetails,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<OvertimeDetailModel>(OvertimeDetailModel.fromJson)).callApi(context);
  }

  Future<ApiResponse> getShiftDetail(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getShiftDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<ShiftDetailModel>(ShiftDetailModel.fromJson)).callApi(context);
  }
  Future<ApiResponse> getShiftApprovalDetailsApiCall(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getApprovalsDetails,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<ShiftDetailModel>(ShiftDetailModel.fromJson)).callApi(context);
  }


  Future<ApiResponse> getEmployeeLeaveBalance(BuildContext context,dynamic parameters)async
  {
    return await CallingDioApis(endPoint: RequestType.getLeaveBalance,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<GetEmployeeLeaveBalanceModel>(GetEmployeeLeaveBalanceModel.fromJson)).callApi(context);
  }

  Future<ApiResponse> uploadFileApi(BuildContext context,String filePath,String url)async
  {
    String fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath, filename:fileName),
    });
    return await CallingDioApis(endPoint: url,checkTypes: CheckTypes.includeData,isPost: true,parameters: formData, type: ClassType<GetUploadedFileJson>(GetUploadedFileJson.fromJson)).callApi(context);

  }

  // Future<ApiResponse> getSeperationRequestDetail(BuildContext context,dynamic parameters)async
  // {
  //   return await CallingDioApis(endPoint: RequestType.getSeparationRequestDetailApi,checkTypes: CheckTypes.onlyBool,isPost: false,urlParameters: parameters, type: ClassType<GetRequestSeparationDetailsJson>(GetRequestSeparationDetailsJson.fromJson)).callApi(context);
  // }
  // Future<ApiResponse> getSeperationRequestDetail(BuildContext context,dynamic parameters)async
  // {
  //   return await CallingDioApis(endPoint: RequestType.getSeparationRequestDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestSeparationDetailsJson>(GetRequestSeparationDetailsJson.fromJson)).callApi(context);
  // }
  // Future<ApiResponse> getSeperationRequestDetail(BuildContext context,dynamic parameters)async
  // {
  //   return await CallingDioApis(endPoint: RequestType.getSeparationRequestDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestSeparationDetailsJson>(GetRequestSeparationDetailsJson.fromJson)).callApi(context);
  // }
  // Future<ApiResponse> getSeperationRequestDetail(BuildContext context,dynamic parameters)async
  // {
  //   return await CallingDioApis(endPoint: RequestType.getSeparationRequestDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestSeparationDetailsJson>(GetRequestSeparationDetailsJson.fromJson)).callApi(context);
  // }
  // Future<ApiResponse> getSeperationRequestDetail(BuildContext context,dynamic parameters)async
  // {
  //   return await CallingDioApis(endPoint: RequestType.getSeparationRequestDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestSeparationDetailsJson>(GetRequestSeparationDetailsJson.fromJson)).callApi(context);
  // }
  // Future<ApiResponse> getSeperationRequestDetail(BuildContext context,dynamic parameters)async
  // {
  //   return await CallingDioApis(endPoint: RequestType.getSeparationRequestDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestSeparationDetailsJson>(GetRequestSeparationDetailsJson.fromJson)).callApi(context);
  // }
  // Future<ApiResponse> getSeperationRequestDetail(BuildContext context,dynamic parameters)async
  // {
  //   return await CallingDioApis(endPoint: RequestType.getSeparationRequestDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestSeparationDetailsJson>(GetRequestSeparationDetailsJson.fromJson)).callApi(context);
  // }
  // Future<ApiResponse> getSeperationRequestDetail(BuildContext context,dynamic parameters)async
  // {
  //   return await CallingDioApis(endPoint: RequestType.getSeparationRequestDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestSeparationDetailsJson>(GetRequestSeparationDetailsJson.fromJson)).callApi(context);
  // }


  //
  // addSiteNewDataApi(BuildContext context, Map<String, dynamic>? parameters) async {
  //   /// This api get called for two purpose
  //   /// 1 - If user click rejected site on check in page
  //   /// 2 - To submit fresh... brand new.. i mean new site which get called from global listener
  //   return await GetUiApiCaller(endPoint: RequestType.submitNewSiteData,isPost: true,parameters: parameters, type: ClassType<CompanyJson>(CompanyJson.fromJson)SiteInfoUploadModel).callApi(context);
  // }
  //
  // changePasswordApi(BuildContext context, Map<String, dynamic>? parameters) async {
  //   return await GetUiApiCaller(endPoint: RequestType.changePassword,isPost: true,parameters: parameters, type: ClassType<CompanyJson>(CompanyJson.fromJson)ChangePasswordModel).callApi(context);
  // }
}