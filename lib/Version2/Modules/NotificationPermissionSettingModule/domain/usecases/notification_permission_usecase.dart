import 'package:flutter/material.dart';

import '../../../ApiModule/domain/model/api_global_model.dart';
import '../repository/permission_repo.dart';

class NotificationPermissionUseCase
{
  Future<ApiResponse> updateNotificationSetting(BuildContext context){
    return PermissionSettingRepo.instance.updateNotificationSetting(context);
  }

  updateNotificationMapper(bool value){
    PermissionSettingRepo.instance.updateNotificationMapper(value);
  }

  Future<ApiResponse> getNotificationSettings(BuildContext context){
    return PermissionSettingRepo.instance.getNotificationSettings(context);
  }

}