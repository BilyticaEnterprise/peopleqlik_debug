import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

class BubbleAnim extends GetChangeNotifier
{
  double? value=0;
  update(double value)
  {
    this.value = value;
    notifyListeners();
  }

}