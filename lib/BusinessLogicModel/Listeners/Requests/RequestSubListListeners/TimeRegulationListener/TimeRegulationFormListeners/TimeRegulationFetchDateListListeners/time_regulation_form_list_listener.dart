
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:provider/provider.dart';

import '../../../../../../../src/snackbar_design.dart';
import '../../../../../../AbstractClasses/pagination_classes.dart';
import '../../../../../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../../../ApiCalls/ApiGlobalModel/api_global_model.dart';
import '../../../../../../Models/TimeRegulationModels/time_regulation_monthly_model.dart';
import '../../../../../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../SettingListeners/settings_listeners.dart';
import 'get_previous_date_limit.dart';

class TimeRegulationFormFetchListListener extends GetChangeNotifier with GetPaginationClasses
{
  ApiStatus apiStatus = ApiStatus.nothing;
  FilterData? filterData;

  TimeRegulationFormFetchListListener(BuildContext context)
  {
    DateTime? minDate = GetPreviousDaysLimit().get(context);

    DateTime fromDateTime = DateTime.now();
    if(minDate!=null)
      {
        if(DateTime.now().difference(minDate).inHours>240)
          {
            fromDateTime = fromDateTime.subtract(const Duration(hours: 240));
          }
        else
          {
            fromDateTime = minDate;
          }
      }
    DateTime toDateTime = DateTime.now();
    filterData = FilterData(
      statusId: 0,
      fromTime: GetDateFormats().getMonthFormatDay(DateTime(fromDateTime.year,fromDateTime.month,fromDateTime.day)),
      toTime: GetDateFormats().getMonthFormatDay(DateTime(toDateTime.year,toDateTime.month,toDateTime.day)),
    );
  }
  updateFilters(BuildContext context,FilterData? filterData)
  {
    this.filterData = filterData;
    start(context,ApiStatus.started);
  }

  @override
  passInitialData() {
    /// This method get called from start method
    dataList ??= List<TimeRegulationMonthlyDataList>.empty(growable: true); /// If list null then create list
    receiveInitialData(dataList,TimeRegulationMonthlyDataList()); /// pass this list to Pagination Mixin class
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

    ApiResponse apiResponse = await GetApisUrlCaller().getMonthlyTimeRegulationApiCall(context, '?StatusID=${filterData?.statusId}&Fromdate=${filterData?.fromTime}&Todate=${filterData?.toTime}&PageNo=$page&PerPage=10&CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      PrintLogs.printLogs('datasasd ${apiResponse.data?.resultSet?.dataList}');
      updatedResponseAtReachedEndList(apiStatus); /// Because when user reached to End of Page we show a empty CARD view then we have to remove that Empty card so we are removing that card here;
      apiStatus = ApiStatus.done;
      addAllList(apiResponse.data!.resultSet!.dataList!.reversed.toList()); /// New data is inserting in list
      includeStatusList();
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

  void includeStatusList()
  {
    for(int x=0;x<dataList!.length;x++)
      {
        dataList?[x].statusList = dataList?[x].statusName?.split(',');
      }
  }
  void resetAll(BuildContext context) {
    page = 0;
    reachedEnd = false;
    dataList = null;
    start(context, ApiStatus.started);
  }

  @override
  reachedEndList(bool reached) {
    reachedEndPage(reached);
    notifyListeners();
  }



}
class FilterData
{
  String? fromTime,toTime;
  int? statusId;
  FilterData({this.statusId = 0,this.fromTime, this.toTime});
}