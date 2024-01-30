import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/settings_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/SharedPrefs/settings_pref.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/icons.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';

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

    // if(settingsResultSet.locationInfo?.empIsEnableCheckInOut==true)
    // {
    //   if(settingsResultSet.employeeCompanyData?.qrCode!=null&&settingsResultSet.employeeCompanyData!.qrCode!.isNotEmpty)
    //   {
    //     PrintLogs.print('qerrrrrr ${settingsResultSet.qrCode}');
    //     list.add(AttendanceTypesModel('QR Code Scanner',MdiIcons.qrcodeScan,false,AttendanceTypesEnum.qrCode));
    //   }
    //   else{
    //     PrintLogs.print('qr emptyyy');
    //   }
    // }
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

enum AttendanceTypesEnum
{
  simple,qrCode
}

class AttendanceTypesModel
{
  String header;
  String icon;
  int? color;
  bool selected;
  AttendanceTypesEnum attendanceTypesEnum;
  AttendanceTypesModel(this.header,this.color,this.icon,this.selected,this.attendanceTypesEnum);
}
