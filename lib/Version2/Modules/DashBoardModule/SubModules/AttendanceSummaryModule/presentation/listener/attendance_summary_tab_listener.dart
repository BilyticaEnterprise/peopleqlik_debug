import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../../../../../../utils/tabs/domain/model/tab_bar_data.dart';
import '../../../../../../../utils/tabs/domain/model/tab_bar_mapper.dart';
import '../../utils/attendance_summary_tab_list_getter.dart';

class AttendanceSummaryTabListener extends ExtendedCubit
{
  late List<TabOptionData> _attendanceSummaryOptionList;
  late PageController pageController;
  TabController? tabController;

  AttendanceSummaryTabListener(super.initialState,BuildContext context)
  {
    _attendanceSummaryOptionList = AttendanceSummaryOptions.getOptionList(context,[4,6,10,0,0,0]);
    pageController = PageController();
  }

  List<TabOptionData> getProfileOptionList() {
    return _attendanceSummaryOptionList;
  }

  void tabTapped(int index) {
    pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void pageUpdate(int index) {
    tabController?.animateTo(index);
  }

}