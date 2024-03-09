import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:provider/provider.dart';

import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';
import '../../../../../Version1/viewModel/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_detail_listener.dart';
import '../../../../../Version1/Models/RequestsModel/EncashmentsModels/encashment_detail_mapper.dart';
import '../../../../../Version1/Models/RequestsModel/request_data_taker.dart';
import '../../../../../Version1/Models/TimeRegulationModels/time_regulation_detail_mapper.dart';
import '../../../../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/RequestSubPages/request_list_sub_page.dart';
import '../../../../../configs/routing/pages_name.dart';
import '../../../../../utils/strings.dart';
import '../../../FCMModule/domain/models/fcm_notification_received_model.dart';
import '../../../ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/time_off_detail_mapper.dart';

extension MoveToUserRequestPages on SettingsModelListener
{
  void moveToUserRequestPages(NotificationReceivedModel? notificationReceivedModel) {
    BuildContext? context = GetNavigatorStateContext.navigatorKey.currentState?.context;
    if(context!=null)
      {
        SettingsModelListener settingsModelListener = Provider.of(context,listen: false);
        int screenID = int.parse(notificationReceivedModel?.screenData?.screenID??'0');
        switch(screenID)
        {
          case GetVariable.leaveScreenId:
            Navigator.pushNamed(context, CurrentPage.TimeOffDetailPage,arguments: TimeOffDetailMapper(id: notificationReceivedModel?.extraData?.iD,companyCode: notificationReceivedModel?.extraData?.companyCode,employeeCode: settingsModelListener.settingsResultSet?.headerInfo?.employeeCode));
            break;
          case AppConstants.requestEnCashmentScreenID:
            Navigator.pushNamed(context, CurrentPage.RequestEncashmentDetailPage,arguments: RequestEncashmentDetailData(notificationReceivedModel?.extraData?.documentNo));
            break;
          case AppConstants.requestSeparationScreenID:
            Navigator.pushNamed(context, CurrentPage.RequestSeparationDetailPage,arguments: RequestSeparationDetailData(notificationReceivedModel?.extraData?.documentNo));
            break;
          case AppConstants.requestTimeRegulationScreenID:
            Navigator.pushNamed(context, CurrentPage.TimeRegulationDetailPage,arguments: TimeRegulationDetailMapper(id: notificationReceivedModel?.extraData?.documentNo, title: ''));
            break;
          case AppConstants.requestOverTimeScreenID:
            Navigator.pushNamed(context, CurrentPage.OvertimeDetailPage,arguments: RequestDataTaker('',extraData: notificationReceivedModel?.extraData?.documentNo));
            break;
          case AppConstants.requestShiftScreenID:
            Navigator.pushNamed(context, CurrentPage.ShiftDetailPage, arguments: RequestDataTaker('',documentNumber: notificationReceivedModel?.extraData?.documentNo));
            break;
          default:
            Navigator.pushNamed(context, CurrentPage.RequestDetailPage,arguments: RequestDetailData(notificationReceivedModel?.extraData?.requestCode,notificationReceivedModel?.screenData?.managerID));
            break;

        }
      }
  }

}