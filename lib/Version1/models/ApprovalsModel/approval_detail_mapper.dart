import 'get_approvals_list.dart';

class ApprovalDetailMapper
{
  dynamic screenID;
  dynamic companyCode;
  dynamic documentNo;

  ApprovalDetailMapper({required this.screenID,required this.companyCode,required this.documentNo});

  static getApprovalDetailMapper(ApprovalResultSet? approvalResultSet)
  {
    return ApprovalDetailMapper(screenID: approvalResultSet?.screenID, companyCode: approvalResultSet?.companyCode, documentNo: approvalResultSet?.documentNo,);
  }
}
