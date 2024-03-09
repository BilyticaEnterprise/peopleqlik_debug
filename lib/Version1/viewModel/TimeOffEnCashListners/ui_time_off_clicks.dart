import 'package:flutter/cupertino.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/SummaryListeners/get_summary_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/SummaryListeners/leave_calender_model_listener.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/HolidaysListener/get_holiday_list_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveListModule/presentation/listener/time_off_list_collector.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

class TimeOffCurrentPage extends GetChangeNotifier
{
  TimeOffPageEnum timeOffPageEnum = TimeOffPageEnum.timeOff;
  void updatePage(BuildContext context,TimeOffPageEnum timeOffPageEnum)
  {
    this.timeOffPageEnum = timeOffPageEnum;
    notifyListeners();

    if(timeOffPageEnum == TimeOffPageEnum.timeOff)
      {
        Provider.of<TimeOffModelListener>(context,listen: false).start(context,ApiStatus.started);
      }
    else if(timeOffPageEnum == TimeOffPageEnum.summary)
      {
        String? code = Provider.of<LeaveCalenderModelListener>(context,listen: false).getIndexedCalender(0)?.calendarCode;
        Provider.of<LeaveSummaryModelListener>(context,listen: false).start(context, code??'LC${DateTime.now().year}');
      }
    else if(timeOffPageEnum == TimeOffPageEnum.holiday)
    {
      Provider.of<HolidaysModelListener>(context,listen: false).start(context, ApiStatus.started);
    }
  }
}
enum TimeOffPageEnum
{
  timeOff,summary,holiday
}