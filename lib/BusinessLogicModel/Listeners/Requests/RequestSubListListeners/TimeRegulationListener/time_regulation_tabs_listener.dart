// import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
// import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/TimeRegulationListWidgets/attendance_missing.dart';
// import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/TimeRegulationListWidgets/office_permission.dart';
// import 'package:peopleqlik_debug/src/prints_logs.dart';
//
// class TimeRegulationTabsListener extends GetChangeNotifier
// {
//   List<String> tabHeaders = ['Attendance Missing','Office Permission'];
//   int? selectedPageIndex;
//   var pages = [AttendanceMissing(),OfficePermission()];
//   TimeRegulationTabsListener({this.selectedPageIndex = 0});
//   void selectedPage(int selectedPageIndex)
//   {
//     PrintLogs.printLogs('indeabsdas $selectedPageIndex');
//     this.selectedPageIndex = selectedPageIndex;
//     notifyListeners();
//   }
// }