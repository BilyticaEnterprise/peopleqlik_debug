import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:provider/provider.dart';

import '../../../../AbstractClasses/pagination_classes.dart';
import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../Models/TimeRegulationModels/time_regulation_model.dart';
import '../../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';


class TimeRegulationListListener extends GetChangeNotifier with GetPaginationClasses
{
  ApiStatus apiStatus = ApiStatus.nothing;
  late int _typeId;

  int get typeId => _typeId;

  set typeId(int value) {
    _typeId = value;
  }

  @override
  passInitialData() {
    /// This method get called from start method
    dataList ??= List<TimeRegulationDataList>.empty(growable: true); /// If list null then create list
    receiveInitialData(dataList,TimeRegulationDataList()); /// pass this list to Pagination Mixin class
  }

  @override
  start(BuildContext context, ApiStatus status)async {

    passInitialData();

    apiStatus = status;
    incrementPage(); ///Whenever user hit the api default page number we set is 0. So to increment that page to 1 we call this method. Why? because our every list API start getting list from page number 1 so if this api again get called then it will increment to 1,2,3... ;

    if(apiStatus==ApiStatus.started)
    {
      resetList();  /// When first time api gets hit we clear our list and set our page number to 0
    }
    notifyListeners();

    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse apiResponse = await GetApisUrlCaller().getTimeRegulationOfficeApiCall(context, page, companyCode: employeeInfoMapper.companyCode,employeeCode: employeeInfoMapper.employeeCode,typeId: typeId);
    if(apiResponse.apiStatus == ApiStatus.done)
      {
        updatedResponseAtReachedEndList(apiStatus); /// Because when user reached to End of Page we show a empty CARD view then we have to remove that Empty card so we are removing that card here;
        apiStatus = ApiStatus.done;
        addAllList(apiResponse.data!.resultSet!.dataList!.reversed.toList()); /// New data is inserting in list
        notifyListeners();

      }
    else if(apiResponse.apiStatus == ApiStatus.empty&&dataList!=null&&dataList!.isNotEmpty)
    {
      updatedResponseAtReachedEndList(apiStatus); /// Again removing empty card here as mentioned above
      decrementPage(); /// Because no new data was found so we have to minus the page number
      apiStatus = ApiStatus.done;
      notifyListeners();
    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      apiStatus = ApiStatus.empty;
      updatedResponseAtReachedEndList(apiStatus); /// Again removing empty card here as mentioned above
      makeListNull(); /// But making list null
      notifyListeners();
    }
    else
    {
      apiStatus = ApiStatus.error;
      updatedResponseAtReachedEndList(apiStatus); /// Again removing empty card here as mentioned above
      makeListNull(); /// But making list null
      notifyListeners();
      ShowErrorMessage.show(apiResponse);

    }

  }

  @override
  reachedEndList(bool reached) {
    reachedEndPage(reached);
    notifyListeners();
  }

}