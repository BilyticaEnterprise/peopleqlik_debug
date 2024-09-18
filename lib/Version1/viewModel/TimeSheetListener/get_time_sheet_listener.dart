import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/models/TimeSheetModel/get_time_sheet_model.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TimeSheet/calender_view.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class GetTimeSheetListener extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  List<TimeSheetResultSet>? timeSheetResultSet;
  List<ForUiDatesList>? forMiddleWidgetUiPerDayDatesList;
  DateTime? callApiDate;
  double totalPresentPercent = 0;
  double totalAbsentPercent = 0;
  CalendarView calendarView = CalendarView.month;
  late BuildContext context;

  setContext(BuildContext context)
  {
    this.context = context;
  }

  void getCurrentMonth(DateTime dateTime)
  {
    callApiDate = dateTime;
    final now = dateTime;
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    start(context, GetDateFormats().getMonthFormatDay(firstDayOfMonth)!, GetDateFormats().getMonthFormatDay(lastDayOfMonth)!,dateTime);
  }
  Future? start(BuildContext context,String fromDate,String toDate,DateTime dateTime)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();
    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getTimeSheetApiCall(context,'?FromDate=$fromDate&ToDate=$toDate&CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      timeSheetResultSet = apiResponse.data!.resultSet;
      timeSheetResultSet = await validateTimeSheetList(timeSheetResultSet,dateTime);
      await getEachMonthDayStatus(timeSheetResultSet,dateTime);
      await calculateTotals();
      apiStatus = ApiStatus.done;
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      apiStatus = ApiStatus.done;
      timeSheetResultSet = List.empty(growable: true);
      await getEachMonthDayStatus(timeSheetResultSet,dateTime);
      await calculateTotals();
      notifyListeners();
    }
    else
    {
      apiStatus = ApiStatus.error;
      timeSheetResultSet = null;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }
  Future<void> calculateTotals()
  async {
    if(timeSheetResultSet!=null&&timeSheetResultSet!.isNotEmpty)
    {
      int total = timeSheetResultSet!.length;
      int present = 0;
      int absent = 0;
      for(int x=0;x<timeSheetResultSet!.length;x++)
      {
        if(timeSheetResultSet?[x].statusID==null||timeSheetResultSet?[x].statusID == GetVariable.absent.toString())
          {
            absent++;
          }
        else
          {
            present++;
          }
      }
      totalPresentPercent = present/total*100;
      totalAbsentPercent = absent/total*100;
    }
    else
      {
        totalPresentPercent = 0;
        totalAbsentPercent = 0;
      }
  }

  validateTimeSheetList(List<TimeSheetResultSet>? timeSheetResultSet, DateTime now) {
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    int firstDay = firstDayOfMonth.day;
    int lastDay = lastDayOfMonth.day;
    List<TimeSheetResultSet>? newTimeSheetResultSet = List.empty(growable: true);

    for(int x=firstDay-1;x<lastDay;x++)
      {
        int? index = timeSheetResultSet?.indexWhere((element) => GetDateFormats().getMonthDay(element.attendanceDate)?.day==(x+1));
        if(index!=null&&index!=-1)
          {
            newTimeSheetResultSet.add(timeSheetResultSet![index]);
          }
        else
          {
            newTimeSheetResultSet.add(TimeSheetResultSet(attendanceDate: GetDateFormats().getMonthDayIntoString(DateTime(now.year, now.month, x+1))));
          }
      }
    return newTimeSheetResultSet;
  }
  Future<void> getEachMonthDayStatus(List<TimeSheetResultSet>? timeSheetResultSet,DateTime now)async
  {
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    final firstDayOfMonth = DateTime(now.year, now.month, 1);

    int firstDay = firstDayOfMonth.day;
    int lastDay = lastDayOfMonth.day;
    forMiddleWidgetUiPerDayDatesList = List.empty(growable: true);
    /// Calculating whole month days and status
    for(int x=firstDay-1;x<lastDay;x++)
      {
        List<String> status;
        try{
          PrintLogs.printLogs('hereIs ${timeSheetResultSet?[x].statusID}');
          status = timeSheetResultSet![x].statusID.toString().split(',');

        }catch(e){
          //PrintLogs.printLogs('helloasd ${timeSheetResultSet![x].statusID}');
        }
        try{
          status = timeSheetResultSet![x].statusID.toString().split(',');
          if(status.length>1)
            {
              forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(GetDateFormats().getMonthDay(timeSheetResultSet[x].attendanceDate), DateType.multiple,const Color(MyColor.colorBlack)));
            }
          else
            {
              int statusNow = int.parse(status.first);
              PrintLogs.printLogs('hellostatusNow ${statusNow}');
              if(statusNow==GetVariable.absent)
              {
                forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(GetDateFormats().getMonthDay(timeSheetResultSet[x].attendanceDate), DateType.absent,const Color(MyColor.colorRed)));
              }
              else if(statusNow==GetVariable.onTime)
              {
                forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(GetDateFormats().getMonthDay(timeSheetResultSet[x].attendanceDate), DateType.present,const Color(MyColor.colorPrimary)));
              }
              else if(statusNow==GetVariable.lateness)
              {
                forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(GetDateFormats().getMonthDay(timeSheetResultSet[x].attendanceDate), DateType.late,const Color(MyColor.colorClockOut)));
              }
              else if(statusNow==GetVariable.missingOut)
              {
                forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(GetDateFormats().getMonthDay(timeSheetResultSet[x].attendanceDate), DateType.leave,const Color(MyColor.colorIndigo)));
              }
              else if(statusNow==GetVariable.missingIn)
              {
                forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(GetDateFormats().getMonthDay(timeSheetResultSet[x].attendanceDate), DateType.missingIn,const Color(MyColor.colorClockIn)));
              }
              else if(statusNow==GetVariable.missingShift)
              {
                forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(GetDateFormats().getMonthDay(timeSheetResultSet[x].attendanceDate), DateType.missingOut,const Color(MyColor.colorClockIn)));
              }
              else if(statusNow==GetVariable.earlyOut)
              {
                forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(GetDateFormats().getMonthDay(timeSheetResultSet[x].attendanceDate), DateType.earlyOut,const Color(MyColor.colorT7)));
              }
              else if(statusNow == GetVariable.publicHoliday)
              {
                forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(GetDateFormats().getMonthDay(timeSheetResultSet[x].attendanceDate), DateType.publicHoliday,const Color(MyColor.colorSecondary)));
              }
              else if(statusNow == GetVariable.weekEnd)
              {
                forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(GetDateFormats().getMonthDay(timeSheetResultSet[x].attendanceDate), DateType.weekend,const Color(MyColor.colorWhite)));
              }
              else
              {
                forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(GetDateFormats().getMonthDay(timeSheetResultSet[x].attendanceDate), DateType.unKnown,const Color(MyColor.colorPrimary)));
              }
            }

        }catch(e)
        {
          forMiddleWidgetUiPerDayDatesList?.add(ForUiDatesList(DateTime(now.year, now.month, x+1), DateType.futureDay,const Color(MyColor.colorTransparent)));
        }

      }
    notifyListeners();
    return;
  }

  void previousMonthButton() {
     final lastDayOfMonth = DateTime(callApiDate!.year, callApiDate!.month + 1, 0);
     final firstDayOfMonth = DateTime(callApiDate!.year, callApiDate!.month, 1);
     // Jiffy();
    // Jiffy dat = ;
    DateTime dateTime = Jiffy.parseFromMap({Unit.year: callApiDate!.year, Unit.month: callApiDate!.month, Unit.day: lastDayOfMonth.day}).subtract(months: 1).dateTime;
    callApiDate = dateTime;
    getCurrentMonth(callApiDate!);
    print(callApiDate);
  }
  void updateCurrentMonth(DateTime time)
  {
    callApiDate = time;
    getCurrentMonth(callApiDate!);
  }

  void nextMonthButton() {
    final lastDayOfMonth = DateTime(callApiDate!.year, callApiDate!.month + 1, 0);
    final firstDayOfMonth = DateTime(callApiDate!.year, callApiDate!.month, 1);
    Jiffy dat = Jiffy.parseFromMap({Unit.year: callApiDate!.year, Unit.month: callApiDate!.month, Unit.day:lastDayOfMonth.day}).add(months: 1);
    DateTime dateTime = dat.dateTime;
    callApiDate = dateTime;
    getCurrentMonth(callApiDate!);

  }

}
enum CalendarView
{
  month,weekly
}

class ShowDataAgainstEachDay extends GetChangeNotifier
{
  int selectedIndex = 0;
  updateIndex(int index)
  {
    selectedIndex = index;
    notifyListeners();
  }
}