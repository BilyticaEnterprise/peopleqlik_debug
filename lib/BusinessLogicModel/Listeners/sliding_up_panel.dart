import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

class SlidingPanelData extends GetChangeNotifier
{
  PanelController? panelController;
  SliderWidgetEnum? currentPage;
  BuildContext? realContext;
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
enum SliderWidgetEnum
{
  permission,summary,checkInTypes,employeeSearch,mockLocation
}