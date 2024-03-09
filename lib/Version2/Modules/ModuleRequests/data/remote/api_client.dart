import 'package:flutter/src/widgets/framework.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/repo/api_client_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/check_type_enums.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/data/repoImpl/api_client_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/all_request_detail_api_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';

class AllRequestDetailApiClientRepoImpl extends AllRequestDetailApiClientRepo
{
  @override
  getData(BuildContext context, AllRequestDetailMapper allRequestDetailMapper,ClassType classType) async {

    ApiResponse apiResponse = await GlobalApiCallerRepo.instance.callApi(
      context,
        endPoint: RequestType.getAllRequestDetailApi,
        urlParameters: '?DocumentNo=${allRequestDetailMapper.documentNumber}&ScreenID=${allRequestDetailMapper.screenID}&CompanyCode=${allRequestDetailMapper.screenID}',
        authHeaders: true,
        isPost: false,
        type: classType,
        checkTypes: CheckTypes.includeData
    );

    if(apiResponse.apiStatus == ApiStatus.done)
    {
      return AppStateDone(data: apiResponse.data);
    }
    else
    {
      ShowErrorMessage.show(apiResponse);
      return AppStateError<String>(data: apiResponse.message);
    }
  }

}
