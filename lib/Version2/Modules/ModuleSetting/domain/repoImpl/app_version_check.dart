import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';

import '../../../../../mainCommon.dart';
import '../../../../../utils/version_checker/app_version_update.dart';

extension GetAppVersionChecker on SettingsModelListener
{
  checkForAppVersion()async
  {
    try{
      return await AppVersionUpdate.checkForUpdates(playStoreId: flavorConfigSettings?.applicationAndroidStoreId, appleId: flavorConfigSettings?.applicationIOSStoreId,country: 'US');
    }catch(e){
      return null;
    }
  }
}