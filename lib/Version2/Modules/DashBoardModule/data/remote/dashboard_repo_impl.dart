import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/domain/repo/dashboard_api_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/domain/repo/dashboard_repo.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

class DashboardRepoImpl extends DashboardRepo
{
  DashboardApiRepo apiRepo;
  DashboardRepoImpl({required this.apiRepo});

  @override
  Future<ApiResponse> callApi() async {
    return await apiRepo.getDashboardResponse();
  }
}