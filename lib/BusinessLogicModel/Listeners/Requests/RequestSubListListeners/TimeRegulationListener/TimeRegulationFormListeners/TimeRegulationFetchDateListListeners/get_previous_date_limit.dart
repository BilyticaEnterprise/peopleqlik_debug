import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../src/date_formats.dart';
import '../../../../../../../src/snackbar_design.dart';
import '../../../../../SettingListeners/settings_listeners.dart';

class GetPreviousDaysLimit
{
  get(BuildContext context)
  {
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);

    if(int.parse(settingsModelListener.settingsResultSet?.previousHoursLimit?.settingIdOrNameValue??'0')>0)
    {
      return DateTime.now().subtract(Duration(hours: int.parse(settingsModelListener.settingsResultSet?.previousHoursLimit?.settingIdOrNameValue??'0')));
    }
    else
    {
      if(settingsModelListener.settingsResultSet?.cuttofDate!=null&&settingsModelListener.settingsResultSet!.cuttofDate!.isNotEmpty)
      {
        return GetDateFormats().getMonthDay(settingsModelListener.settingsResultSet!.cuttofDate!);
      }
      else
      {
        SnackBarDesign.errorSnack('Cut off date cannot be null. Server error');
        return null;
      }
    }
  }
}