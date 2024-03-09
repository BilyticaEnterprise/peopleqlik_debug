import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/AuthListeners/log_out_listener.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/cubit_ingerited.dart';

import '../../../ModuleSetting/domain/model/settings_model.dart';
import '../../domain/models/mobile_current_page_data.dart';
import '../../domain/usecases/page_update_usecase.dart';
import '../../utils/page_state.dart';

class CurrentMobileBlockModulePage extends ExtendedCubit<MobileBlocPageState>
{
  late PageUpdateUseCase useCase;
  CurrentMobileBlockModulePage(super.initialState)
  {
    useCase = PageUpdateUseCase();
  }

  void saveExtraData(MobileBlocPagesCurrentDataMapper data) {

  }

  updatePage(MobileBlocPageState pageState){
    emit(useCase.updatePage(pageState));
  }

  MobileBlocPageState getCurrentPage(){
    return useCase.getCurrentPage();
  }

  void doneTapMobilePageStatMobileBlocked(BuildContext context, DeviceRestricModel data) {
    _logoutUser();
  }
  void doneTapMobilePageStateAskAdminToApprove(BuildContext context, DeviceRestricModel data) {
    _logoutUser();
  }
  void doneTapMobilePageStateLimitReached(BuildContext context, DeviceRestricModel data) {
    Navigator.pushNamed(context, CurrentPage.registerMobilePage,arguments: data);
  }
  void doneTapMobilePageStateAutoApproveDeactivateAndRegister(BuildContext context, DeviceRestricModel data) {
    Navigator.pushNamed(context, CurrentPage.inActiveAndRegisterPage,arguments: data);
  }
  void doneTapMobilePageStateFirstRegister(BuildContext context, DeviceRestricModel data) {
    Navigator.pushNamed(context, CurrentPage.registerMobilePage,arguments: data);
  }
  void doneTapMobilePageStateNotRegister(BuildContext context, DeviceRestricModel data) {
    Navigator.pushNamed(context, CurrentPage.registerMobilePage,arguments: data);
  }

  void extraTapMobilePageStatMobileBlocked(BuildContext context) {_logoutUser();}
  void extraTapMobilePageStateAskAdminToApprove(BuildContext context) {_logoutUser();}
  void extraTapMobilePageStateLimitReached(BuildContext context) {_logoutUser();}
  void extraTapMobilePageStateAutoApproveDeactivateAndRegister(BuildContext context) {_logoutUser();}
  void extraTapMobilePageStateFirstRegister(BuildContext context) {_logoutUser();}
  void extraTapMobilePageStateNotRegister(BuildContext context) {_logoutUser();}


  _logoutUser()
  async {
    await MoveOnLoginPage.logOutClearData();
    GetNavigatorStateContext.navigatorKey.currentState!.pushNamedAndRemoveUntil(CurrentPage.CompanyPage, (route) => false);
  }
}