import 'package:flutter/src/widgets/framework.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';

import '../../domain/repository/permission_repo.dart';

class PermissionSettingImpl extends PermissionSettingRepo
{
  bool notificationPermission = false;
  @override
  Future<ApiResponse> getNotificationSettings(BuildContext context) async {
    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().getFCMTokenSetting(context);
    return apiResponse;
  }

  @override
  updateNotificationMapper(bool value) {
    notificationPermission = value;
  }

  @override
  Future<ApiResponse> updateNotificationSetting(BuildContext context)async {
    ApiResponse apiResponse = await UseCaseGetApisUrlCaller().postFCMTokenSetting(context,{"IsNotificationPermissionAllow":notificationPermission});
    return apiResponse;
  }

}