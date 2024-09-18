import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/domain/repo/dashboard_api_repo.dart';

class DashboardApiRepoImpl extends DashboardApiRepo
{
  BuildContext context;
  DashboardApiRepoImpl({required this.context});

  @override
  Future<ApiResponse> getDashboardResponse() async {
    return await UseCaseGetApisUrlCaller().getDashboardApiCall(context);
  }

}