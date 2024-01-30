import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/sliding_up_panel.dart';

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