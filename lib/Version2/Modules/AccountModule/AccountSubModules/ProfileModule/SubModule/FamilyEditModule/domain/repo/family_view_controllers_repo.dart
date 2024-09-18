import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/datePickText/date_controller.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';

abstract class FamilyViewControllersRepo
{
  DropDownDataController? relationShipDropDown;
  DropDownDataController? genderDropDown;
  DropDownDataController? martialDropDown;
  TextFieldControllerCall? firstNameEditTextController;
  TextFieldControllerCall? lastNameEditTextController;
  TextFieldControllerCall? mobileNumberEditTextController;
  TextFieldControllerCall? emailEditTextController;
  TextFieldControllerCall? identificationNumberEditTextController;
  TextFieldControllerCall? passportNumberEditTextController;
  TextFieldControllerCall? remarksNumberEditTextController;
  DateController? expiryDateController;
  DateController? dobDateController;

  Future<AppState> initializeControllersWithNewData(dynamic data);
  Future<AppState> initializeControllersWithExistingData(dynamic data);
}