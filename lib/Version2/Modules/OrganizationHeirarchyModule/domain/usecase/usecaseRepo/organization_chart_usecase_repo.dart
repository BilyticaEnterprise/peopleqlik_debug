import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/data/models/organization_chart_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/domain/model/team_member_model.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

abstract class OrganizationChartDealerUseCaseRepo
{
  Future<AppState> fetchFirstUserOfTeam({required BuildContext context});
  Future<AppState> fetchTeamMembers({required BuildContext context,required int employeeCode, required int companyCode});
  Future<AppState> fetchTopUserManager({required BuildContext context,required int employeeCode, required int companyCode});
  OrganizationWidgetModel createDataForEachPageView(GetOrganizationResultSet? resultSet);
  List<DataType<EachTeamMemberModel>> createListFromData(GetOrganizationResultSet? resultSet);
  EachTeamMemberModel populateData(OrganizationTeamData organizationTeamData);
  callApiAfterDelay({required Function() callBack});
}