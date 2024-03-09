import 'package:peopleqlik_debug/Version2/Modules/MobileBlockingModule/domain/models/device_add_remove_mapper.dart';

import '../../../ModuleSetting/domain/model/settings_model.dart';

class CurrentAndPreviousMobileMapper
{
  MobileInfoModel? currentMobile;
  List<DeviceList>? previousDeviceList;

  CurrentAndPreviousMobileMapper({this.currentMobile,this.previousDeviceList});
}