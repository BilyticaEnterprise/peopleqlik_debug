import 'package:flutter/material.dart';

import '../../../ApiModule/domain/model/api_global_model.dart';
import '../../data/repoImpl/permission_repo_impl.dart';

abstract class PermissionSettingRepo
{
  static final PermissionSettingRepo _instance = PermissionSettingImpl();
  static PermissionSettingRepo get instance => _instance;

  Future<ApiResponse> updateNotificationSetting(BuildContext context);
  updateNotificationMapper(bool value);
  Future<ApiResponse> getNotificationSettings(BuildContext context);
}