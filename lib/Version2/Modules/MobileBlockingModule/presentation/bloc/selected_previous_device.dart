import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../../ModuleSetting/domain/model/settings_model.dart';

class SelectedPreviousDeviceList extends ExtendedCubit<int>
{
  List<DeviceList>? deviceList;
  SelectedPreviousDeviceList(super.initialState,this.deviceList);

  selectedId(int id)
  {
    emit(id);
  }
}