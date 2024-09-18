import 'dart:async';

import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';

abstract class DashboardApiRepo
{
  Future<ApiResponse> getDashboardResponse();
}