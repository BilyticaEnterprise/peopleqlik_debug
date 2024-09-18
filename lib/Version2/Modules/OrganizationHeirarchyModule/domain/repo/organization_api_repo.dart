import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/OrganizationHeirarchyModule/data/models/organization_api_model.dart';

abstract class OrganizationApiRepo
{
  Future<ApiResponse> getOrganizationByTeam({required BuildContext context, required OrganizationApiModel organizationApiModel});
  Future<ApiResponse> getOrganizationByDepartment({required BuildContext context, required OrganizationApiModel organizationApiModel});
}