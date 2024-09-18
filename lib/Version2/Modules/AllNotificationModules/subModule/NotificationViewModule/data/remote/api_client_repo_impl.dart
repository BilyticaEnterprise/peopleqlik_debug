import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/domain/model/notification_read_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/domain/model/notification_view_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationViewModule/domain/repo/api_client_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/repo/api_client_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/check_type_enums.dart';

class ApiClientRepoImpl extends ApiClientRepo
{
  @override
  Future<ApiResponse> getNotificationList(BuildContext context,{int? screenID,required int page}) async {
    return await GlobalApiCallerRepo.instance.callApi(
        context,
        endPoint: RequestType.getNotificationsUrl,
        urlParameters: '?ScreenID=$screenID&PageNo=$page&PerPage=10',
        authHeaders: true,
        isPost: false,
        type: ClassType<NotificationViewListModel>(NotificationViewListModel.fromJson),
        checkTypes: CheckTypes.includeListData
    );
  }

  @override
  Future<ApiResponse> readNotificationByNotificationId(BuildContext context, {required int notificationID}) async {
    return await GlobalApiCallerRepo.instance.callApi(
        context,
        endPoint: RequestType.notificationReadUrl,
        parameters: {
          "ScreenID" :null,
          "NotificationID" : notificationID
        },
        authHeaders: true,
        isPost: true,
        type: ClassType<NotificationReadModel>(NotificationReadModel.fromJson),
        checkTypes: CheckTypes.onlyBool
    );
  }

  @override
  Future<ApiResponse> readNotificationByScreenId(BuildContext context, {required int screenID}) async {
    return await GlobalApiCallerRepo.instance.callApi(
        context,
        endPoint: RequestType.notificationReadUrl,
        parameters: {
          "ScreenID" : screenID,
          "NotificationID" : null
        },
        authHeaders: true,
        isPost: true,
        type: ClassType<NotificationReadModel>(NotificationReadModel.fromJson),
        checkTypes: CheckTypes.onlyBool
    );
  }

}