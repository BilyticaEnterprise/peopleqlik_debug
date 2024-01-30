import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Default_Screens/default_screens.dart';
import 'package:peopleqlik_debug/Version2/utils/States/app_state.dart';
import 'package:peopleqlik_debug/Version2/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:provider/provider.dart';

import '../../../../../UiPages/Reuse_Widgets/Buttons/bottom_twin_buttons.dart';
import '../bloc/get_mobile_info_bloc.dart';
import 'mobile_register_view/widgets/previous_devices/show_mobile_list.dart';

class MobileBlockingPage extends StatelessWidget {
  const MobileBlockingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<GetMobileInfoBloc>(create: (_) => GetMobileInfoBloc(AppStateStart()))
      ],
      builder: (context) {
        return GetPageStarterScaffold(
          title: '${CallLanguageKeyWords.get(context, LanguageCodes.registerDevice)}',
          body: BodyData(),
          bottomNavigationBar: BottomTwinButtons(
            acceptCallBack: () {  },
            rejectCallBack: () {  },
            acceptText: 'Register',
            rejectText: 'Log Out',
            acceptTextColor: MyColor.colorWhite,
          ),
        );
      }
    );
  }
}
class BodyData extends StatefulWidget {
  const BodyData({super.key});

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<GetMobileInfoBloc>(context,listen: false).start();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ShowMobileList();
  }
}
