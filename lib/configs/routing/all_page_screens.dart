import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/BasicProfileEditModule/presentation/ui/basic_profile_edit_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/CompensationEditModule/presentation/ui/compensation_edit_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/ExperienceEditModule/presentation/ui/experience_edit_page.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/FamilyEditModule/presentation/ui/family_edit_module.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';

import '../../Version1/views/AuthPages/company_name.dart';
import '../../Version1/views/AuthPages/login_page.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/AccountSettingModule/presentation/ui/AccountSettingPages/change_company_page.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/AccountSettingModule/presentation/ui/account_setting_page.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/ChangePasswordModule/presentation/ui/create_new_password_page.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/ChangePasswordModule/presentation/ui/check_current_password.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/LanguageChangeModule/presentation/ui/language_page.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/PoliciesURLModule/presentation/ui/policies_page.dart';
import '../../Version1/views/BottomBarPages/Announcements/announcement_detail_page.dart';
import '../../Version1/views/BottomBarPages/Notifications/notification_detail.dart';
import '../../Version1/views/BottomBarPages/Notifications/notification_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_encashment_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_rejection_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_separation_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_time_regulation_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_appceptance_leave_request_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_overtime_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_shift_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/approvals_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/PayslipPages/paslip_list_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/PayslipPages/payslip_month_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/EncashmentRequestLeaveEncashment/request_encashment_detail_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/EncashmentRequestLeaveEncashment/request_encashment_form_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/EncashmentRequestLeaveEncashment/request_encashment_list_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/OverTimeDashBoardTeamRequest/overtime_team_request_list_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/OvertimeFormPages/overtime_form_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/UiWidgets/overtime_detail_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/overtime_list_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/PerformanceWebView/performance_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/RequestSubPages/request_add_form_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/RequestSubPages/request_list_sub_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/SeperationRequestPages/request_separation_detail_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/SeperationRequestPages/request_separation_form_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/SeperationRequestPages/request_separation_list_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/SeperationRequestPages/separation_calendar_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/ShiftPages/ShiftFormPages/shift_form_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/ShiftPages/ShiftListPages/shift_detail_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/ShiftPages/ShiftListPages/shift_list_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/MovementSlipForm/movement_slip_form_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/TimeRegulationFormPage/TimeRegulationFetchDateListPages/time_regulation_fetch_date_list_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/TimeRegulationFormPage/TimeRegulationFormPages/time_regulation_form_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/time_regulation_detail_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/time_regulation_list_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/RequestSubPages/request_detail_page.dart';
import '../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/request_main_page.dart';
import '../../Version1/views/BottomBarPages/TeamPages/TeamDetails/leave_balance_page.dart';
import '../../Version1/views/BottomBarPages/TeamPages/TeamDetails/team_detail_page.dart';
import '../../Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/ui/add_edit_time_off_form_page.dart';
import '../../Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/presentation/ui/time_off_detail_page.dart';
import '../../Version1/views/BottomBarPages/TimeOffPage/time_off_main_page.dart';
import '../../Version1/views/BottomBarPages/TimeSheet/time_sheet_page.dart';
import '../../utils/cached_image_getter/image_zoom.dart';
import '../../Version1/views/main_bottombar_page.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/ContactEditModule/presentation/ui/contact_edit_page.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/DocumentEditModule/presentation/ui/document_edit_page.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/LanguageEditModule/presentation/ui/language_edit_page.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/PaymentEditModule/presentation/ui/payment_edit_page.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/QualificationEditModule/presentation/ui/qualification_edit_page.dart';
import '../../Version2/Modules/AccountModule/AccountSubModules/ProfileModule/presentation/ui/profile_page.dart';
import '../../Version2/Modules/DashBoardModule/SubModules/AttendanceSummaryModule/presentation/ui/attendance_summary_page.dart';
import '../../Version2/Modules/DashBoardModule/SubModules/DocumentModule/presentation/ui/document_main_page.dart';
import '../../Version2/Modules/DashBoardModule/SubModules/TodoModule/presentation/ui/todo_main_page.dart';
import '../../Version2/Modules/MobileBlockingModule/presentation/ui/mobile_blocking_page.dart';
import '../../Version2/Modules/MobileBlockingModule/presentation/ui/mobile_register_view/views/inactive_and_register_page.dart';
import '../../Version2/Modules/MobileBlockingModule/presentation/ui/mobile_register_view/views/register_mobile_page.dart';
import '../../Version2/Modules/NotificationPermissionSettingModule/presentation/ui/notification_settings_page.dart';
import '../../mainCommon.dart';
import '../../Version2/Modules/ModuleSetting/ui/settings.dart';


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
  CurrentPage.RequestEncashmentListPage: (context) => RequestEncashmentListPage(),
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
  CurrentPage.leaveBalancePage: (context) => LeaveBalancePage(),
  CurrentPage.mobileBlockingPage: (context) => MobileBlockingPage(),
  CurrentPage.registerMobilePage: (context) => RegisterMobilePage(),
  CurrentPage.inActiveAndRegisterPage: (context) => InActiveAndRegisterPage(),
  CurrentPage.notificationPermissionSettings: (context) => NotificationPermissionSettings(),
  CurrentPage.userProfilePage: (context) => UserProfilePage(),
  CurrentPage.basicProfileEditPage: (context) => BasicProfileEditPage(),
  CurrentPage.compensationEditPage: (context) => CompensationEditPage(),
  CurrentPage.paymentEditPage: (context) => PaymentEditPage(),
  CurrentPage.contactEditPage: (context) => ContactEditPage(),
  CurrentPage.qualificationEditPage: (context) => QualificationEditPage(),
  CurrentPage.experienceEditPage: (context) => ExperienceEditPage(),
  CurrentPage.documentEditPage: (context) => DocumentEditPage(),
  CurrentPage.familyEditPage: (context) => FamilyEditPage(),
  CurrentPage.languageEditPage: (context) => LanguageEditPage(),
  CurrentPage.checkCurrentPasswordPage: (context) => CheckCurrentPasswordPage(),
  CurrentPage.createNewPasswordPage: (context) => CreateNewPasswordPage(),
  CurrentPage.documentMainPage: (context) => DocumentMainPage(),
  CurrentPage.todoMainPage: (context) => TodoMainPage(),
  CurrentPage.attendanceSummaryPage: (context) => AttendanceSummaryPage()
};