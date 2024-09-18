import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import '../../../../../configs/routing/pages_name.dart';
import '../../../../../mainCommon.dart';

extension MovingToPages on SettingsModelListener
{

  moveToBottomPage()
  {
    Future.delayed(const Duration(milliseconds: 200),(){
      GetNavigatorStateContext.navigatorKey.currentState?.pushNamedAndRemoveUntil(CurrentPage.MainBottomBarPage, (route) => false);
    });
  }


}