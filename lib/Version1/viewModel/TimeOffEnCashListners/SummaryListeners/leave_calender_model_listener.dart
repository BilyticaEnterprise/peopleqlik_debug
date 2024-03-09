import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/leave_calender.dart';

import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

class LeaveCalenderModelListener extends GetChangeNotifier
{
  int selectedIndex = -1;
  late List<LeaveCalendar> leaveCalenderList;
  LeaveCalenderModelListener()
  {
    leaveCalenderList = List.empty(growable: true);
  }
  void makeList() async
  {
    leaveCalenderList.clear();

    var calenderData = await LeaveCalenderPrefs().getLeaveCalenderPrefs();
      if(calenderData!=null&&calenderData.isNotEmpty)
      {
        jsonDecode(calenderData).forEach((v) {
          leaveCalenderList.add(LeaveCalendar.fromJson(v));
        });
      }
  }
  void updateSelected(int index)
  {
    selectedIndex = index;
    notifyListeners();
  }
  LeaveCalendar? getIndexedCalender(int index)
  {
    try{
      return leaveCalenderList[index];
    }catch(e){
      return null;
    }
  }
  @override
  void dispose() {
    leaveCalenderList.clear();
    super.dispose();
  }
}