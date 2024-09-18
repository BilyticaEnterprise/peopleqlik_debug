import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';

abstract class ApiClientRepo
{
  Future<ApiResponse> getNotificationList(BuildContext context,{int? screenID,required int page});
  Future<ApiResponse> readNotificationByScreenId(BuildContext context,{required int screenID});
  Future<ApiResponse> readNotificationByNotificationId(BuildContext context,{required int notificationID});

}