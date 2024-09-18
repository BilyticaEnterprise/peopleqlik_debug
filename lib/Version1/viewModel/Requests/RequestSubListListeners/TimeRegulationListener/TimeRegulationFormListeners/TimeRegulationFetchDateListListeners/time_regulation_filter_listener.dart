import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/TimeRegulationListener/MovementSlipFormListeners/movement_slip_form_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/TimeRegulationListener/TimeRegulationFormListeners/TimeRegulationFetchDateListListeners/time_regulation_form_list_listener.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:provider/provider.dart';

import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../utils/date_formats.dart';
import '../../../../../../../utils/snackbar_design.dart';
import '../../../../../../../Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'get_previous_date_limit.dart';

class TimeRegulationFilterListener extends GetChangeNotifier
{
  DropDownDataController? typeDropDown;
  List<AllStatus>? allStatusList;
  int selectedIndex = 0;
  FilterData? filterData;
  DateTime? minDate;

  TimeRegulationFilterListener(BuildContext context)
  {
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    minDate = GetPreviousDaysLimit().get(context);

    allStatusList = List.generate(settingsModelListener.settingsResultSet?.allStatus?.length??0, (index) => settingsModelListener.settingsResultSet!.allStatus![index]);
    allStatusList?.insert(0, AllStatus(statusID: 0,statusName: 'All Transactions'));
    selectedIndex = 0;
    typeDropDown = DropDownDataController(MovementSlipType.type, List.generate(allStatusList?.length??0, (index) => allStatusList?[index].statusName??''));
    // PrintLogs.printLogs('printasdas ${typeDropDown?.list}');

  }
  updateFilter(FilterData? filterData)
  {
    this.filterData = filterData;
  }
  void selectedDates(List<DateTime?> dates) {
    if(dates.isNotEmpty&&dates.length==1)
    {
      filterData?.fromTime = GetDateFormats().getMonthFormatDay(DateTime(dates.first!.year,dates.first!.month,dates.first!.day));
      filterData?.toTime = GetDateFormats().getMonthFormatDay(DateTime(dates.first!.year,dates.first!.month,dates.first!.day));
      //   endDate = null;
    }
    else if(dates.isNotEmpty&&dates.length==2)
    {
      filterData?.toTime = GetDateFormats().getMonthFormatDay(DateTime(dates[1]!.year,dates[1]!.month,dates[1]!.day));
    }
  }

  dropDownCallBack(SelectedDropDown selectedDropDown) {
    selectedIndex = selectedDropDown.index!;
    filterData?.statusId = allStatusList?[selectedDropDown.index!].statusID;
  }
}