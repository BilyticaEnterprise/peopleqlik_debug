import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Version1/viewModel/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import 'package:peopleqlik_debug/Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/data/models/organization_api_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/data/models/organization_chart_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/domain/repo/organization_api_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/domain/repo/organization_chart_handler_repo.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:provider/provider.dart';

class OrganizationChartHandlerRepoImpl extends OrganizationChartHandlerRepo
{
  late OrganizationApiRepo apiRepo;

  OrganizationChartHandlerRepoImpl({required this.apiRepo});

  @override
  Future<AppState> fetchFirstUserOfTeam({required BuildContext context}) async{
    EmployeeInfoMapper employeeInfoMapper = Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee();
    ApiResponse apiResponse = await apiRepo.getOrganizationByTeam(context: context, organizationApiModel: OrganizationApiModel(companyCode: employeeInfoMapper.companyCode, employeeCode: employeeInfoMapper.employeeCode));
    return handleDataStateForFirstTime(apiResponse);
  }

  @override
  Future<AppState> fetchTeamMembers({required BuildContext context, required int employeeCode, required int companyCode}) async {
    ApiResponse apiResponse = await apiRepo.getOrganizationByTeam(context: context, organizationApiModel: OrganizationApiModel(companyCode: companyCode, employeeCode: employeeCode));
    return handleDataState(apiResponse);
  }

  @override
  Future<AppState> fetchTopUserManager({required BuildContext context, required int employeeCode, required int companyCode}) async {
    ApiResponse apiResponse = await apiRepo.getOrganizationByTeam(context: context, organizationApiModel: OrganizationApiModel(companyCode: companyCode, employeeCode: employeeCode));
    return handleDataState(apiResponse);
  }

  @override
  AppState handleDataState(ApiResponse apiResponse) {
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      GetOrganizationResultSet resultSet = apiResponse.data.resultSet as GetOrganizationResultSet;
      if(resultSet.employee != null)
      {
        return AppStateDone(data: resultSet);
      }
      else
      {
        return AppStateEmpty();
      }
    }
    else
    {

      ShowErrorMessage.show(apiResponse);
      return AppStateError(data: apiResponse.message);
    }
  }

  @override
  AppState handleDataStateForFirstTime(ApiResponse apiResponse) {
    if(apiResponse.apiStatus == ApiStatus.done)
    {
      GetOrganizationResultSet resultSet = apiResponse.data.resultSet as GetOrganizationResultSet;
      if(resultSet.team != null)
      {
        return AppStateDone(data: resultSet);
      }
      else
      {
        return AppStateError(data: apiResponse.message);
      }
    }
    else
    {
      ShowErrorMessage.show(apiResponse);
      return AppStateError(data: apiResponse.message);
    }
  }

}