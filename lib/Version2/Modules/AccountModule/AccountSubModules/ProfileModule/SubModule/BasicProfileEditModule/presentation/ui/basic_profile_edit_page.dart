import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_single_button.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';

import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../../utils/screenLoader/circular_indicator_customized.dart';
import '../../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../../../../../utils/TextFields/Listeners/text_field_controller.dart';
import '../../../../../../../../../utils/TextFields/text_field_latest.dart';
import '../../../../utils/enums/enum_update_add.dart';
import '../listeners/basic_profile_edit_listener.dart';

class BasicProfileEditPage extends StatelessWidget {
  BasicProfileEditPage({super.key});

  UpdateAdd? updateAdd;

  @override
  Widget build(BuildContext context) {
    updateAdd = ModalRoute.of(context)?.settings.arguments as UpdateAdd?;
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<BasicProfileAddEditListener>(create: (_) => BasicProfileAddEditListener(AppStateNothing(),updateAdd??UpdateAdd.addNew),)
      ],
      builder: (context) {
        return GetPageStarterScaffoldStateLess(
          title: CallLanguageKeyWords.get(context, LanguageCodes.basicInfoPage)??'',
          body: _BodyView(),
          bottomNavigationBar: BlocConsumer<BasicProfileAddEditListener,AppState>(
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
      BlocProvider.of<BasicProfileAddEditListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    BasicProfileAddEditListener basicProfileAddEditListener = BlocProvider.of<BasicProfileAddEditListener>(context,listen: false);
    return BlocConsumer<BasicProfileAddEditListener,AppState>(
      listener: (context,data){},
      builder: (context, data) {
        if(data is AppStateDone)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DividerByHeight(2),
                  HeaderDropDownField(dropDownDataType: basicProfileAddEditListener.useCase.getControllerWithName().martialStatusDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.MartialStatus)??'Martial Status', key: Key('regular1'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  HeaderDropDownField(dropDownDataType: basicProfileAddEditListener.useCase.getControllerWithName().genderDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.Gender)??'Gender', key: Key('regular2'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  HeaderDropDownField(dropDownDataType: basicProfileAddEditListener.useCase.getControllerWithName().religionDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.Religion)??'Religion', key: Key('regular3'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  HeaderDropDownField(dropDownDataType: basicProfileAddEditListener.useCase.getControllerWithName().ethnicityDropDown, header: CallLanguageKeyWords.get(context, LanguageCodes.Ethnicity)??'Ethnicity', key: Key('regular4'), isCompulsory: true, onSelectedDropDown: dropDownCallBack,isEnabled: true),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.IdentificationNo)??'Identification No', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: TextFieldControllerCall(), textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('1')),
                  const DividerByHeight(3),
                  TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.officialEmail)??'Official Email', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'write something', controller: TextFieldControllerCall(), textInputAction: TextInputAction.next, focusNode: FocusScopeNode(), key: Key('2')),
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

