import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_single_button.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';

import '../../../../../../../../../Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/screenLoader/circular_indicator_customized.dart';
import '../../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/text_field_latest.dart';
import '../../../../../../../../../utils/bloc_logic_utils/bloc_provider_extended.dart';
import '../../../../utils/enums/enum_update_add.dart';
import '../listeners/payment_add_edit_listener.dart';

class PaymentEditPage extends StatelessWidget {
  PaymentEditPage({super.key});

  UpdateAdd? updateAdd;

  @override
  Widget build(BuildContext context) {
    updateAdd = ModalRoute.of(context)?.settings.arguments as UpdateAdd?;
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<PaymentAddEditListener>(create: (_) => PaymentAddEditListener(AppStateNothing(),updateAdd??UpdateAdd.addNew),)
        ],
        builder: (context) {
          return GetPageStarterScaffoldStateLess(
            title: CallLanguageKeyWords.get(context, LanguageCodes.paymentPage)??'',
            body: _BodyView(),
            bottomNavigationBar: BlocConsumer<PaymentAddEditListener,AppState>(
                listener: (context,data){},
                builder: (context, data) {
                  if(data is AppStateDone)
                  {
                    return BottomSingleButton(text: '${CallLanguageKeyWords.get(context, LanguageCodes.done)}',buttonColor: MyColor.colorPrimary,textColor: MyColor.colorWhite,onPressed: (){},);
                  }
                  else
                  {
                    return Container(height: 0,);
                  }
                }
            ),
          );
        }
    );
  }
}
class _BodyView extends StatefulWidget {
  const _BodyView({super.key});

  @override
  State<_BodyView> createState() => _BodyViewState();
}

class _BodyViewState extends State<_BodyView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<PaymentAddEditListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    PaymentAddEditListener paymentAddEditListener = BlocProvider.of<PaymentAddEditListener>(context,listen: false);
    return BlocConsumer<PaymentAddEditListener,AppState>(
        listener: (context,data){},
        builder: (context, data) {
          if(data is AppStateDone)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DividerByHeight(2),
                  HeaderDropDownField(dropDownDataType: paymentAddEditListener.useCase.getControllerWithName().paymentMethodDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.PaymentMethod)??'Payment Method', key: Key('regular1'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  HeaderDropDownField(dropDownDataType: paymentAddEditListener.useCase.getControllerWithName().accountTypeDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.AccountType)??'Account Type', key: Key('regular2'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  HeaderDropDownField(dropDownDataType: paymentAddEditListener.useCase.getControllerWithName().beneficiaryBankDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.BeneficiaryBank)??'Beneficiary Bank', key: Key('regular3'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  HeaderDropDownField(dropDownDataType: paymentAddEditListener.useCase.getControllerWithName().beneficiaryBranchDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.BeneficiaryBranch)??'Beneficiary Branch', key: Key('regular4'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.EmployeeAccount)??'Employee Account', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: paymentAddEditListener.useCase.getControllerWithName().employeeAccountEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('1')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.IBANCode)??'IBAN Code', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: paymentAddEditListener.useCase.getControllerWithName().iBANCodeEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('2')),
                  const DividerByHeight(16),

                ],
              ),
            );
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }

  dropDownCallBack(SelectedDropDown p1) {

  }
}

