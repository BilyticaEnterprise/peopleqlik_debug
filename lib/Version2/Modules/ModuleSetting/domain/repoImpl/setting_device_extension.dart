import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/moving_page_extensions.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/MobileBlockingModule/utils/page_state.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';

import '../../../MobileBlockingModule/domain/models/mobile_current_page_data.dart';

extension SettingDeviceChecks on SettingsModelListener{

  checkDeviceRestrict()async {

      if(settingsResultSet?.deviceRestricModel?.deviceList!=null && settingsResultSet!.deviceRestricModel!.deviceList!.isNotEmpty)
      {
        DeviceList? deviceList = await checkDeviceExist(settingsResultSet!.deviceRestricModel!.deviceList!);
        if(deviceList != null)
          {
            /// If your device is approved and activated by admin
            if(deviceList.approvalStatusID == 2 && deviceList.active == true)
              {
                moveToBottomPage();
              }
            else if(deviceList.approvalStatusID == 2 && deviceList.active == false)
            {
              /// If your device is approved but not activated by admin
              sendUserToBlockingPage(MobileBlocPagesCurrentDataMapper(mobileBlocPageState: MobilePageStateMobileBlocked<DeviceRestricModel>(data: settingsResultSet!.deviceRestricModel)));
            }
            else
            {
              /// If your device is not even approved or activated by admin
              sendUserToBlockingPage(MobileBlocPagesCurrentDataMapper(mobileBlocPageState: MobilePageStateAskAdminToApprove<DeviceRestricModel>(data: settingsResultSet!.deviceRestricModel)));
            }
          }
        else
          {
            checkValidations();
          }
      }
      else
        {
          sendUserToBlockingPage(MobileBlocPagesCurrentDataMapper(mobileBlocPageState: MobilePageStateFirstRegister<DeviceRestricModel>(data: settingsResultSet!.deviceRestricModel)));
        }
  }

  checkValidations()
  {
    if(checkDeviceRegisteredLength() >= settingsResultSet!.deviceRestricModel!.noOfDevice!)
    {
      if(settingsResultSet?.deviceRestricModel?.autoApproval == 2)
      {
        sendUserToBlockingPage(MobileBlocPagesCurrentDataMapper(mobileBlocPageState: MobilePageStateAutoApproveDeactivateAndRegister<DeviceRestricModel>(data: settingsResultSet!.deviceRestricModel)));
      }
      else
      {
        sendUserToBlockingPage(MobileBlocPagesCurrentDataMapper(mobileBlocPageState: MobilePageStateLimitReached<DeviceRestricModel>(data: settingsResultSet!.deviceRestricModel)));
      }
    }
    else
    {
      sendUserToBlockingPage(MobileBlocPagesCurrentDataMapper(mobileBlocPageState: MobilePageStateNotRegister<DeviceRestricModel>(data: settingsResultSet!.deviceRestricModel)));
    }
  }

  int checkDeviceRegisteredLength()
  {
    int length = 0;
    try{
      length = settingsResultSet?.deviceRestricModel?.deviceList?.where((element) => element.active == true&&element.approvalStatusID == 2).toList().length??0;
    }
    catch(e){}
    return length;
  }

  sendUserToBlockingPage(MobileBlocPagesCurrentDataMapper mobileBlocPagesCurrentDataMapper)
  {
    GetNavigatorStateContext.navigatorKey.currentState?.pushNamedAndRemoveUntil(CurrentPage.mobileBlockingPage, (route) => false,arguments: mobileBlocPagesCurrentDataMapper);
  }

  Future<DeviceList?> checkDeviceExist(List<DeviceList>? deviceList)async
  {
    String? deviceId;
    if(Platform.isAndroid)
      {
        deviceId = androidDeviceInfo?.id;
      }
    else
      {
        deviceId = iosDeviceInfo?.identifierForVendor;
      }

    if(deviceId != null)
      {
        int? index = deviceList?.indexWhere((element) => element.deviceID == deviceId);
        if(index != null && index != -1)
          {
            return deviceList?[index];
          }
      }
    return null;
  }
}
