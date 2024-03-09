import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleAppVersion/domain/repo/version_check_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleAppVersion/presentation/ui/version_checker_view.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../../../../Version1/views/BottomBarPages/TimeOffPage/TimeOffSubPages/TimeOffPanel/time_off_cancel_panel_header.dart';
import 'package:peopleqlik_debug/utils/BottomSheetUi/bottom_sheet_ui.dart';
import '../../../../../mainCommon.dart';
import '../../../../../utils/global_variables.dart';

class VersionCheckRepoImpl extends VersionCheckRepo
{
  @override
  void getVersionData(BuildContext context) {
    if(_checkIfUpdateAvailable(context)==true)
    {
      if(context.mounted)
      {
        Future.delayed(const Duration(milliseconds: 100),(){
          ShowBottomSheet.show(
              context,
              height: 90,
              body: VersionCheckerView(),
              noAppBar: true,
              callBack: (value){
                if(value != null && value is bool && value == true)
                  {
                    goToStore(context);
                  }
              }
          );
        });
      }
    }
  }

  bool _checkIfUpdateAvailable(BuildContext context) {
    if(updateAvailable!=null && updateAvailable?.canUpdate==true&&userCheckAppVersion==false)
    {
      userCheckAppVersion = true;
      return true;
    }
    return false;
  }

  @override
  void goToStore(BuildContext context) {
    StoreRedirect.redirect(androidAppId: flavorConfigSettings?.applicationAndroidStoreId,
        iOSAppId: flavorConfigSettings?.applicationIOSStoreId);
  }
  
}