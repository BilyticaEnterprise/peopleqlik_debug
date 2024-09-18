import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class OrganizationChartHandlerRepo
{
  Future<AppState> fetchFirstUserOfTeam({required BuildContext context});
  Future<AppState> fetchTeamMembers({required BuildContext context,required int employeeCode, required int companyCode});
  Future<AppState> fetchTopUserManager({required BuildContext context,required int employeeCode, required int companyCode});
  AppState handleDataState(ApiResponse apiResponse);
  AppState handleDataStateForFirstTime(ApiResponse apiResponse);
}