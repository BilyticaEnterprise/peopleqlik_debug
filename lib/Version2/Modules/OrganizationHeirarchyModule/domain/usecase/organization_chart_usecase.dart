import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/data/models/organization_chart_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/domain/model/team_member_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/domain/repo/organization_chart_handler_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/domain/usecase/usecaseRepo/organization_chart_usecase_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class OrganizationChartDealerUseCase extends OrganizationChartDealerUseCaseRepo
{
  final delay = 500;
  Timer? searchOnStoppedTyping;
  var lastTextEdit = 0;


  late OrganizationChartHandlerRepo repo;
  OrganizationChartDealerUseCase({required this.repo});

  @override
  Future<AppState> fetchFirstUserOfTeam({required BuildContext context})async {
    AppState appState = await repo.fetchFirstUserOfTeam(context: context);
    return appState;
  }

  @override
  Future<AppState> fetchTeamMembers({required BuildContext context, required int employeeCode, required int companyCode}) async {
    AppState appState = await repo.fetchTeamMembers(context: context, employeeCode: employeeCode, companyCode: companyCode);
    if(appState is AppStateDone<GetOrganizationResultSet>)
    {
      return AppStateDone<OrganizationWidgetModel>(data: createDataForEachPageView(appState.data));
    }
    return appState;
  }

  @override
  Future<AppState> fetchTopUserManager({required BuildContext context, required int employeeCode, required int companyCode}) async {
    AppState appState = await repo.fetchTopUserManager(context: context, employeeCode: employeeCode, companyCode: companyCode);
    if(appState is AppStateDone<GetOrganizationResultSet>)
    {
      return AppStateDone<OrganizationWidgetModel>(data: createDataForEachPageView(appState.data));
    }
    return appState;
  }


  @override
  callApiAfterDelay({required Function() callBack}) {
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel(); // clear timer
    }
    lastTextEdit=DateTime.now().millisecondsSinceEpoch;
    searchOnStoppedTyping = Timer(Duration(milliseconds: delay), () {
      if(DateTime.now().millisecondsSinceEpoch>(lastTextEdit + delay - 500))
      {
        callBack();
      }
    });
  }

  @override
  OrganizationWidgetModel createDataForEachPageView(GetOrganizationResultSet? resultSet) {
    return OrganizationWidgetModel(
      currentUserData: DataType<EachTeamMemberModel>(populateData(resultSet?.employee)),
      superVisorData: resultSet?.supervisor!=null?DataType<EachTeamMemberModel>(populateData(resultSet?.supervisor)):null,
      teamData: createListFromData(resultSet),
    );
  }

  @override
  List<DataType<EachTeamMemberModel>> createListFromData(GetOrganizationResultSet? resultSet) {
    return List<DataType<EachTeamMemberModel>>.generate(
        resultSet?.team?.length??0,
            (index) => DataType<EachTeamMemberModel>(populateData(resultSet?.team?[index]))
    );
  }

  @override
  EachTeamMemberModel populateData(OrganizationTeamData? organizationTeamData) {
    return EachTeamMemberModel(
      employeeCode: organizationTeamData?.employeeCode,
      companyCode: organizationTeamData?.companyCode,
      name: organizationTeamData?.fullName,
      designation: organizationTeamData?.jobTitle,
      picture: '${RequestType.profileUrl}${organizationTeamData?.picture}',
      totalUnderEmployees: organizationTeamData?.noOfReportingEmployee,
      totalGloballyUnderEmployees: organizationTeamData?.noOfLeafLevelEmployee
    );
  }
}