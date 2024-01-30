import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';

import '../../UiPages/AuthPages/company_name.dart';
import '../../UiPages/AuthPages/login_page.dart';
import '../../UiPages/BottomBarPages/Account/AccountSettings/AccountSettingPages/change_company_page.dart';
import '../../UiPages/BottomBarPages/Account/AccountSettings/account_setting_page.dart';
import '../../UiPages/BottomBarPages/Account/language_page.dart';
import '../../UiPages/BottomBarPages/Account/policies_page.dart';
import '../../UiPages/BottomBarPages/Announcements/announcement_detail_page.dart';
import '../../UiPages/BottomBarPages/Notifications/notification_detail.dart';
import '../../UiPages/BottomBarPages/Notifications/notification_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_encashment_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_rejection_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_separation_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_time_regulation_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_appceptance_leave_request_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_overtime_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_shift_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/approvals_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/PayslipPages/paslip_list_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/PayslipPages/payslip_month_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/EncashmentRequestLeaveEncashment/request_encashment_detail_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/EncashmentRequestLeaveEncashment/request_encashment_form_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/EncashmentRequestLeaveEncashment/request_encashment_list_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/OverTimeDashBoardTeamRequest/overtime_team_request_list_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/OvertimeFormPages/overtime_form_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/UiWidgets/overtime_detail_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/overtime_list_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/PerformanceWebView/performance_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/RequestSubPages/request_add_form_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/RequestSubPages/request_list_sub_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/SeperationRequestPages/request_separation_detail_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/SeperationRequestPages/request_separation_form_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/SeperationRequestPages/request_separation_list_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/SeperationRequestPages/separation_calendar_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/ShiftPages/ShiftFormPages/shift_form_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/ShiftPages/ShiftListPages/shift_detail_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/ShiftPages/ShiftListPages/shift_list_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/MovementSlipForm/movement_slip_form_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/TimeRegulationFormPage/TimeRegulationFetchDateListPages/time_regulation_fetch_date_list_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/TimeRegulationFormPage/TimeRegulationFormPages/time_regulation_form_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/time_regulation_detail_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/time_regulation_list_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/request_detail_page.dart';
import '../../UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/request_main_page.dart';
import '../../UiPages/BottomBarPages/TeamPages/TeamDetails/leave_balance_page.dart';
import '../../UiPages/BottomBarPages/TeamPages/TeamDetails/team_detail_page.dart';
import '../../UiPages/BottomBarPages/TimeOffPage/TimeOffSubPages/AddEditTimeOffPages/add_edit_time_off_form_page.dart';
import '../../UiPages/BottomBarPages/TimeOffPage/TimeOffSubPages/time_off_detail_page.dart';
import '../../UiPages/BottomBarPages/TimeOffPage/time_off_main_page.dart';
import '../../UiPages/BottomBarPages/TimeSheet/time_sheet_page.dart';
import '../../UiPages/Reuse_Widgets/image_zoom.dart';
import '../../UiPages/main_bottombar_page.dart';
import '../../mainCommon.dart';
import '../../UiPages/SettingPages/settings.dart';


getScreens()
{
  return routes;
}
var routes = {
  '/':(BuildContext context) => const MyHomePage(),
  CurrentPage.MainBottomBarPage: (BuildContext context) => const MainBottomBarPage(),
  CurrentPage.TimeOffPage: (context) => TimeOffPage(),
  CurrentPage.CompanyPage: (context) => const CompanyPage(),
  CurrentPage.NotificationPage: (context) => const NotificationPage(),
  CurrentPage.LoginPage: (context) => const LoginPage(),
  CurrentPage.TimeOffAddEdit: (context) => TimeOffAddEdit(),
  CurrentPage.ApprovalRequestFormPage: (context) => ApprovalRequestFormPage(),
  CurrentPage.ApprovalPage: (context) => const ApprovalPage(),
  CurrentPage.RequestPage: (context) => const RequestPage(),
  CurrentPage.RequestListSubPage: (context) => RequestListSubPage(),
  CurrentPage.RequestAddFormPage: (context) => RequestAddFormPage(),
  CurrentPage.PayslipPage: (context) => const PayslipPage(),
  CurrentPage.PaySlipMonthPage: (context) => PaySlipMonthPage(),
  CurrentPage.SettingsPage: (context) => const SettingsPage(),
  CurrentPage.AnnouncementDetailPage: (context) => AnnouncementDetailPage(),
  CurrentPage.ApprovalAcceptanceRejectionPage: (context) => const ApprovalAcceptanceRejectionPage(),
  CurrentPage.LanguagePage: (context) => const LanguagePage(),
  CurrentPage.ProductImageZoom: (context) => ProductImageZoom(),
  CurrentPage.RequestDetailPage: (context) => RequestDetailPage(),
  CurrentPage.TimeOffDetailPage: (context) => TimeOffDetailPage(),
  CurrentPage.PolicyPage: (context) => PolicyPage(),
  CurrentPage.NotificationDetailPage: (context) => NotificationDetailPage(),
  CurrentPage.TimeSheetPage: (context) => TimeSheetPage(),
  CurrentPage.AccountSettingPage: (context) => const AccountSettingPage(),
  CurrentPage.RequestSpecialFormPage: (context) => RequestEncashmentFormPage(),
  CurrentPage.RequestSpecialListPage: (context) => RequestEncashmentListPage(),
  CurrentPage.RequestSeperationPage: (context) => RequestSeparationPage(),
  CurrentPage.RequestSeparationFormPage: (context) => RequestSeparationFormPage(),
  CurrentPage.RequestSeparationDetailPage: (context) => RequestSeparationDetailPage(),
  CurrentPage.RequestEncashmentDetailPage: (context) => RequestEncashmentDetailPage(),
  CurrentPage.ApprovalAcceptanceRejectionEncashmentPage: (context) => ApprovalAcceptanceRejectionEncashmentPage(),
  CurrentPage.ApprovalAcceptanceRejectionSeparationPage: (context) => ApprovalAcceptanceRejectionSeparationPage(),
  CurrentPage.SeparationCalendarPage: (context) => SeparationCalendarPage(),
  CurrentPage.TeamDetailPage: (context) => TeamDetailPage(),
  CurrentPage.TimeRegulationListPage: (context) => TimeRegulationListPage(),
  CurrentPage.MoveSlipFormPage: (context) => MoveSlipFormPage(),
  CurrentPage.TimeRegulationFetchDateListPage: (context) => TimeRegulationFetchDateListPage(),
  CurrentPage.TimeRegulationFormPage: (context) => TimeRegulationFormPage(),
  CurrentPage.AcceptanceTimeRegulationPage: (context) => AcceptanceTimeRegulationPage(),
  CurrentPage.TimeRegulationDetailPage: (context) => TimeRegulationDetailPage(),
  CurrentPage.OverTimeTeamRequestPage: (context) => OverTimeTeamRequestPage(),
  CurrentPage.OverTimeListPage: (context) => OverTimeListPage(),
  CurrentPage.OverTimeFormPage: (context) => OverTimeFormPage(),
  CurrentPage.ShiftListPage: (context) => ShiftListPage(),
  CurrentPage.ShiftFormPage: (context) => ShiftFormPage(),
  CurrentPage.ChangeCompanyPage: (context) => ChangeCompanyPage(),
  CurrentPage.OvertimeDetailPage: (context) => OvertimeDetailPage(),
  CurrentPage.ApprovalOvertimeDetailPage: (context) => ApprovalOvertimeDetailPage(),
  CurrentPage.ShiftDetailPage: (context) => ShiftDetailPage(),
  CurrentPage.ApprovalShiftDetailPage: (context) => ApprovalShiftDetailPage(),
  CurrentPage.PerformancePage: (context) => PerformancePage(),
  CurrentPage.leaveBalancePage: (context) => LeaveBalancePage()
};