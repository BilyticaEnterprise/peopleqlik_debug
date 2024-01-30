import 'package:flutter/src/widgets/framework.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiCallers/apis_url_caller.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/ApiGlobalModel/api_global_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import 'package:provider/provider.dart';

import '../../../../ApiCalls/ApiCallers/show_error.dart';
import '../../../../Enums/apistatus_enum.dart';
import '../../../../Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';
import '../../../../Models/TimeOffAndEnCashModel/shift_detail_model.dart';
import '../../../../Models/TimeOffAndEnCashModel/shift_list_model.dart';
import '../../../Approvals/get_approval_list.dart';

class ShiftDetailListener extends GetChangeNotifier
{
  int? documentId;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<List<ApprovalHistory>>? approvalsList;
  List<ApprovalHistory>? uniqueList;
  ShiftRequestDetail? requestDetail;

  ShiftDetailListener(this.documentId);

  void start(BuildContext context)async {
    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse apiResponse = await GetApisUrlCaller().getShiftDetail(context, '?RequestMID=$documentId');
    if(apiResponse.apiStatus == ApiStatus.done&&apiResponse.data.resultSet.requestDetail!=null&&apiResponse.data.resultSet.requestDetail.isNotEmpty)
    {
      requestDetail = apiResponse.data.resultSet.requestDetail.first;
      List<String?>? offDaysNameList = Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.weekDayList?.map((e) => (requestDetail?.offDays?.contains(e.weekDayID)==true)?e.dayName:null).toList();
      offDaysNameList?.removeWhere((element) => element==null);
      requestDetail?.offDaysName = offDaysNameList;
      uniqueList = apiResponse.data.resultSet.approvalHistory;
      approvalsList = getApprovalHistory(uniqueList);
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