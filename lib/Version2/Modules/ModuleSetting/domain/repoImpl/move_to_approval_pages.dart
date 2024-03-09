import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';

import '../../../../../Version1/Models/ApprovalsModel/approval_detail_mapper.dart';
import '../../../../../Version1/Models/ApprovalsModel/approval_result_set_data.dart';
import '../../../../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_appceptance_leave_request_page.dart';
import '../../../../../configs/routing/pages_name.dart';
import '../../../../../mainCommon.dart';
import '../../../../../utils/strings.dart';
import '../../../FCMModule/domain/models/fcm_notification_received_model.dart';

extension MoveToApprovalPages on SettingsModelListener
{
  void moveToApprovalPages(NotificationReceivedModel? notificationReceivedModel) {
    BuildContext? context = GetNavigatorStateContext.navigatorKey.currentState?.context;
    if(context!=null)
    {
      int screenID = int.parse(notificationReceivedModel?.screenData?.screenID??'0');
      switch(screenID)
      {
        case GetVariable.leaveScreenId:
          Navigator.pushNamed(context, CurrentPage.ApprovalAcceptanceRejectionPage,arguments: ApprovalResultSetData(getApprovalDetailMapper(notificationReceivedModel),true));
          break;
        case GetVariable.requestScreenId:
          Navigator.pushNamed(context, CurrentPage.ApprovalRequestFormPage,arguments: ApprovalRequestDetailData(notificationReceivedModel?.extraData?.requestCode,notificationReceivedModel?.screenData?.managerID,true,getApprovalDetailMapper(notificationReceivedModel)));
          break;
        case AppConstants.requestEnCashmentScreenID:
          Navigator.pushNamed(context, CurrentPage.ApprovalAcceptanceRejectionEncashmentPage,arguments: ApprovalResultSetData(getApprovalDetailMapper(notificationReceivedModel),true));
          break;
        case AppConstants.requestSeparationScreenID:
          Navigator.pushNamed(context, CurrentPage.ApprovalAcceptanceRejectionSeparationPage,arguments: ApprovalResultSetData(getApprovalDetailMapper(notificationReceivedModel),true));
          break;
        case AppConstants.requestTimeRegulationScreenID:
          Navigator.pushNamed(context, CurrentPage.AcceptanceTimeRegulationPage,arguments: ApprovalResultSetData(getApprovalDetailMapper(notificationReceivedModel),true));
          break;
        case AppConstants.requestOverTimeScreenID:
          Navigator.pushNamed(context, CurrentPage.ApprovalOvertimeDetailPage,arguments: ApprovalResultSetData(getApprovalDetailMapper(notificationReceivedModel),true));
          break;
        case AppConstants.requestShiftScreenID:
          Navigator.pushNamed(context, CurrentPage.ApprovalShiftDetailPage,arguments: ApprovalResultSetData(getApprovalDetailMapper(notificationReceivedModel),true));
          break;
        default:
          Navigator.pushNamed(context, CurrentPage.ApprovalAcceptanceRejectionPage,arguments: ApprovalResultSetData(getApprovalDetailMapper(notificationReceivedModel),true));
          break;

      }
    }
  }

  getApprovalDetailMapper(NotificationReceivedModel? notificationReceivedModel)
  {
    return ApprovalDetailMapper(screenID: notificationReceivedModel?.screenData?.screenID, companyCode: notificationReceivedModel?.extraData?.companyCode, documentNo: notificationReceivedModel?.extraData?.documentNo,);
  }
}