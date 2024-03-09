import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/utils/Default_Screens/scafold_screens/default_screens.dart';

import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/DropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/ScreenLoader/circular_indicator_customized.dart';
import '../../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../utils/Buttons/bottom_single_button.dart';
import '../../../../../../../../../utils/DatePickText/date_picker_text_style_1.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/text_field_latest.dart';
import '../../../../../../../../../utils/bloc_logic_utils/bloc_provider_extended.dart';
import '../../../../utils/enums/enum_update_add.dart';
import '../listeners/family_add_edit_listener.dart';

class FamilyEditPage extends StatelessWidget {
  FamilyEditPage({super.key});
  UpdateAdd? updateAdd;

  @override
  Widget build(BuildContext context) {
    updateAdd = ModalRoute.of(context)?.settings.arguments as UpdateAdd?;
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<FamilyAddEditListener>(create: (_) => FamilyAddEditListener(AppStateNothing(),updateAdd??UpdateAdd.addNew),)
        ],
        builder: (context) {
          return GetPageStarterScaffoldStateLess(
            title: CallLanguageKeyWords.get(context, LanguageCodes.familyPage)??'',
            body: _BodyView(),
            bottomNavigationBar: BlocConsumer<FamilyAddEditListener,AppState>(
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
      BlocProvider.of<FamilyAddEditListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    FamilyAddEditListener familyAddEditListener = BlocProvider.of<FamilyAddEditListener>(context,listen: false);
    return BlocConsumer<FamilyAddEditListener,AppState>(
        listener: (context,data){},
        builder: (context, data) {
          if(data is AppStateDone)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DividerByHeight(2),
                  HeaderDropDownField(dropDownDataType: familyAddEditListener.useCase.getControllerWithName().relationShipDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.relationShip)??'Relation Ship', key: Key('regular1'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  HeaderDropDownField(dropDownDataType: familyAddEditListener.useCase.getControllerWithName().genderDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.gender)??'Gender', key: Key('regular2'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  HeaderDropDownField(dropDownDataType: familyAddEditListener.useCase.getControllerWithName().martialDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.martialStatus)??'Martial Status', key: Key('regular3'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.firstName)??'First Name', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: familyAddEditListener.useCase.getControllerWithName().firstNameEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('1')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.lastName)??'Last Name', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: familyAddEditListener.useCase.getControllerWithName().lastNameEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('2')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.mobileNumber)??'Mobile Number', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: familyAddEditListener.useCase.getControllerWithName().mobileNumberEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('3')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.email)??'Email', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: familyAddEditListener.useCase.getControllerWithName().emailEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('4')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.identificationNo)??'Mobile Number', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: familyAddEditListener.useCase.getControllerWithName().identificationNumberEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('5')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.passportNumber)??'Mobile Number', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: familyAddEditListener.useCase.getControllerWithName().passportNumberEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('6')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.remarks)??'Email', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: familyAddEditListener.useCase.getControllerWithName().remarksNumberEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('7')),
                  const DividerByHeight(3),
                  DatePickerTextStyle1(Key('dateKey1'),'${CallLanguageKeyWords.get(context, LanguageCodes.select)} ${CallLanguageKeyWords.get(context, LanguageCodes.expiryDate)}', dateController: familyAddEditListener.useCase.getControllerWithName().expiryDateController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.fromDate)}',minDate: DateTime.now().subtract(const Duration(days: 800)),isCompulsory: false,margin: 6.0,padding: 4.5,),
                  const DividerByHeight(3),
                  DatePickerTextStyle1(Key('dateKey2'),'${CallLanguageKeyWords.get(context, LanguageCodes.select)} ${CallLanguageKeyWords.get(context, LanguageCodes.dobDate)}', dateController: familyAddEditListener.useCase.getControllerWithName().dobDateController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.toDate)}',minDate: DateTime.now().subtract(const Duration(days: 800)),isCompulsory: false,margin: 6.0,padding: 4.5,),
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