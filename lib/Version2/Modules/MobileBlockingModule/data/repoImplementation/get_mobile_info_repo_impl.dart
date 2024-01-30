import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:peopleqlik_debug/Version2/Modules/MobileBlockingModule/domain/models/mobile_info_model.dart';

import '../../domain/repository/get_mobile_info_repository.dart';

class GetMobileInfoRepoImpl extends GetMobileInfoRepository
{
  @override
  Future<MobileInfoModel?> getCurrentMobileInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isIOS)
    {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print('Running on ${iosInfo.utsname.machine}');  // e.g. "iPod7,1"
      return MobileInfoModel(
          deviceID: iosInfo.identifierForVendor,
          name: iosInfo.name,
          deviceType: 'IOS',
          systemVersion: iosInfo.systemVersion,
          version: iosInfo.utsname.version,
          sysName: iosInfo.utsname.sysname,
          brand: iosInfo.utsname.machine
      );

    }
    else if(Platform.isAndroid)
    {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"
      return MobileInfoModel(
          deviceID: androidInfo.id,
          name: androidInfo.model,
          deviceType: 'Android',
          systemVersion: androidInfo.product,
          version: androidInfo.version.release,
          sysName: androidInfo.product,
          brand: androidInfo.brand
      );
    }
    return null;
  }

}