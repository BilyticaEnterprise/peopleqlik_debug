import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/settings_pref.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import '../../domain/model/attendance_type_model.dart';
import '../../utils/enums/attendance_type_enums.dart';

class AttendanceTypesCollector extends GetChangeNotifier
{
  List<AttendanceTypesModel> list = List.empty(growable: true);
  AttendanceTypesModel? attendanceTypesModel;
  AttendanceTypesEnum? attendanceTypesEnum;

  void attendanceTypesSetUp(BuildContext context) async
  {
    list.clear();

    SettingsResultSet settingsResultSet = SettingsResultSet.fromJson(await jsonDecode(await SettingsPrefs().getSettingsPrefs()));
    if(settingsResultSet.locationInfo?.manualAttendance == true)
      {
        list.add(AttendanceTypesModel('${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra7AttendanceTypeCollector)}',MyColor.colorA1,SvgPicturesData.manual,false,AttendanceTypesEnum.simple));
      }
    notifyListeners();
  }

  void setAttendanceType(int index)
  {
    for(int x=0;x<list.length;x++)
    {
      if(x!=index)
      {
        list[x].selected=false;
      }
    }
    if(list[index].selected) {
      list[index].selected = false;
    } else {
      list[index].selected = true;
      attendanceTypesEnum = list[index].attendanceTypesEnum;
    }
    attendanceTypesModel = list[index];
    notifyListeners();
  }
}
