import 'package:peopleqlik_debug/utils/DropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/DatePickText/date_controller.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';

abstract class ContactViewControllersRepo
{

  DropDownDataController? contactTypeDropDown;
  DropDownDataController? countryDropDown;
  DropDownDataController? cityDropDown;
  TextFieldControllerCall? addressEditTextController;
  TextFieldControllerCall? phoneNumberEditTextController;
  TextFieldControllerCall? mobileNumberEditTextController;
  TextFieldControllerCall? emailEditTextController;
  DateController? fromDateController;
  DateController? toDateController;

  Future<AppState> initializeControllersWithNewData(dynamic data);
  Future<AppState> initializeControllersWithExistingData(dynamic data);
}