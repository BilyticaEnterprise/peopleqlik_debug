import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';

import '../../../../../../../Version1/viewModel/AuthListeners/log_out_listener.dart';
import '../../../../../../../Version1/models/call_setting_data.dart';
import '../../../../../ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_twin_buttons.dart';
import '../../../../../../../utils/screenLoader/circular_indicator_customized.dart';
import '../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../configs/language_codes.dart';
import '../../../../../../../configs/routing/pages_name.dart';
import '../../../../../../../mainCommon.dart';
import '../../../../../../../utils/States/app_state.dart';
import '../../../../domain/models/current_and_previous_mobile_wrapper.dart';
import '../../../bloc/get_mobile_info_bloc.dart';
import '../widgets/current_device_widgets/current_mobile_widget.dart';
import '../widgets/previous_devices/previous_header_widget.dart';
import '../widgets/previous_devices/show_mobile_list.dart';

class InActiveAndRegisterPage extends StatelessWidget {
  InActiveAndRegisterPage({super.key});

  DeviceRestricModel? deviceRestrictModel;

  @override
  Widget build(BuildContext context) {
    deviceRestrictModel = ModalRoute.of(context)?.settings.arguments as DeviceRestricModel?;
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<GetMobileInfoBloc>(create: (_) => GetMobileInfoBloc(AppStateStart(initialData: deviceRestrictModel))),
      ],
      builder: (context) {
        return GetPageStarterScaffoldStateLess(
          title: '${CallLanguageKeyWords.get(context, LanguageCodes.registerDevice)}',
          body: BodyData(),
          bottomNavigationBar: BottomTwinButtons(
            acceptCallBack: ()
            {
              BlocProvider.of<GetMobileInfoBloc>(context,listen: false).sendInActiveCall(context);
            },
            rejectCallBack: ()
            async {
              await MoveOnLoginPage.logOutClearData();
              GetNavigatorStateContext.navigatorKey.currentState!.pushNamedAndRemoveUntil(CurrentPage.CompanyPage, (route) => false);
            },
            acceptText: CallLanguageKeyWords.get(context, LanguageCodes.register)??'',
            rejectText: CallLanguageKeyWords.get(context, LanguageCodes.logOut)??'',
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
    GetMobileInfoBloc getMobileInfoBloc = BlocProvider.of<GetMobileInfoBloc>(context,listen: false);
    return BlocConsumer<GetMobileInfoBloc,AppState>(
        listener: (context,data){},
        builder: (context, data) {
          if(data is AppStateDone<CurrentAndPreviousMobileMapper>)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CurrentMobileWidget(data: data.data?.currentMobile,),
                  const DividerByHeight(4),
                  PreviousHeaderWidget(count: getMobileInfoBloc.deviceRestrictModel?.noOfDevice??0,header: CallLanguageKeyWords.get(context, LanguageCodes.inActiveDevice)??'', text: CallLanguageKeyWords.get(context, LanguageCodes.inActivateDeviceNow)??'',),
                  const DividerByHeight(0.6),
                  MobileListView(
                    deviceList: data.data?.previousDeviceList,
                    selectedId: (selectedId){
                      getMobileInfoBloc.deActivateId(selectedId);
                    },
                    enableSelection: true,
                  ),
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
}
