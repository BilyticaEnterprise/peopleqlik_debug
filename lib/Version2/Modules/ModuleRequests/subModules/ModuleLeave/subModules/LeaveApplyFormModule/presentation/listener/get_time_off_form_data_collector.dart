import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import 'package:peopleqlik_debug/Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/presentation/listener/get_time_off_leave_balance_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_get_form_mapper.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/utils/weekend_shifts.dart';
import 'package:peopleqlik_debug/utils/DropDowns/LegacyDropdown/header_dropdown.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:provider/provider.dart';


class GetLeaveFormModelListener extends GetChangeNotifier
{
  LeaveCreateFormResultSet? leaveCreateFormResultSet;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<String>? leaveTypeList = List.empty(growable: true);
  List<String>? halfLeaveList = List.empty(growable: true);
  int getSelectedIndexLeaveType=-1;
  //bool isFullDay = true;
  String optionalString = 'Select an option';

  Future? start(BuildContext context)
  async {

    apiStatus = ApiStatus.started;
    notifyListeners();
    resetTimeOff();
    Provider.of<GetLeaveBalanceJsonModelListener>(context,listen: false).resetBalance();
    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getLeaveFormDataApiCall(context,'?CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      leaveCreateFormResultSet = apiResponse.data!.resultSet;
      apiStatus = ApiStatus.done;
      /// Make leave type dropdown list because because of this list user have to select an option then he will get
      /// balance against each leave type
      makeLeaveType();
      /// Make leave reason dropdown list
      // makeReasonList();
      /// Make half leave dropdown list
      makeHalfList(context);

      makeShiftsWrapper();

      notifyListeners();
    }
    else
    {

      //PrintLogs.printLogs('tyytyterrrrr ${leaveCreateFormData!.code}');
      //ScaffoldMessenger?.of(context).showSnackBar(SnackBarDesign.getSessionSnackBar(context,leaveCreateFormData.message!,color: MyColor.colorRed));
      apiStatus = ApiStatus.error;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }

  }
  resetTimeOff()
  {
    getSelectedIndexLeaveType = -1;
    optionalString = 'Select an option';
    leaveTypeList = List.empty(growable: true);
    //leaveReasonList = List.empty(growable: true);
    halfLeaveList = List.empty(growable: true);
    apiStatus = ApiStatus.nothing;
    leaveCreateFormResultSet = null;
    notifyListeners();
  }
  void makeLeaveType()
  {
    leaveTypeList?.clear();
    leaveTypeList?.add(optionalString);
    for(var val in leaveCreateFormResultSet!.leaveType!)
    {
      leaveTypeList?.add(val.typeTitle!);
    }
  }

  void makeHalfList(BuildContext context)
  {
    halfLeaveList?.clear();
    halfLeaveList?.add(optionalString);
    halfLeaveList?.add('${CallLanguageKeyWords.get(context, LanguageCodes.fullDay)}');
    for(var val in leaveCreateFormResultSet!.halfLeaveDropdown!)
    {
      halfLeaveList?.add(val.value!);
    }
  }
  void updateSelectedLeaveTypeIndex(int index)
  {
    getSelectedIndexLeaveType = index;
  }

  void updateHalfList(BuildContext context, SelectedDropDown? selectedDropDown) {
    halfLeaveList?.clear();
    halfLeaveList?.add(optionalString);
    halfLeaveList?.add('${CallLanguageKeyWords.get(context, LanguageCodes.fullDay)}');
    if(leaveCreateFormResultSet!.leaveType![selectedDropDown!.index!].onlyApplyForFullDay==false)
    {
      for(var val in leaveCreateFormResultSet!.halfLeaveDropdown!)
      {
        halfLeaveList?.add(val.value!);
      }
    }
  }

  void makeShiftsWrapper() {
    List<ShiftInfo> tempShift = GetShifts.getAll();
    if(leaveCreateFormResultSet?.shiftInfo!=null&&leaveCreateFormResultSet!.shiftInfo!.isNotEmpty)
      {
        List<ShiftInfo> newShift = List.generate(tempShift.length, (index){
          int? i = leaveCreateFormResultSet?.shiftInfo?.indexWhere((element) => element.weekDayID == tempShift[index].weekDayID);
          if(i!=null&&i!=-1)
            {
              return leaveCreateFormResultSet!.shiftInfo![i];
            }
          else
            {
              return tempShift[index];
            }
        });
        leaveCreateFormResultSet!.shiftInfo = newShift;
        leaveCreateFormResultSet!.shiftInfo?.forEach((element) {

          PrintLogs.printLogs('lisasdasda ${element.offDay}');
        });
      }
    else
      {
        leaveCreateFormResultSet?.shiftInfo = tempShift;
      }

  }
}

