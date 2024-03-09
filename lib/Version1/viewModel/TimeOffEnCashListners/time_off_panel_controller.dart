import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/Version1/viewModel/sliding_up_panel.dart';

class TimeOffSlidingPanelController extends GetChangeNotifier
{
  SliderWidgetEnum? currentPage;
  BuildContext? realContext;

  TimeOffSlidingPanelController();
  void updatePage(SliderWidgetEnum? currentPage)
  {
    print(currentPage);
    this.currentPage = currentPage;
    notifyListeners();
  }

  void notifyListener() {
    notifyListeners();
  }
}