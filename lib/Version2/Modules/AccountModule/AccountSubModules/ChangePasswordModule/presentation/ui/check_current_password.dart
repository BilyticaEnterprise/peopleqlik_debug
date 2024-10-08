import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/icon_view/get_icons.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../configs/colors.dart';
import '../../../../../../../configs/fonts.dart';
import '../../../../../../../utils/buttons/bottom_single_button.dart';
import '../../../../../../../utils/Default_Screens/text_filed_screens/auto_scroll_screen.dart';
import '../../../../../../../utils/TextFields/text_field_latest.dart';
import '../listener/check_current_password_bloc.dart';

class CheckCurrentPasswordPage extends StatelessWidget {
  const CheckCurrentPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<CheckCurrentPasswordBloc>(create: (_) => CheckCurrentPasswordBloc(AppStateNothing()))
        ],
        builder: (context) {
          return GetPageStarterScaffoldStateFull(
            textFieldScreen: true,
            body: _BodyData(),
            bottomNavigationBar: BottomSingleButton(
              text: '${CallLanguageKeyWords.get(context, LanguageCodes.done)}',
              buttonColor: MyColor.colorPrimary,
              textColor: MyColor.colorWhite,
              onPressed: (){
                BlocProvider.of<CheckCurrentPasswordBloc>(context,listen: false).checkPassword(context);
              },
            ),
          );
        }
    );
  }
}

class _BodyData extends StatefulWidget {
  const _BodyData({super.key});

  @override
  State<_BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<_BodyData> {
  @override
  Widget build(BuildContext context) {
    CheckCurrentPasswordBloc data = BlocProvider.of<CheckCurrentPasswordBloc>(context,listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const DividerByHeight(2),
          const GetIcons(icon: SvgPicturesData.lock,size: 10,noColor: true,backgroundColor: MyColor.colorA5,),
          const DividerByHeight(4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6)),
            child: Text(
              CallLanguageKeyWords.get(context, LanguageCodes.currentPassword)??'',
              style: GetFont.get(
                  context,
                  fontSize: 2.4,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
              ),
            ),
          ),
          const DividerByHeight(3),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(8)),
            child: Text(
              CallLanguageKeyWords.get(context, LanguageCodes.currentPassChangeDesc)??'',
              style: GetFont.get(
                  context,
                  fontSize: 1.6,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorBlack
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const DividerByHeight(6),
          TextWidgetLatest(textFieldHeader: CallLanguageKeyWords.get(context, LanguageCodes.currentPasswordEnter)??'Current Password', hintText: CallLanguageKeyWords.get(context, LanguageCodes.writeSomething)??'Write something', controller: data.textFieldControllerCall, textInputAction: TextInputAction.done, focusNode: FocusScopeNode(),isPasswordField: true, key: Key('3')),
          const DividerByHeight(3),

        ],
      ),
    );
  }
}
