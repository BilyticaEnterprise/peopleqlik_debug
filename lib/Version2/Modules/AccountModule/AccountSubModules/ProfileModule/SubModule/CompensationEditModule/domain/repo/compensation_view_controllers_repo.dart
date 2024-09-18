import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';

abstract class CompensationViewControllersRepo
{
  DropDownDataController? documentTypeDropDown;
  TextFieldControllerCall? documentNameEditTextController;
  TextFieldControllerCall? marEditTextController;

  Future<AppState> initializeControllersWithNewData(dynamic data);
  Future<AppState> initializeControllersWithExistingData(dynamic data);
}