import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:provider/provider.dart';

import '../../../Models/AuthModels/login_model.dart';
import '../../../Models/TeamModel/get_team_model.dart';
import '../../../Models/settings_model.dart';
import '../../../SharedPrefs/login_prefs.dart';

class GlobalSelectedEmployeeController extends GetChangeNotifier
{
  late EmployeeInfoMapper _employeeInfoMapper;
  EmployeeInfoMapper? _tempEmployeeInfoMapper;
  LoginResultSet? loginResultSet;
  CompanyData? companyData;
  ApiStatus apiStatus = ApiStatus.done;

  selectDefaultCurrentEmployee(BuildContext context)async
  {
    loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    companyData = CompanyData(index: settingsModelListener.getDefaultCompany(context, true),company: settingsModelListener.getDefaultCompany(context, false));
    resetEmployee();
  }

  resetEmployee()
  {
    _employeeInfoMapper = EmployeeInfoMapper(
        companyCode: loginResultSet?.headerInfo?.companyCode,
        employeeCode: loginResultSet?.headerInfo?.employeeCode,
        picture: loginResultSet?.headerInfo?.picture,
      name: loginResultSet?.headerInfo?.employeeName,
      cultureId: loginResultSet?.headerInfo?.cultureID,
      jobTitle: loginResultSet?.myProfile?.jobTitle,
      localEmployee: true
    );
    notifyListeners();
  }

  updateSelectedEmployee(Map<String,dynamic> value)
  {
    _employeeInfoMapper = EmployeeInfoMapper.fromJson(value);
    _employeeInfoMapper.cultureId = loginResultSet?.headerInfo?.cultureID;
    notifyListeners();
  }

  EmployeeInfoMapper getEmployee()
  {
    return _employeeInfoMapper;
  }

  void saveTempEmployee() {
    /// This helps to detect if user select a different employee. Let me explain
    /// See normally whenever user start a request he sees list page and from that list page he moves to form page to submit a request
    /// So lets say on moving to form page user selects a different employee now if user clicks back button then obviously we
    /// have to show user the different selected employee list. So what we are doing in short is if user changed a employee
    /// from form page and try to come back then we refresh the list page if employee code is same then we don't refresh
    /// list page. Below "specialPop" method check this
    _tempEmployeeInfoMapper = getEmployee();
  }

  void specialPop(BuildContext context) {
    Navigator.pop(context,_tempEmployeeInfoMapper?.employeeCode == getEmployee().employeeCode?false:true);
  }

  setCurrentCompany(CompanyData companyData)
  {
    this.companyData = companyData;
  }

  checkIfCurrentUserCompanyMatches()
  {
    if(_employeeInfoMapper.companyCode == companyData?.company.companyCode)
      {
        apiStatus = ApiStatus.done;
      }
    else
      {
        apiStatus = ApiStatus.notAllowed;
      }
    return true;
  }
}
class CompanyData
{
  CompanyList company;
  int index;
  CompanyData({required this.index,required this.company});
}