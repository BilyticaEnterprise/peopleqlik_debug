import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';

class TabViewListener extends GetChangeNotifier
{
  List<TabViewList>? tabViewListList;
  int? selectedIndex;
  TabViewListener({List<String>? list,this.selectedIndex = 0})
  {
    if(list!=null)
      {
        tabViewListList = List.empty(growable: true);
        for(int x=0;x<list.length;x++)
        {
          tabViewListList?.add(TabViewList(list[x],x));
        }
      }
  }

  void clickedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}
class TabViewList
{
  String? name;
  int? index;
  TabViewList(this.name,this.index);
}