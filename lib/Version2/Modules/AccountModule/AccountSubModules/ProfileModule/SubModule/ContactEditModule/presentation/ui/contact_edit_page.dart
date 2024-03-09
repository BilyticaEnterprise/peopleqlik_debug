import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/utils/ScreenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/Buttons/bottom_single_button.dart';
import 'package:peopleqlik_debug/utils/Default_Screens/scafold_screens/default_screens.dart';

import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/DropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../utils/DatePickText/date_picker_text_style_1.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/text_field_latest.dart';
import '../../../../../../../../../utils/bloc_logic_utils/bloc_provider_extended.dart';
import '../../../../utils/enums/enum_update_add.dart';
import '../listeners/contact_add_edit_listener.dart';

class ContactEditPage extends StatelessWidget {
  ContactEditPage({super.key});

  UpdateAdd? updateAdd;

  @override
  Widget build(BuildContext context) {
    updateAdd = ModalRoute.of(context)?.settings.arguments as UpdateAdd?;
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<ContactAddEditListener>(create: (_) => ContactAddEditListener(AppStateNothing(),updateAdd??UpdateAdd.addNew),)
        ],
        builder: (context) {
          return GetPageStarterScaffoldStateLess(
            title: CallLanguageKeyWords.get(context, LanguageCodes.contactPage)??'',
            body: _BodyView(),
            bottomNavigationBar: BlocConsumer<ContactAddEditListener,AppState>(
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
      BlocProvider.of<ContactAddEditListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ContactAddEditListener contactAddEditListener = BlocProvider.of<ContactAddEditListener>(context,listen: false);
    return BlocConsumer<ContactAddEditListener,AppState>(
        listener: (context,data){},
        builder: (context, data) {
          if(data is AppStateDone)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DividerByHeight(2),
                  HeaderDropDownField(dropDownDataType: contactAddEditListener.useCase.getControllerWithName().contactTypeDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.contactType)??'Contact Type', key: Key('regular1'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  HeaderDropDownField(dropDownDataType: contactAddEditListener.useCase.getControllerWithName().countryDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.country)??'Country', key: Key('regular2'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  HeaderDropDownField(dropDownDataType: contactAddEditListener.useCase.getControllerWithName().cityDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.city)??'City', key: Key('regular3'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.address)??'Address', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: contactAddEditListener.useCase.getControllerWithName().addressEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('1')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.phoneNumber)??'Phone Number', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: contactAddEditListener.useCase.getControllerWithName().phoneNumberEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('2')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.mobileNumber)??'Mobile Number', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: contactAddEditListener.useCase.getControllerWithName().mobileNumberEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('3')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.email)??'Email', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: contactAddEditListener.useCase.getControllerWithName().emailEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('4')),
                  const DividerByHeight(3),
                  DatePickerTextStyle1(Key('dateKey1'),'${CallLanguageKeyWords.get(context, LanguageCodes.select)} ${CallLanguageKeyWords.get(context, LanguageCodes.fromDate)}', dateController: contactAddEditListener.useCase.getControllerWithName().fromDateController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.fromDate)}',minDate: DateTime.now().subtract(const Duration(days: 800)),isCompulsory: false,margin: 6.0,padding: 4.5,),
                  const DividerByHeight(3),
                  DatePickerTextStyle1(Key('dateKey2'),'${CallLanguageKeyWords.get(context, LanguageCodes.select)} ${CallLanguageKeyWords.get(context, LanguageCodes.toDate)}', dateController: contactAddEditListener.useCase.getControllerWithName().toDateController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.toDate)}',minDate: DateTime.now().subtract(const Duration(days: 800)),isCompulsory: false,margin: 6.0,padding: 4.5,),
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



