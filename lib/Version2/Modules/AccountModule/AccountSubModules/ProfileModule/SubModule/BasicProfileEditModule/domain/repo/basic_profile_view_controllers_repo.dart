import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';

abstract class BasicProfileViewControllersRepo
{

  DropDownDataController? martialStatusDropDown;
  DropDownDataController? genderDropDown;
  DropDownDataController? religionDropDown;
  DropDownDataController? ethnicityDropDown;
  TextFieldControllerCall? identificationNoEditTextController;
  TextFieldControllerCall? officialEmailEditTextController;

  Future<AppState> initializeControllersWithNewData(dynamic data);
  Future<AppState> initializeControllersWithExistingData(dynamic data);
}