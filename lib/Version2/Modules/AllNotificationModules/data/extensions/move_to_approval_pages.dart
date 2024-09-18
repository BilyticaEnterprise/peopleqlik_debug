import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/data/repoImpl/move_user_to_pages_on_notification_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/FCMModule/domain/models/notificationEachTypeModel/approval_request_common_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';

import '../../../../../configs/routing/pages_name.dart';
import '../../../../../mainCommon.dart';
import '../../../../../utils/strings.dart';

extension MoveToApprovalPages on MoveUserToPagesFromNotificationsRepoImpl
{
  void moveToApprovalPages(ApprovalRequestCommonModel? notificationReceivedModel) {
    BuildContext? context = GetNavigatorStateContext.navigatorKey.currentState?.context;
    if(context!=null)
    {
      int screenID = notificationReceivedModel?.screenID??0;
      switch(screenID)
      {
        case GetVariable.leaveScreenId:
          Navigator.pushNamed(context, CurrentPage.TimeOffDetailPage,arguments: getApprovalDetailMapper(notificationReceivedModel));
          break;
        case GetVariable.requestScreenId:
          Navigator.pushNamed(context, CurrentPage.RequestDetailPage,arguments: getApprovalDetailMapper(notificationReceivedModel));
          break;
        case AppConstants.requestEnCashmentScreenID:
          Navigator.pushNamed(context, CurrentPage.RequestEncashmentDetailPage,arguments: getApprovalDetailMapper(notificationReceivedModel));
          break;
        case AppConstants.requestSeparationScreenID:
          Navigator.pushNamed(context, CurrentPage.RequestSeparationDetailPage,arguments: getApprovalDetailMapper(notificationReceivedModel));
          break;
        case AppConstants.requestTimeRegulationScreenID:
          Navigator.pushNamed(context, CurrentPage.TimeRegulationAndMovementDetailPage,arguments: getApprovalDetailMapper(notificationReceivedModel));
          break;
        case AppConstants.requestOverTimeScreenID:
          Navigator.pushNamed(context, CurrentPage.OvertimeDetailPage,arguments: getApprovalDetailMapper(notificationReceivedModel));
          break;
        case AppConstants.requestShiftScreenID:
          Navigator.pushNamed(context, CurrentPage.ShiftDetailPage,arguments: getApprovalDetailMapper(notificationReceivedModel));
          break;
        default:
          Navigator.pushNamed(context, CurrentPage.RequestDetailPage,arguments: getApprovalDetailMapper(notificationReceivedModel));
          break;

      }
    }
  }

  AllRequestDetailMapper getApprovalDetailMapper(ApprovalRequestCommonModel? notificationReceivedModel)
  {
    return AllRequestDetailMapper(screenID: notificationReceivedModel?.screenID.toString(), companyCode: notificationReceivedModel?.companyCode.toString(), documentNumber: notificationReceivedModel?.documentNo,isApprovalScreen: true);
  }
}