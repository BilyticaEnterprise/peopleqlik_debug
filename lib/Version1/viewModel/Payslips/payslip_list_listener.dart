import 'dart:async';
import 'dart:convert';

import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/models/AuthModels/company_url_get_model.dart';
import 'package:peopleqlik_debug/Version1/models/PaysSlipApprovalsRequest/get_payslip_list.dart';
import 'package:peopleqlik_debug/Version1/models/PaysSlipApprovalsRequest/get_payslip_month.dart';
import 'package:peopleqlik_debug/utils/SharedPrefs/company_urls_prefs.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../utils/pagination_logic_utils/pagination_classes.dart';
import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import '../EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';


class PayslipListModelListener extends GetChangeNotifier with GetPaginationClasses
{
  ApiStatus apiStatus = ApiStatus.nothing;

  @override
  resetInitialData() {
    /// This method get called from start method
    dataList ??= List<GetPaySlipDataList>.empty(growable: true); /// If list null then create list
    receiveInitialData(dataList,GetPaySlipDataList()); /// pass this list to Pagination Mixin class
  }

  @override
  Future? start(BuildContext context, ApiStatus status)
  async {

    resetInitialData();

    apiStatus = status;
    incrementPage(); ///Whenever user hit the api default page number we set is 0. So to increment that page to 1 we call this method. Why? because our every list API start getting list from page number 1 so if this api again get called then it will increment to 1,2,3... ;

    if(apiStatus==ApiStatus.started)
    {
      resetList();  /// When first time api gets hit we clear our list and set our page number to 0
    }
    notifyListeners();
    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getPlaySlipListRange(context,'?CompanyCode=${employeeInfoMapper.companyCode}&EmployeeCode=${employeeInfoMapper.employeeCode}&PageNo=$page&PerPage=10');

    // GetPayslipListData? getPayslipListData = await GetPayslipListApiCall().callApi(context,page);
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      updatedResponseAtReachedEndList(apiStatus); /// Because when user reached to End of Page we show a empty CARD view then we have to remove that Empty card so we are removing that card here;
      apiStatus = ApiStatus.done;
      addAllList(apiResponse.data!.resultSet!.dataList); /// New data is inserting in list
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
  void reachedEndList(bool reached)
  {
    reachedEnd = reached;
    notifyListeners();
  }
}

