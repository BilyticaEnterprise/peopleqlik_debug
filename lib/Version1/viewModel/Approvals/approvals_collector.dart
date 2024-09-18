import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/pagination_logic_utils/pagination_classes.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/models/ApprovalsModel/get_approvals_list.dart';
import 'package:peopleqlik_debug/utils/calendars/calender_time_widget.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import '../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import '../../../Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import '../../../utils/AppConstants/app_constants.dart';

class ApprovalCollector extends GetChangeNotifier with GetPaginationClasses
{
  String optionalString = 'Select an option';
  PanelController? panelController;
  String? startDate,endDate;
  int? screenId = 0;
  bool? clearFilter = false;
  int? _statusId;
  ApiStatus apiStatus = ApiStatus.nothing;
  bool? pendingButton = false;
  bool? approveButton = false;
  bool? rejectionButton = false;
  ApprovalPageEnum approvalPageEnum = ApprovalPageEnum.pending;
  ApprovalPageEnum approvalFiltersEnum = ApprovalPageEnum.nothing;
  Future<void> updatePage(BuildContext context,ApprovalPageEnum approvalPageEnum,ApiStatus apiStatus)
  async {
    this.approvalPageEnum = approvalPageEnum;
    notifyListeners();
    if(approvalPageEnum == ApprovalPageEnum.pending)
    {
      _statusId = 1;
      start(context, apiStatus);
    }
    else if(approvalPageEnum == ApprovalPageEnum.approve)
    {
      _statusId = 2;
      start(context, apiStatus);
    }
    else{
      _statusId = 3;
      start(context, apiStatus);
    }
  }

  @override
  resetInitialData() {
    /// This method get called from start method
    dataList ??= List<ApprovalResultSet>.empty(growable: true); /// If list null then create list
    receiveInitialData(dataList,ApprovalResultSet()); /// pass this list to Pagination Mixin class
  }

  @override
  start(BuildContext context,ApiStatus status)
  async {
    resetInitialData();

    apiStatus = status;
    incrementPage(); ///Whenever user hit the api default page number we set is 0. So to increment that page to 1 we call this method. Why? because our every list API start getting list from page number 1 so if this api again get called then it will increment to 1,2,3... ;

    if(apiStatus==ApiStatus.started)
    {
      resetList();  /// When first time api gets hit we clear our list and set our page number to 0
    }
    notifyListeners();

    String? startDate;
    String? endDate;
    if(approvalPageEnum == approvalFiltersEnum || approvalFiltersEnum == ApprovalPageEnum.nothing)
      {
        startDate = this.startDate;
        endDate = this.endDate;
      }
    else
      {
        startDate = null;
        endDate = null;
      }

    ApiResponse? apiResponse = await UseCaseGetApisUrlCaller().getApprovalListApi(context,'?ScreenID=$screenId&DocNo=&StatusID=$_statusId&DocNo&FromDate=$startDate&ToDate=$endDate&PageNo=$page&PerPage=10');
    //GetApprovalsListData? getApprovalsListData = await GetApprovalsListApiCall().callApi(context,_statusId,startDate,endDate,screenId,page);
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      updatedResponseAtReachedEndList(apiStatus); /// Because when user reached to End of Page we show a empty CARD view then we have to remove that Empty card so we are removing that card here;
      apiStatus = ApiStatus.done;
      addAllList(apiResponse.data!.resultSet!.dataList); /// New data is inserting in list
      notifyListeners();
      clearFilter = false;

    }
    else if(apiResponse.apiStatus == ApiStatus.empty&&dataList!=null&&dataList!.isNotEmpty)
    {
      updatedResponseAtReachedEndList(apiStatus); /// Again removing empty card here as mentioned above
      decrementPage(); /// Because no new data was found so we have to minus the page number
      apiStatus = ApiStatus.done;
      clearFilter = false;
      notifyListeners();

    }
    else if(apiResponse.apiStatus == ApiStatus.empty)
    {
      apiStatus = ApiStatus.empty;
      updatedResponseAtReachedEndList(apiStatus); /// Again removing empty card here as mentioned above
      makeListNull(); /// But making list null
      clearFilter = false;
      notifyListeners();
      if(apiResponse.data!=null&&apiResponse.data?.errorMessage!=null&&apiResponse.data?.errorMessage!=null)
        {
          SnackBarDesign.errorSnack('${apiResponse.data?.errorMessage}');
        }
    }
    else
    {
      //clearListIfTabButtonChanged();
      apiStatus = ApiStatus.error;
      updatedResponseAtReachedEndList(apiStatus); /// Again removing empty card here as mentioned above
      makeListNull(); /// But making list null
      clearFilter = false;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }

  }

  void updateFilters(BuildContext context,String? startDate,String? endDate,ApprovalPageEnum? approvalPageEnum, int? screenId)
  {
    this.startDate = startDate;
    this.endDate = endDate;
    this.screenId = screenId;
    approvalFiltersEnum = approvalPageEnum!;
    updatePage(context,approvalPageEnum,ApiStatus.started);
  }

  void clearFilters(BuildContext context) {
    startDate = null;
    endDate = null;
    approvalPageEnum = ApprovalPageEnum.pending;
    approvalFiltersEnum = ApprovalPageEnum.nothing;
    screenId = 0;
    clearFilter = true;
    updatePage(context,approvalPageEnum,ApiStatus.started);
  }
  @override
  void updateStep(bool event,BuildContext context)
  {
   // print('reaschenddd $reachedEnd $event');
    if(reachedEnd==false&&event==true)
    {
     // print('reaschenddd $reachedEnd');
      dataList?.add(ApprovalResultSet());
      reachedEndList(true);
      _statusId = approvalPageEnum==ApprovalPageEnum.pending?1:approvalPageEnum==ApprovalPageEnum.approve?2:3;
      start(context,ApiStatus.pagination);
    }
  }
  @override
  void reachedEndList(bool reached)
  {
    reachedEnd = reached;
    notifyListeners();
  }

  @override
  void dispose() {
    dataList = null;
    optionalString = '';
    startDate = null;
    endDate = null;
    clearFilter = null;
    apiStatus = ApiStatus.nothing;
    approvalPageEnum = ApprovalPageEnum.pending;
    approvalFiltersEnum = ApprovalPageEnum.nothing;
    super.dispose();
  }
/// To Fix bug: If user click approve Tab button and then instantly click pending Tab button list was populating
  /// twice so to fix that bug need this method
  void clearListIfTabButtonChanged() {
    if(approvalPageEnum == ApprovalPageEnum.pending&&pendingButton==true)
    {
      dataList?.clear();
      pendingButton=false;
    }
    else if(approvalPageEnum == ApprovalPageEnum.approve&&approveButton==true)
    {
      dataList?.clear();
      approveButton=false;
    }
    else if(approvalPageEnum == ApprovalPageEnum.rejected&&rejectionButton==true)
    {
      dataList?.clear();
      rejectionButton=false;
    }
  }


  checkIfApiHitsAlready()
  {
    return apiStatus != ApiStatus.started;
  }

  String getPageName(int? screenID)
  {
    if(screenID == GetVariable.requestScreenId)
      {
        return CurrentPage.RequestDetailPage;
      }
    else if(screenID == AppConstants.requestEnCashmentScreenID)
    {
      return CurrentPage.RequestEncashmentDetailPage;
    }
    else if(screenID == AppConstants.requestSeparationScreenID)
    {
      return CurrentPage.RequestSeparationDetailPage;
    }
    else if(screenID == AppConstants.requestTimeRegulationScreenID)
    {
      return CurrentPage.TimeRegulationAndMovementDetailPage;
    }
    else if(screenID == AppConstants.requestOverTimeScreenID)
    {
      return CurrentPage.OvertimeDetailPage;
    }
    else if(screenID == AppConstants.requestShiftScreenID)
    {
      return CurrentPage.ShiftDetailPage;
    }
    else if(screenID == AppConstants.requestLeaveScreenID)
    {
      return CurrentPage.TimeOffDetailPage;
    }
    else
      {
        return CurrentPage.ApprovalAcceptanceRejectionPage;
      }

  }
}
enum ApprovalPageEnum
{
  nothing,pending,approve,rejected
}