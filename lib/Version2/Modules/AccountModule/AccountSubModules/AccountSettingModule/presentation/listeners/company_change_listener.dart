import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/headers.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/login_prefs.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader_class.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/data/repoImpl/api_client_repo_impl.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:provider/provider.dart';

import '../../../../../../../Version1/Models/AuthModels/login_model.dart';
import 'package:peopleqlik_debug/utils/DropDowns/drop_down_header.dart';

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