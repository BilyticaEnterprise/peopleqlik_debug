import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:provider/provider.dart';

import '../../../../ApiCalls/ApiCallers/apis_url_caller.dart';
import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../ApiCalls/ApiGlobalModel/api_global_model.dart';
import '../../../../AppConstants/app_constants.dart';
import '../../../../Enums/apistatus_enum.dart';
import '../../../../Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';
import '../../../../Models/PaysSlipApprovalsRequest/get_approvals_list.dart';
import '../../../../Models/TimeOffAndEnCashModel/shift_detail_model.dart';
import '../../../Approvals/get_approval_list.dart';
import '../../../SettingListeners/settings_listeners.dart';

class AcceptanceRejectionShiftApproval extends GetChangeNotifier
{
  ApiStatus apiStatus = ApiStatus.nothing;
  ShiftRequestDetail? requestDetail;
  List<List<ApprovalHistory>>? approvalsList;
  List<ApprovalHistory>? uniqueList;

  void start(BuildContext context, ApprovalResultSet? approvalResultSet)async
  {
    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse apiResponse = await GetApisUrlCaller().getShiftApprovalDetailsApiCall(context,'?ScreenID=${approvalResultSet?.screenID}&CompanyCode=${approvalResultSet?.companyCode}${AppConstants.getDocumentNumber(approvalResultSet!.documentNo!)}');
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      requestDetail = apiResponse.data.resultSet.dataList.first;
      List<String?>? offDaysNameList = Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.weekDayList?.map((e) => (requestDetail?.offDays?.contains(e.weekDayID)==true)?e.dayName:null).toList();
      offDaysNameList?.removeWhere((element) => element==null);
      requestDetail?.offDaysName = offDaysNameList;
      if(apiResponse.data.resultSet.approvalHistory!=null)
      {
        uniqueList = apiResponse.data.resultSet.approvalHistory;
        approvalsList = getApprovalHistory(uniqueList);
      }

      apiStatus = ApiStatus.done;
      notifyListeners();
    }
    else
    {
      apiStatus = apiResponse.apiStatus!;
      notifyListeners();
      ShowErrorMessage.show(apiResponse);
    }
  }

}