import 'package:peopleqlik_debug/Version1/models/ApprovalsModel/get_approvals_list.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';

class GetApprovalDetailMapper
{
  static getApprovalDetailMapper(ApprovalResultSet? approvalResultSet,{bool? isApprovalScreen})
  {
    return AllRequestDetailMapper(screenID: approvalResultSet?.screenID.toString(), companyCode: approvalResultSet?.companyCode.toString(), documentNumber: approvalResultSet?.documentNo.toString(),isApprovalScreen: isApprovalScreen);
  }
}