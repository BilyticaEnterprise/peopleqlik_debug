import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/viewModel/AuthListeners/log_out_listener.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';

import 'package:peopleqlik_debug/utils/buttons/bottom_twin_buttons.dart';
import '../../../../../utils/lottie_anims_utils/lottie_string.dart';
import '../../../../../configs/routing/pages_name.dart';
import '../../../../../mainCommon.dart';
import '../../../../../utils/bloc_logic_utils/bloc_provider_extended.dart';
import '../../domain/models/mobile_current_page_data.dart';
import '../../utils/page_state.dart';
import '../bloc/current_page_bloc.dart';
import 'mobile_register_view/views/mobile_promts.dart';

class MobileBlockingPage extends StatelessWidget {
  MobileBlockingPage({super.key});

  late MobileBlocPagesCurrentDataMapper mobileBlocPagesCurrentDataMapper;
  @override
  Widget build(BuildContext context) {
    mobileBlocPagesCurrentDataMapper = ModalRoute.of(context)?.settings.arguments as MobileBlocPagesCurrentDataMapper;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop)async{
        if(didPop)
        {
          return;
        }
        moveToCompanyPage();
      },
      child: ExtendedMultiBlocProvider(
          providers: [
            BlocProvider<CurrentMobileBlockModulePage>(create: (_) => CurrentMobileBlockModulePage(mobileBlocPagesCurrentDataMapper.mobileBlocPageState)),
          ],
          builder: (context) {
            return GetPageStarterScaffoldStateLess(
              title: '${CallLanguageKeyWords.get(context, LanguageCodes.registerDevice)}',
              onBackTap: (){
                moveToCompanyPage();
              },
              body: BodyData(data: mobileBlocPagesCurrentDataMapper),
            );
          }
      ),
    );
  }
  moveToCompanyPage()
  async {
    await MoveOnLoginPage.logOutClearData();
    GetNavigatorStateContext.navigatorKey.currentState?.pushNamedAndRemoveUntil(CurrentPage.CompanyPage, (route) => false);
  }
}
class BodyData extends StatefulWidget {
  final MobileBlocPagesCurrentDataMapper data;
  const BodyData({required this.data,super.key});

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<CurrentMobileBlockModulePage>(context,listen: false).saveExtraData(widget.data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    CurrentMobileBlockModulePage currentMobileBlockModulePage = BlocProvider.of(context,listen: false);
    return BlocConsumer<CurrentMobileBlockModulePage,MobileBlocPageState>(
        listener: (context,data){},
        builder: (context, data) {
          if(data is MobilePageStateMobileBlocked)
          {
            PrintLogs.printLogs('here1');
            return PromptView(
              header: CallLanguageKeyWords.get(context, LanguageCodes.deviceBlocked)??'',
              description: CallLanguageKeyWords.get(context, LanguageCodes.deviceBlockedDesc)??'',
              anim: LottieString.firstRegister,
              doneTapText: CallLanguageKeyWords.get(context, LanguageCodes.gotIt)??'',
              doneTap: (){
                currentMobileBlockModulePage.doneTapMobilePageStatMobileBlocked(context,data.data);
              },
            );
          }
          else if(data is MobilePageStateAskAdminToApprove)
          {
            PrintLogs.printLogs('here2');
            return PromptView(
              header: CallLanguageKeyWords.get(context, LanguageCodes.deviceNotRegHeader)??'',
              description: CallLanguageKeyWords.get(context, LanguageCodes.deviceNotRegValue)??'',
              anim: LottieString.firstRegister,
              doneTapText: CallLanguageKeyWords.get(context, LanguageCodes.gotIt)??'',
              doneTap: (){
                currentMobileBlockModulePage.doneTapMobilePageStateAskAdminToApprove(context,data.data);
              },
            );
          }
          else if(data is MobilePageStateLimitReached)
          {
            PrintLogs.printLogs('here3');
            return PromptView(
              header: CallLanguageKeyWords.get(context, LanguageCodes.cannotRegisterHeader)??'',
              description: CallLanguageKeyWords.get(context, LanguageCodes.cannotRegisterValue)??'',
              anim: LottieString.mobRegister,
              doneTapText: CallLanguageKeyWords.get(context, LanguageCodes.refresh)??'',
              doneTap: (){
                currentMobileBlockModulePage.doneTapMobilePageStateLimitReached(context,data.data);
              },
              extraTapText: CallLanguageKeyWords.get(context, LanguageCodes.logOut)??'',
              extraTap: (){
                currentMobileBlockModulePage.extraTapMobilePageStateLimitReached(context);
              },
            );
          }
          else if(data is MobilePageStateAutoApproveDeactivateAndRegister)
          {
            PrintLogs.printLogs('here4');
            return PromptView(
              header: CallLanguageKeyWords.get(context, LanguageCodes.deviceLimitReachedHeader)??'',
              description: CallLanguageKeyWords.get(context, LanguageCodes.deviceLimitReachedValue)??'',
              anim: LottieString.firstRegister,
              doneTapText: CallLanguageKeyWords.get(context, LanguageCodes.continueButton)??'',
              doneTap: (){
                currentMobileBlockModulePage.doneTapMobilePageStateAutoApproveDeactivateAndRegister(context,data.data);
              },
              extraTapText: CallLanguageKeyWords.get(context, LanguageCodes.logOut)??'',
              extraTap: (){
                currentMobileBlockModulePage.extraTapMobilePageStateAutoApproveDeactivateAndRegister(context);
              },
            );
          }
          else if(data is MobilePageStateFirstRegister)
          {
            PrintLogs.printLogs('here5');
            return PromptView(
              header: CallLanguageKeyWords.get(context, LanguageCodes.registerDeviceHeader)??'',
              description: CallLanguageKeyWords.get(context, LanguageCodes.registerDeviceValue)??'',
              anim: LottieString.firstRegister,
              doneTapText: CallLanguageKeyWords.get(context, LanguageCodes.continueButton)??'',
              doneTap: (){
                currentMobileBlockModulePage.doneTapMobilePageStateFirstRegister(context,data.data);
              },
              extraTapText: CallLanguageKeyWords.get(context, LanguageCodes.logOut)??'',
              extraTap: (){
                currentMobileBlockModulePage.extraTapMobilePageStateFirstRegister(context);
              },
            );
          }
          else if(data is MobilePageStateNotRegister)
          {
            PrintLogs.printLogs('here6');
            return PromptView(
              header: CallLanguageKeyWords.get(context, LanguageCodes.registerDeviceHeader)??'',
              description: CallLanguageKeyWords.get(context, LanguageCodes.registerDeviceValue2)??'',
              anim: LottieString.firstRegister,
              doneTapText: CallLanguageKeyWords.get(context, LanguageCodes.continueButton)??'',
              doneTap: (){
                currentMobileBlockModulePage.doneTapMobilePageStateNotRegister(context,data.data);
              },
              extraTapText: CallLanguageKeyWords.get(context, LanguageCodes.logOut)??'',
              extraTap: (){
                currentMobileBlockModulePage.extraTapMobilePageStateNotRegister(context);
              },
            );
          }
          else
          {
            return Container();
          }
        }
    );
  }
}
