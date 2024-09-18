import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/repo/api_client_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/check_type_enums.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/data/models/organization_api_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/data/models/organization_chart_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/domain/repo/organization_api_repo.dart';

class OrganizationApiRepoImpl extends OrganizationApiRepo
{


  @override
  Future<ApiResponse> getOrganizationByDepartment({required BuildContext context, required OrganizationApiModel organizationApiModel}) async {
    return await GlobalApiCallerRepo.instance.callApi(
        context,
        endPoint: RequestType.getOrgHierarchy,
        parameters: organizationApiModel.toJson(),
        authHeaders: true,
        isPost: true,
        type: ClassType<GetOrganizationModel>(GetOrganizationModel.fromJson),
        checkTypes: CheckTypes.onlyBool
    );
  }

  @override
  Future<ApiResponse> getOrganizationByTeam({required BuildContext context, required OrganizationApiModel organizationApiModel}) async {
    return await GlobalApiCallerRepo.instance.callApi(
        context,
        endPoint: RequestType.getOrgHierarchy,
        parameters: organizationApiModel.toJson(),
        authHeaders: true,
        isPost: true,
        type: ClassType<GetOrganizationModel>(GetOrganizationModel.fromJson),
        checkTypes: CheckTypes.onlyBool
    );
  }

}