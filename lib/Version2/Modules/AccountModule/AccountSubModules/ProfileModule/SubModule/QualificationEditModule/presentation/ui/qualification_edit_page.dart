import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/utils/Default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';

import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/DropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/ScreenLoader/circular_indicator_customized.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../utils/Buttons/bottom_single_button.dart';
import '../../../../../../../../../utils/DatePickText/date_picker_text_style_1.dart';
import '../../../../../../../../../utils/States/app_state.dart';
import '../../../../../../../../../utils/TextFields/text_field_latest.dart';
import '../../../../../../../../../utils/bloc_logic_utils/bloc_provider_extended.dart';
import '../../../../utils/enums/enum_update_add.dart';
import '../listeners/qualification_add_edit_listener.dart';

class QualificationEditPage extends StatelessWidget {
  QualificationEditPage({super.key});

  UpdateAdd? updateAdd;

  @override
  Widget build(BuildContext context) {
    updateAdd = ModalRoute.of(context)?.settings.arguments as UpdateAdd?;
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<QualificationAddEditListener>(create: (_) => QualificationAddEditListener(AppStateNothing(),updateAdd??UpdateAdd.addNew),)
        ],
        builder: (context) {
          return GetPageStarterScaffoldStateLess(
            title: CallLanguageKeyWords.get(context, LanguageCodes.qualificationPage)??'',
            body: _BodyView(),
            bottomNavigationBar: BlocConsumer<QualificationAddEditListener,AppState>(
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
      BlocProvider.of<QualificationAddEditListener>(context,listen: false).start(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    QualificationAddEditListener qualificationAddEditListener = BlocProvider.of<QualificationAddEditListener>(context,listen: false);
    return BlocConsumer<QualificationAddEditListener,AppState>(
        listener: (context,data){},
        builder: (context, data) {
          if(data is AppStateDone)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DividerByHeight(2),
                  HeaderDropDownField(dropDownDataType: qualificationAddEditListener.useCase.getControllerWithName().qualificationTypeDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.qualificationCode)??'Qualification Code', key: Key('regular1'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  HeaderDropDownField(dropDownDataType: qualificationAddEditListener.useCase.getControllerWithName().countryDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.country)??'Country', key: Key('regular2'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.instituteName)??'Institute Name', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: qualificationAddEditListener.useCase.getControllerWithName().instituteNameEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('1')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.obtainedMarks)??'Obtained Marks', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: qualificationAddEditListener.useCase.getControllerWithName().obtainedMarksEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('2')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.totalMarks)??'Total Marks', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: qualificationAddEditListener.useCase.getControllerWithName().totalMarksEditTextController, textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('3')),
                  const DividerByHeight(3),
                  DatePickerTextStyle1(Key('dateKey1'),'${CallLanguageKeyWords.get(context, LanguageCodes.select)} ${CallLanguageKeyWords.get(context, LanguageCodes.fromDate)}', dateController: qualificationAddEditListener.useCase.getControllerWithName().fromDateController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.fromDate)}',minDate: DateTime.now().subtract(const Duration(days: 800)),isCompulsory: false,margin: 6.0,padding: 4.5,),
                  const DividerByHeight(3),
                  DatePickerTextStyle1(Key('dateKey2'),'${CallLanguageKeyWords.get(context, LanguageCodes.select)} ${CallLanguageKeyWords.get(context, LanguageCodes.toDate)}', dateController: qualificationAddEditListener.useCase.getControllerWithName().toDateController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.toDate)}',minDate: DateTime.now().subtract(const Duration(days: 800)),isCompulsory: false,margin: 6.0,padding: 4.5,),
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

