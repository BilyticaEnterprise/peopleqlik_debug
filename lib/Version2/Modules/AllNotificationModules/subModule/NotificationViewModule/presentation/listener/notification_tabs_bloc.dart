import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/utils/get_notification_tab_list.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';
import 'package:peopleqlik_debug/utils/tabs/domain/model/tab_bar_data.dart';

class NotificationTabPageBloc extends ExtendedCubit
{
  late List<TabOptionData> _notificationTabList;
  late PageController pageController;
  TabController? tabController;

  NotificationTabPageBloc(super.initialState,BuildContext context)
  {
    _notificationTabList = GetNotificationTabList().getTabs(context);
    pageController = PageController();
  }

  List<TabOptionData> getNotificationTabsList() {
    return _notificationTabList;
  }

  void tabTapped(int index) {
    pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void pageUpdate(int index) {
    tabController?.animateTo(index);
  }

}