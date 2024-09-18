import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';

abstract class DashboardRepo
{
  Future<ApiResponse> callApi();
}