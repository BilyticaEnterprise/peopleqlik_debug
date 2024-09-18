import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';

abstract class PaymentControllersRepo
{

  DropDownDataController? paymentMethodDropDown;
  DropDownDataController? accountTypeDropDown;
  DropDownDataController? beneficiaryBranchDropDown;
  DropDownDataController? beneficiaryBankDropDown;
  TextFieldControllerCall? employeeAccountEditTextController;
  TextFieldControllerCall? iBANCodeEditTextController;

  Future<AppState> initializeControllersWithNewData(dynamic data);
  Future<AppState> initializeControllersWithExistingData(dynamic data);
}