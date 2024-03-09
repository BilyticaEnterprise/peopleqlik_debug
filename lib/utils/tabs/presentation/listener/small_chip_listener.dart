import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class SmallChipListener extends ExtendedCubit<dynamic>
{
  SmallChipListener(super.initialState);

  void selectedIndex(dynamic tabType) {
    emit(tabType);
  }

}