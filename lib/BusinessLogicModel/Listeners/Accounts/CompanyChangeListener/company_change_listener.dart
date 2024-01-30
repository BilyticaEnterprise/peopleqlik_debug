import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/loader_class.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/calling_dio_apis.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/settings_model.dart';
import 'package:provider/provider.dart';

import '../../../../UiPages/Reuse_Widgets/DropDowns/drop_down_header.dart';
import '../../../Models/AuthModels/login_model.dart';
import '../../../SharedPrefs/login_prefs.dart';

class CompanyChangeListener extends GetChangeNotifier with GetLoader
{
  List<CompanyList>? _companyList;
  late CompanyList selectedCompany;
  late int selectedIndex;
  DropDownDataController? companyDropDown;
  ApiStatus apiStatus = ApiStatus.nothing;

  void start(BuildContext context)
  {
    apiStatus = ApiStatus.started;
    notifyListeners();
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    _companyList = settingsModelListener.settingsResultSet?.companyList;
    companyDropDown = DropDownDataController('1',List.generate(_companyList?.length??0, (index) => _companyList?[index].displayName??''),);
    selectedCompany = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).companyData!.company;
    selectedIndex = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).companyData!.index;
    apiStatus = ApiStatus.done;
    notifyListeners();
  }


  dropDownCallBack(SelectedDropDown selectedDropDown) {
    selectedIndex = selectedDropDown.index!;
    selectedCompany = _companyList![selectedIndex];
  }

  void confirmPressed(BuildContext context)async {
    initLoader();
    LoginResultSet loginResultSet = LoginResultSet.fromJson(await jsonDecode(await UserInfoPrefs().getUserInfoPrefs()));
    await Provider.of<SettingsModelListener>(context,listen: false).updateSettingsApi(context,headers: GetHeaders().getChangeCompanyHeader(loginResultSet, selectedCompany.companyCode));
    Provider.of<GlobalSelectedEmployeeController>(context,listen: false).setCurrentCompany(CompanyData(index: selectedIndex, company: selectedCompany));
    await closeLoader();
    Navigator.pop(context);
  }
}