import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

class FloatingActionButtonBloc extends ExtendedCubit<double>
{
  FloatingActionButtonBloc(super.initialState);

  update(double opacity)
  {
    emit(opacity);
  }

}