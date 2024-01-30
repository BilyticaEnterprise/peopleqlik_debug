import 'package:flutter/src/widgets/framework.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/pagination_classes.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:provider/provider.dart';

import '../../../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../ApiCalls/ApiGlobalModel/api_global_model.dart';
import '../../../../Models/TimeOffAndEnCashModel/shift_list_model.dart';
import '../../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';

class ShiftListListener extends GetChangeNotifier with GetPaginationClasses
{
  ApiStatus apiStatus = ApiStatus.nothing;

  @override
  passInitialData() {
    /// This method get called from start method
    dataList ??= List<ShiftListDataList>.empty(growable: true); /// If list null then create list
    receiveInitialData(dataList,ShiftListDataList()); /// pass this list to Pagination Mixin class
  }

  @override
  start(BuildContext context, ApiStatus status) async {
    passInitialData();

    apiStatus = status;
    incrementPage(); ///Whenever user hit the api default page number we set is 0. So to increment that page to 1 we call this method. Why? because our every list API start getting list from page number 1 so if this api again get called then it will increment to 1,2,3... ;

    if(apiStatus==ApiStatus.started)
    {
      resetList();  /// When first time api gets hit we clear our list and set our page number to 0
    }
    notifyListeners();

    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse? apiResponse = await GetApisUrlCaller().getShiftListApi(context,'?PageNo=$page&PerPage=10&EmployeeCode=${employeeInfoMapper.employeeCode}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      updatedResponseAtReachedEndList(apiStatus); /// Because when user reached to End of Page we show a empty CARD view then we have to remove that Empty card so we are removing that card here;
      apiStatus = ApiStatus.done;
      addAllList(apiResponse.data!.resultSet!.dataList.reversed.toList()); /// New data is inserting in list
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