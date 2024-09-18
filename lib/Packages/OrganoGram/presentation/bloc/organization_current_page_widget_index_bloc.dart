import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organization_chart_handler_model.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class OrganizationCurrentWidgetIndex extends ExtendedCubit<List<int>>
{
  late List<int> _data;
  OrganizationCurrentWidgetIndex(super.initialState);

  Future<void> updateListForIndexes(List<OrganizationChartHandlerModel> data)async {
    _data = List<int>.generate(data.length, (index) => data[index].currentPageIndex);
    return;
  }

  getCurrentFocusedIndexAt(int listIndex)
  {
    return _data[listIndex];
  }

  updateCurrentFocusedIndexAt(int listIndex,int currentIndex)
  {
    _data[listIndex] = currentIndex;
    emit(_data);
  }

  int getLength()
  {
    return _data.length;
  }
}