import 'package:flutter/src/widgets/framework.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:provider/provider.dart';

import '../../../../../Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import '../../../../Models/ApprovalsModel/get_approvals_detail_model.dart';
import '../../../../Models/TimeOffAndEnCashModel/shift_detail_model.dart';
import '../../../../Models/TimeOffAndEnCashModel/shift_list_model.dart';
import '../../../Approvals/get_approval_list.dart';

class ShiftDetailListener extends GetChangeNotifier
{
  String? documentId;
  ApiStatus apiStatus = ApiStatus.nothing;
  List<List<ApprovalHistory>>? approvalsList;
  List<ApprovalHistory>? uniqueList;
  ShiftRequestDetail? requestDetail;

  ShiftDetailListener(this.documentId);

  void start(BuildContext context)async {
    apiStatus = ApiStatus.started;
    notifyListeners();

    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getShiftDetail(context, '?RequestMID=$documentId');
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