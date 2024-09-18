import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';

import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../../Version1/models/TeamModel/get_team_model.dart';
import '../../../../../../../../../Version1/models/TimeOffAndEnCashModel/overtime_filter_mapper.dart';
import '../../../../../../../../../Version1/models/call_setting_data.dart';
import '../../../../../../../ModuleSetting/domain/model/settings_model.dart';
import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class OvertimeFilterListener extends GetChangeNotifier
{
  List<TeamDataList>? employeeList;
  DropDownDataController? overTimeTypeDropDown;
  ObjOvertimeTypes? selectedObjOvertimeTypes;
  List<ObjOvertimeTypes>? _objOvertimeTypesList;
  DateTime? startDate;
  DateTime? endDate;
  late SettingsModelListener _settingsModelListener;
  int? loggedInUserEmployeeCode;

  OvertimeFilterListener(BuildContext context,{OvertimeFilterMapper? overtimeFilterMapper}){
    _settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    _objOvertimeTypesList = _settingsModelListener.settingsResultSet?.objOvertimeTypes;
    loggedInUserEmployeeCode = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).loginResultSet?.headerInfo?.employeeCode;
    overTimeTypeDropDown = DropDownDataController('1', List.generate(_objOvertimeTypesList?.length??0, (index) => _settingsModelListener.settingsResultSet?.objOvertimeTypes?[index].typeName??''));
    if(overtimeFilterMapper!=null)
      {
        employeeList = overtimeFilterMapper.employeeList;
        startDate = overtimeFilterMapper.startDate;
        endDate = overtimeFilterMapper.endDate;
        selectedObjOvertimeTypes = _objOvertimeTypesList?.firstWhere((element) => element.typeID == overtimeFilterMapper.typeId);
      }
  }

  getIndex({int? typeId})
  {
    return _objOvertimeTypesList?.indexWhere((element) => element.typeID == typeId);
  }

  void updateSelectedEmployeeList(BuildContext context,List<TeamDataList>? employeeList) {
    if(employeeList!=null&&employeeList.isNotEmpty)
      {
        if(employeeList.indexWhere((element) => element.employeeCode==loggedInUserEmployeeCode)==-1)
        {
          this.employeeList = employeeList;
          notifyListeners();
        }
        else
        {
          this.employeeList = [employeeList.firstWhere((element) => element.employeeCode==loggedInUserEmployeeCode)];
          SnackBarDesign.warningSnack(CallLanguageKeyWords.get(context, LanguageCodes.rememberOverTime));
          notifyListeners();
        }
      }
    else
      {
        employeeList = null;
        notifyListeners();
      }
  }

  void selectedDates(List<DateTime?> dates) {
    if(dates.length>1)
      {
        startDate = DateTime(dates[0]!.year,dates[0]!.month,dates[0]!.day);
        endDate = DateTime(dates[1]!.year,dates[1]!.month,dates[1]!.day);
      }
    else
      {
        startDate = DateTime(dates[0]!.year,dates[0]!.month,dates[0]!.day);
        endDate = DateTime(dates[0]!.year,dates[0]!.month,dates[0]!.day);
      }
  }

  getEmployeeListAndDates()
  {
    return OvertimeFilterMapper(employeeList: employeeList,startDate: startDate,endDate: endDate,typeId: selectedObjOvertimeTypes?.typeID).toJson();
  }

  void submit(BuildContext context) {
    if(employeeList!=null&&startDate!=null&&endDate!=null&&selectedObjOvertimeTypes!=null) {
      Navigator.pop(context,getEmployeeListAndDates());
    }
    else
      {
        SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.mustSelectBothDateEmployeeError));
      }
  }

  dropDownCallBack(SelectedDropDown selectedDropDown) {
    selectedObjOvertimeTypes = _settingsModelListener.settingsResultSet?.objOvertimeTypes?[selectedDropDown.index!];
    employeeList = null;
    notifyListeners();
  }
}