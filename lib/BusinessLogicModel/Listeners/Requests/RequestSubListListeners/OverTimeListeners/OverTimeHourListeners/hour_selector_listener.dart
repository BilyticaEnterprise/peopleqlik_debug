import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/overtime_filter_mapper.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/overtime_time_range_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';

import '../../../../../../UiPages/Reuse_Widgets/DatePickText/date_picker_text_style_1.dart';
import '../../../../../Models/TimeOffAndEnCashModel/overtime_hour_mapper.dart';

class HourSelectorListener extends GetChangeNotifier
{
  List<EmployeeDateTimeList> selectedOvertimeTimeList;
  List<DateController>? dateControllerList;
  List<bool>? enabledList;
  List<OvertimeTimeRangeResultSet>? apiResultSet;

  HourSelectorListener(this.selectedOvertimeTimeList, this.apiResultSet)
  {
    dateControllerList = List.empty(growable: true);
    enabledList = List.empty(growable: true);
    for(int x=0;x<selectedOvertimeTimeList.length;x++)
      {
        Duration allowedDuration = Duration(minutes: apiResultSet?[x].maxWorkingHourDay??0);
        enabledList?.add(allowedDuration.inMinutes>0?(apiResultSet?[x].isAllow??false):false);
        DateTime? selectedTime = selectedOvertimeTimeList[x].selectedDateTime;
        dateControllerList?.add(DateController('x$x',dateCallBack,defaultTime: selectedTime,receivedDate: selectedTime,initialTimeForController: selectedOvertimeTimeList[x].date,timeFormat: DateFormat('HH:mm')));
      }
  }

  check()
  {

  }
  void submit(BuildContext context) {

    bool selectedIfAny = false;
    String errorMessage = CallLanguageKeyWords.get(context, LanguageCodes.mustSelectTime)??'';

    for(int x=0;x<selectedOvertimeTimeList.length;x++)
      {
        DateTime? date = dateControllerList?[x].receivedDate;
        Duration selectedDateDuration = Duration(hours: date?.hour??0,minutes: date?.minute??0);

        OvertimeTimeRangeResultSet? overtimeTimeRangeResultSet = apiResultSet?[x];
        Duration allowedDuration = Duration(minutes: overtimeTimeRangeResultSet?.maxWorkingHourDay??0);

        if(apiResultSet?[x].isAllow==true&&date!=null&&(selectedDateDuration.inMinutes>0)&&(selectedDateDuration.inMinutes<=allowedDuration.inMinutes))
          {
            selectedIfAny = true;
            selectedOvertimeTimeList[x].selectedDateTime = dateControllerList?[x].receivedDate;
          }
        else
          {
            if(selectedDateDuration.inMinutes>allowedDuration.inMinutes)
            {
              selectedIfAny = false;
              errorMessage = '${CallLanguageKeyWords.get(context, LanguageCodes.hourError1)} ${GetDateFormats().getFilterDateTimeFormat(date)} ${CallLanguageKeyWords.get(context, LanguageCodes.isWord)} ${allowedDuration.inMinutes} ${CallLanguageKeyWords.get(context, LanguageCodes.hourError2)}';
              break;
            }
          }
      }
    if(selectedIfAny == true)
      {
        Navigator.pop(context,getMapper());
      }
    else
      {
        SnackBarDesign.errorSnack(errorMessage);
      }
  }

  getMapper()
  {
    return selectedOvertimeTimeList.map((v) => v.toJson()).toList();
  }

  dateCallBack(DateReturn dateReturn) {
    /// when creating datetime controllers we assign an id int the controller and also the length of dateControllerList
    /// is same to selectedOvertimeTimeList so after getting data from dateCallBack we also receive the id of dateController
    /// so we check the index of dateController and if index found then we save the received value from dateReturn to selectedOvertimeTimeList
    /// at the specific index because length is same
    int? index = dateControllerList?.indexWhere((element) => element.dateType == dateReturn.dateType);
    if(index!=null)
      {
        selectedOvertimeTimeList[index].selectedDateTime = dateReturn.value;
        notifyListeners();
      }
  }
}