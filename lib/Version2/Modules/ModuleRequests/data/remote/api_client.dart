import 'package:flutter/src/widgets/framework.dart';
import 'package:peopleqlik_debug/Version1/models/ApprovalsModel/post_approval_model.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/repo/api_client_repo.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/usecase/apis_url_caller.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/check_type_enums.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/data/repoImpl/api_client_repo_impl.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/show_error.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/api_global_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/repo/all_request_detail_api_repo.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';

class AllRequestDetailApiClientRepoImpl extends AllRequestDetailApiClientRepo
{
  @override
  getData(BuildContext context, AllRequestDetailMapper allRequestDetailMapper,ClassType classType) async {

    ApiResponse apiResponse = await GlobalApiCallerRepo.instance.callApi(
      context,
        endPoint: RequestType.getAllRequestDetailApi,
        urlParameters: '?DocumentNo=${allRequestDetailMapper.documentNumber}&ScreenID=${allRequestDetailMapper.screenID}&CompanyCode=${allRequestDetailMapper.companyCode}',
        authHeaders: true,
        isPost: false,
        type: classType,
        checkTypes: CheckTypes.includeRequestChecks
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

  @override
  approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper, required String remarks, required int approveOrReject}) async {
    ApiResponse apiResponse = await GlobalApiCallerRepo.instance.callApi(
        context,
        endPoint: RequestType.postApprovalsAcceptReject,
        urlParameters: '?ScreenID=${allRequestDetailMapper.screenID}&StatusID=$approveOrReject&Remarks=$remarks&CompanyCode=${allRequestDetailMapper.companyCode}${AppConstants.getDocumentNumber(allRequestDetailMapper.documentNumber!)}',
        authHeaders: true,
        isPost: false,
        type: ClassType<PostApprovalAcceptRejectJson>(PostApprovalAcceptRejectJson.fromJson),
        checkTypes: CheckTypes.includeEntityData
    );
    if(apiResponse.apiStatus == ApiStatus.done&&apiResponse.data?.objEntity?.isSuccess==true)
    {

      Future.delayed(const Duration(milliseconds: 200),(){
        if(apiResponse.data!=null&&apiResponse.data?.objEntity!=null&&apiResponse.data!.objEntity!.errorResourceName!=null)
        {
          SnackBarDesign.happySnack(CallLanguageKeyWords.get(GetNavigatorStateContext.navigatorKey.currentState!.context, apiResponse.data!.objEntity!.errorResourceName!)??'');
        }
      });
      return AppStateDone(data: apiResponse.data);

    }
    else
    {
      ShowErrorMessage.show(apiResponse);
      return AppStateError<String>(data: apiResponse.message);
    }
  }
}
