import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/check_type_enums.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/data/repoImpl/api_client_repo_impl.dart';

abstract class GlobalApiCallerRepo<T>
{
  String? baseUrl;
  dynamic headers;
  dynamic parameters;
  dynamic urlParameters;

  static final GlobalApiCallerRepo _instance = GlobalApiCallerRepoImpl();
  static GlobalApiCallerRepo get instance => _instance;

  Future<ApiResponse> callApi(
      BuildContext context,
      {
        required String endPoint,
        required ClassType<T> type,
        required CheckTypes checkTypes,
        bool? isPost,
        String? baseUrl,
        bool? checkCookies = true,
        bool? authHeaders = true,
        dynamic urlParameters,
        dynamic parameters,
        dynamic headers
      });
}