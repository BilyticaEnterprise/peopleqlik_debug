import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';

extension DeviceInfoGetter on SettingsModelListener
{
  createDeviceInfo()
  async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid)
    {
      androidDeviceInfo = (await deviceInfo.androidInfo);
    }
    else
    {
      iosDeviceInfo = (await deviceInfo.iosInfo);
    }
  }
}