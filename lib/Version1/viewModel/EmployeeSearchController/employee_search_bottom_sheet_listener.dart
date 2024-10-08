
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/models/TeamModel/get_team_model.dart';

import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/Enums/employee_search_type.dart';
import 'global_selected_employee/employee_info_mapper.dart';

class EmployeeSearchBottomSheetListener extends GetChangeNotifier
{
  List<TeamDataList>? teamDataList;
  ApiStatus apiStatus = ApiStatus.nothing;
  int? selectedIndex;
  EmployeeSearchType? employeeSearchType;

  void searchEmployee(BuildContext context,String searchText) async{

    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getTeamApiCall(context,1,searchText);
    if(apiResponse.apiStatus==ApiStatus.done)
    {
      apiStatus = ApiStatus.done;
      teamDataList = apiResponse.data?.resultSet?.dataList;
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      apiStatus = ApiStatus.empty;
      teamDataList = null;
      notifyListeners();
    }
    else
    {
      apiStatus = ApiStatus.error;
      teamDataList = null;

      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }


  void updateSelectedIndex(int index) {
    if(selectedIndex == index)
    {
      selectedIndex = null;
    }
    else {
      selectedIndex = index;
    }
    notifyListeners();
  }

  getEmployee()
  {
    return EmployeeInfoMapper(
      employeeCode: teamDataList![selectedIndex!].employeeCode,
      companyCode: teamDataList![selectedIndex!].companyCode,
      picture: teamDataList![selectedIndex!].picture,
      name: teamDataList![selectedIndex!].fullName,
      jobTitle: teamDataList![selectedIndex!].jobTitle,
      localEmployee: false
    ).toJson();
  }


}
