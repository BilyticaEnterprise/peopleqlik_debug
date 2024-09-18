import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/repo/api_client_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/time_off_cancel_model.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import '../../../DashBoardModule/data/model/attendance_model.dart';
import '../../../MobileBlockingModule/domain/models/mobile_update_reject_model.dart';
import '../../../NotificationPermissionSettingModule/domain/models/notification_permission_get_model.dart';
import '../../../DashBoardModule/data/model/dashboard_attendance_model.dart';
import '../../../../../Version1/models/AuthModels/company_url_get_model.dart';
import '../../../../../Version1/models/AuthModels/cookie_model.dart';
import '../../../../../Version1/models/AuthModels/login_model.dart';
import '../../../../../Version1/models/FCMModels/fcm_result_model.dart';
import '../../../../../Version1/models/Language/update_language_model.dart';
import '../../../../../Version1/models/Notifications/announcement_detail_model.dart';
import '../../../../../Version1/models/Notifications/announcement_list_model.dart';
import '../../../../../Version1/models/RequestsModel/EncashmentsModels/get_request_encashment_balance_model.dart';
import '../../../../../Version1/models/RequestsModel/EncashmentsModels/get_request_encashment_list_model.dart';
import '../../../../../Version1/models/RequestsModel/get_request_form_data.dart';
import '../../../../../Version1/models/RequestsModel/get_request_list_model.dart';
import '../../../../../Version1/models/RequestsModel/get_request_name_model.dart';
import '../../../../../Version1/models/RequestsModel/get_request_separation_detail_model.dart';
import '../../../../../Version1/models/RequestsModel/get_request_separation_form_model.dart';
import '../../../../../Version1/models/RequestsModel/get_request_separation_list_model.dart';
import '../../../../../Version1/models/RequestsModel/post_encashment_request_model.dart';
import '../../../../../Version1/models/RequestsModel/post_request_model.dart';
import '../../../../../Version1/models/RequestsModel/post_separation_from_model.dart';
import '../../../../../Version1/models/RequestsModel/save_request_separation_calendar_model.dart';
import '../../../../../Version1/models/ApprovalsModel/get_approvals_detail_model.dart';
import '../../../../../Version1/models/ApprovalsModel/get_approvals_list.dart';
import '../../../../../Version1/models/PaysSlipApprovalsRequest/get_payslip_list.dart';
import '../../../../../Version1/models/PaysSlipApprovalsRequest/get_payslip_month.dart';
import '../../../../../Version1/models/RequestsModel/EncashmentsModels/get_request_encashment_detail_model.dart';
import '../../../../../Version1/models/ApprovalsModel/post_approval_model.dart';
import '../../../../../Version1/models/PaysSlipApprovalsRequest/request_list_form_model.dart';
import '../../../../../Version1/models/TeamModel/get_team_model.dart';
import '../../../../../Version1/models/TeamModel/leave_balance_model.dart';
import '../../../../../Version1/models/TimeOffAndEnCashModel/apply_leave_model.dart';
import '../../../../../Version1/models/TimeOffAndEnCashModel/get_holidays_model.dart';
import '../../../../../Version1/models/TimeOffAndEnCashModel/leave_summary_model.dart';
import '../../../../../Version1/models/TimeOffAndEnCashModel/overtime_detail_model.dart';
import '../../../../../Version1/models/TimeOffAndEnCashModel/overtime_list_model.dart';
import '../../../../../Version1/models/TimeOffAndEnCashModel/overtime_submit_model.dart';
import '../../../../../Version1/models/TimeOffAndEnCashModel/overtime_team_model.dart';
import '../../../../../Version1/models/TimeOffAndEnCashModel/overtime_time_range_model.dart';
import '../../../../../Version1/models/TimeOffAndEnCashModel/shift_detail_model.dart';
import '../../../../../Version1/models/TimeOffAndEnCashModel/shift_list_model.dart';
import '../../../ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_get_form_mapper.dart';
import '../../../ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_leave_balance.dart';
import '../../../ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_model.dart';
import '../../../../../Version1/models/TimeRegulationModels/date_select_movement_slip_model.dart';
// import '../../../../../Version1/models/TimeRegulationModels/time_regulation_movement_detail_model.dart';
import '../../../../../Version1/models/TimeRegulationModels/time_regulation_model.dart';
import '../../../../../Version1/models/TimeRegulationModels/time_regulation_monthly_model.dart';
import '../../../../../Version1/models/TimeRegulationModels/time_regulation_movement_submitted_model.dart';
import '../../../../../Version1/models/TimeSheetModel/get_time_sheet_model.dart';
import '../../../ModuleSetting/domain/model/settings_model.dart';
import '../../../../../Version1/models/uploaded_file_model.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import '../model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import '../../utils/check_type_enums.dart';
import '../model/model_decider.dart';

class UseCaseGetApisUrlCaller
{
  Future<ApiResponse> getCompanyApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,baseUrl: RequestType.firstUrl,endPoint: '',checkTypes: CheckTypes.includeData,isPost: false,authHeaders: false,urlParameters: parameters,checkCookies: false, type: ClassType<CompanyJson>(CompanyJson.fromJson));
  }
  Future<ApiResponse> getLoginApi(BuildContext context,dynamic parameters)async
  {
    ApiResponse apiResponse =  await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.loginUrl,checkTypes: CheckTypes.includeData,isPost: false,authHeaders: false,urlParameters: parameters,checkCookies: false, type: ClassType<LoginJson>(LoginJson.fromJson));
    return apiResponse;
  }
  Future<ApiResponse> getCookieToken(BuildContext context)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.cookieCall,authHeaders: false,checkTypes: CheckTypes.cookie,isPost: false,checkCookies: false, type: ClassType<CookieJson>(CookieJson.fromJson));
  }

  Future<ApiResponse> getSettingDataApi(BuildContext context,{dynamic header})async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.settingsApi,isPost: false,headers: header,checkTypes: CheckTypes.includeData, type: ClassType<GetSettingsJson>(GetSettingsJson.fromJson));
  }

  Future<ApiResponse> postLeaveApiApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.applyLeaveUrl,isPost: true,parameters: parameters,checkTypes: CheckTypes.onlyBool, type: ClassType<LeaveApplyJson>(LeaveApplyJson.fromJson));
  }

  //
  Future<ApiResponse> getAnnouncementDetailApiCall(BuildContext context,dynamic urlParameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getAnnouncementDetail,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: urlParameters, type: ClassType<GetAnnouncementDetailJson>(GetAnnouncementDetailJson.fromJson));
  }
  Future<ApiResponse> getAnnouncementListApiCall(BuildContext context)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getAnnouncementList,checkTypes: CheckTypes.includeData,isPost: false, type: ClassType<GetAnnouncementListJson>(GetAnnouncementListJson.fromJson));
  }
  Future<ApiResponse> getDashboardApiCall(BuildContext context)async
  {
    LoginResultSet? loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getDashboard,checkTypes: CheckTypes.includeData,urlParameters: '?CompanyCode=${loginResultSet.headerInfo?.companyCode}&EmployeeCode=${loginResultSet.headerInfo?.employeeCode}',isPost: false, type: ClassType<GetDashBoardJson>(GetDashBoardJson.fromJson));
  }

  Future<ApiResponse> getTeamApiCall(BuildContext context,int page,String? searchText)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.teamApi,checkTypes: CheckTypes.includeListInsideData,urlParameters: '?Name=${searchText??''}&PageNo=$page&PerPage=10',isPost: false, type: ClassType<GetTeamJson>(GetTeamJson.fromJson));
  }
  Future<ApiResponse> getOverTimeTeamApiCall(BuildContext context,int page,String? searchText,int? typeId)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getEmployeeOverTime,checkTypes: CheckTypes.includeListInsideData,urlParameters: '?Name=${searchText??''}&PageNo=$page&PerPage=10&TypeID=$typeId',isPost: false, type: ClassType<GetTeamJson>(GetTeamJson.fromJson));
  }
  Future<ApiResponse> getTimeRegulationOfficeApiCall(BuildContext context,int page,{required dynamic employeeCode,required dynamic companyCode,required dynamic typeId})async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.timeRegulation,checkTypes: CheckTypes.includeListInsideData,urlParameters: '?PageNo=$page&PerPage=10&CompanyCode=$companyCode&EmployeeCode=$employeeCode&TypeID=$typeId',isPost: false, type: ClassType<TimeRegulationListModel>(TimeRegulationListModel.fromJson));
  }
  Future<ApiResponse> getMovementSlipDataAgainstDateApiCall(BuildContext context,dynamic urlParameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.dateSelectMovementSlip,checkTypes: CheckTypes.includeListData,urlParameters: urlParameters,isPost: false, type: ClassType<DateSelectMovementSlipModel>(DateSelectMovementSlipModel.fromJson));
  }
  Future<ApiResponse> postMovementSlipApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.submitMovementSlip,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<TimeRegulationAndMovementSubmittedModel>(TimeRegulationAndMovementSubmittedModel.fromJson));
  }
  Future<ApiResponse> getMonthlyTimeRegulationApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getMonthlyTimeRegulationListApi,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<TimeRegulationMonthlyModel>(TimeRegulationMonthlyModel.fromJson));
  }

  Future<ApiResponse> getApprovalDetailsApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getApprovalsDetails,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetApprovalDetailJson>(GetApprovalDetailJson.fromJson));
  }
  // Future<ApiResponse> getTimeRegularizationApprovalDetailsApiCall(BuildContext context,dynamic parameters)async
  // {
  //   return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getApprovalsDetails,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<TimeRegulationApprovalDetailModel>(TimeRegulationApprovalDetailModel.fromJson));
  // }

  ///
  Future<ApiResponse> getRequestListApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getRequestList,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestListsJson>(GetRequestListsJson.fromJson));
  }
  Future<ApiResponse> getEncashmentListApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getSpecialRequestList,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<GetEncashmentRequestListsJson>(GetEncashmentRequestListsJson.fromJson));
  }
  Future<ApiResponse> getSeparationListApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getSeparationRequestList,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<GetSeparationRequestListsJson>(GetSeparationRequestListsJson.fromJson));
  }
  Future<ApiResponse> getTimeSheetApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getTimeSheet,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<GetTimeSheetJson>(GetTimeSheetJson.fromJson));
  }
  Future<ApiResponse> getTimeOffListApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.timeOff,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<TimeOffJson>(TimeOffJson.fromJson));
  }
  Future<ApiResponse> getSeparationEmployeeFormApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getSeparationRequestApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetSeparationEmployeeListJson>(GetSeparationEmployeeListJson.fromJson));
  }
  Future<ApiResponse> getLeaveFormDataApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getLeaveFormDataUrl,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<LeaveCreateFormJson>(LeaveCreateFormJson.fromJson));
  }
  Future<ApiResponse> getLeaveSummaryApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getLeaveSummaryUrl,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<LeaveSummaryJson>(LeaveSummaryJson.fromJson));
  }
  Future<ApiResponse> getLeaveBalanceApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getLeaveBalanceUrl,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetLeaveBalanceJson>(GetLeaveBalanceJson.fromJson));
  }
  Future<ApiResponse> getEncashmentRequestFormApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getSpecialRequestForm,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetSpecialRequestFormJson>(GetSpecialRequestFormJson.fromJson));
  }
  Future<ApiResponse> getEncashmentBalanceFormApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getSpecialRequestBalance,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<GetEncashmentRequestBalanceJson>(GetEncashmentRequestBalanceJson.fromJson));
  }
  // Future<ApiResponse> getTimeRegulationDetailsApiCall(BuildContext context,dynamic parameters)async
  // {
  //   return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getTimeRegulationDetails,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<TimeRegulationDetailsModel>(TimeRegulationDetailsModel.fromJson));
  // }
  Future<ApiResponse> getTeamOverTime(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getMyTeamOvertime,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<OvertimeTeamListMapper>(OvertimeTeamListMapper.fromJson));
  }
  Future<ApiResponse> getOvertimeTimeRange(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.overtimeTimeRange,checkTypes: CheckTypes.includeListData,isPost: true,parameters: parameters, type: ClassType<OvertimeTimeRangeModel>(OvertimeTimeRangeModel.fromJson));
  }

  Future<ApiResponse> applyOvertimeTime(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.overtimeApply,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<OverTimeSubmitModel>(OverTimeSubmitModel.fromJson));
  }
  Future<ApiResponse> getOvertimeTimeList(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getOvertimeList,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<OvertimeListModel>(OvertimeListModel.fromJson));
  }
  Future<ApiResponse> getOvertimeDetail(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getOverTimeDetail,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<OvertimeDetailModel>(OvertimeDetailModel.fromJson));
  }
  Future<ApiResponse> submitShift(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.submitShiftApi,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<OverTimeSubmitModel>(OverTimeSubmitModel.fromJson));
  }

  Future<ApiResponse> getPlaySlipListRange(BuildContext context,dynamic urlParameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getPayListSlip,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: urlParameters, type: ClassType<GetPaySlipListJson>(GetPaySlipListJson.fromJson));
  }
  Future<ApiResponse> getRequestNameList(BuildContext context)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.requestNameUrl,checkTypes: CheckTypes.includeListData,isPost: false,type: ClassType<GetRequestNamesJson>(GetRequestNamesJson.fromJson));
  }
  Future<ApiResponse> postApprovalAcceptRejectApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.postApprovalsAcceptReject,checkTypes: CheckTypes.includeEntityData,isPost: false,urlParameters: parameters, type: ClassType<PostApprovalAcceptRejectJson>(PostApprovalAcceptRejectJson.fromJson));  /// Api Structure not good Ask Ahsan to update
  }
  Future<ApiResponse> getApprovalListApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getApprovals,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<GetApprovalJson>(GetApprovalJson.fromJson));
  }
  Future<ApiResponse> getHolidaysList(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.holidays,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<GetHolidaysJson>(GetHolidaysJson.fromJson));
  }
  // Future<ApiResponse> getNotificationList(BuildContext context,dynamic parameters)async
  // {
  //   return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getNotificationsUrl,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<NotificationJson>(NotificationJson.fromJson));
  // }
  Future<ApiResponse> getPaySlipByMonthApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getPayslip,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<GetPaySlipMonthJson>(GetPaySlipMonthJson.fromJson));
  }
  // Future<ApiResponse> getLeaveDetailApi(BuildContext context,dynamic parameters)async
  // {
  //   return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getLeaveDetailUrl,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetLeaveDetailsJson>(GetLeaveDetailsJson.fromJson));
  // }
  Future<ApiResponse> getEncashmentDetail(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getEncashmentRequestDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestEncashmentDetailsJson>(GetRequestEncashmentDetailsJson.fromJson));
  }
  // Future<ApiResponse> getRequestDetailApi(BuildContext context,dynamic parameters)async
  // {
  //   return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.requestDetailUrl,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestDetailsJson>(GetRequestDetailsJson.fromJson));
  // }
  Future<ApiResponse> getRequestFormApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getRequestForm,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestFormJson>(GetRequestFormJson.fromJson));
  }
  Future<ApiResponse> getSeperationRequestDetail(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getSeparationRequestDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<GetRequestSeparationDetailsJson>(GetRequestSeparationDetailsJson.fromJson));
  }
  Future<ApiResponse> saveAttendanceApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.saveAttendance,checkTypes: CheckTypes.includeListData,isPost: true,parameters: parameters, type: ClassType<PostAttendanceJson>(PostAttendanceJson.fromJson));
  }

  Future<ApiResponse> postLanguageApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.updateLanguage,checkTypes: CheckTypes.onlyBool,isPost: true,urlParameters: parameters, type: ClassType<UpdateLanguageJson>(UpdateLanguageJson.fromJson));
  }
  Future<ApiResponse> postRequestApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.saveRequest,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<PostRequestJson>(PostRequestJson.fromJson));
  }
  Future<ApiResponse> saveEncashmentRequestApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.saveSpecialRequest,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<PostEncashmentRequestJson>(PostEncashmentRequestJson.fromJson));
  }
  Future<ApiResponse> saveSeparationRequestApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.saveSeparationRequest,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<SaveSeparationRequestJson>(SaveSeparationRequestJson.fromJson));
  }
  Future<ApiResponse> getSeparationCalendar(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.saveSeparationCalendar,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<SaveSeparationCalendarRequestJson>(SaveSeparationCalendarRequestJson.fromJson));
  }
  Future<ApiResponse> postCancelTimeOff(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.cancelTimeOff,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<CancelLeaveJson>(CancelLeaveJson.fromJson));
  }

  Future<ApiResponse> getShiftListApi(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getShiftListApi,checkTypes: CheckTypes.includeListInsideData,isPost: false,urlParameters: parameters, type: ClassType<ShiftListModel>(ShiftListModel.fromJson));
  }
  Future<ApiResponse> getOvertimeApprovalDetailsApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getApprovalsDetails,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<OvertimeDetailModel>(OvertimeDetailModel.fromJson));
  }

  Future<ApiResponse> getShiftDetail(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getShiftDetailApi,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<ShiftDetailModel>(ShiftDetailModel.fromJson));
  }
  Future<ApiResponse> getShiftApprovalDetailsApiCall(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getApprovalsDetails,checkTypes: CheckTypes.includeData,isPost: false,urlParameters: parameters, type: ClassType<ShiftDetailModel>(ShiftDetailModel.fromJson));
  }


  Future<ApiResponse> getEmployeeLeaveBalance(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getLeaveBalance,checkTypes: CheckTypes.includeListData,isPost: false,urlParameters: parameters, type: ClassType<GetEmployeeLeaveBalanceModel>(GetEmployeeLeaveBalanceModel.fromJson));
  }

  Future<ApiResponse> uploadFileApi(BuildContext context,String filePath,String url)async
  {
    String fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath, filename:fileName),
    });
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: url,checkTypes: CheckTypes.includeData,isPost: true,parameters: formData, type: ClassType<GetUploadedFileJson>(GetUploadedFileJson.fromJson));

  }

  Future<ApiResponse> postMobileDeviceAddUpdate(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.mobileDeviceAddUpdate,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<MobileDeviceAddUpdateModel>(MobileDeviceAddUpdateModel.fromJson));
  }

  Future<ApiResponse> postFCMToken(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.fcmTokenUpdate,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<FCMResultModel>(FCMResultModel.fromJson));
  }

  Future<ApiResponse> getFCMTokenSetting(BuildContext context)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.getNotificationSettings,checkTypes: CheckTypes.includeData,isPost: false, type: ClassType<NotificationPermissionModel>(NotificationPermissionModel.fromJson));
  }

  Future<ApiResponse> postFCMTokenSetting(BuildContext context,dynamic parameters)async
  {
    return await GlobalApiCallerRepo.instance.callApi(context,endPoint: RequestType.postNotificationSettings,checkTypes: CheckTypes.onlyBool,isPost: true,parameters: parameters, type: ClassType<NotificationPermissionModel>(NotificationPermissionModel.fromJson));
  }

}