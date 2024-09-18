import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organization_chart_handler_model.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class OrganizationSwiperHandlerBloc extends ExtendedCubit<List<bool>?>
{
  late List<bool> _data;

  OrganizationSwiperHandlerBloc(super.initialState);

  Future<void> updateListForScrolling(List<OrganizationChartHandlerModel> data)async {
    _data = List<bool>.generate(data.length, (index) => data[index].allowScrolling);
    return;
  }

  getScrollingPermissionAt(int listIndex)
  {
    return _data[listIndex];
  }

  updateScrollingPermissionAt(int listIndex)
  {
    _data[listIndex] = true;
    emit(_data);
  }

}