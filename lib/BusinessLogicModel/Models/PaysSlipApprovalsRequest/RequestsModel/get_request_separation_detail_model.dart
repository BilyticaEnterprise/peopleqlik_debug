import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';

class GetRequestSeparationDetailsJson {
  bool? isSuccess;
  RequestSeparationDetailResultSet? resultSet;
  String? errorMessage;

  GetRequestSeparationDetailsJson(
      {this.isSuccess,
        this.resultSet,
        this.errorMessage});

  GetRequestSeparationDetailsJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new RequestSeparationDetailResultSet.fromJson(json['ResultSet'])
        : null;
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class RequestSeparationDetailResultSet {
  RequestSeparationDetail? reuestDetail;
  List<ApprovalHistory>? approvalHistory;

  RequestSeparationDetailResultSet({this.reuestDetail, this.approvalHistory});

  RequestSeparationDetailResultSet.fromJson(Map<String, dynamic> json) {
    reuestDetail = json['ReuestDetail'] != null
        ? RequestSeparationDetail.fromJson(json['ReuestDetail'])
        : null;
    if (json['ApprovalHistory'] != null) {
      approvalHistory = <ApprovalHistory>[];
      json['ApprovalHistory'].forEach((v) {
        approvalHistory!.add(ApprovalHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reuestDetail != null) {
      data['ReuestDetail'] = this.reuestDetail!.toJson();
    }
    if (this.approvalHistory != null) {
      data['ApprovalHistory'] =
          this.approvalHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestSeparationDetail {
  String? displayName;
  String? employeeName;
  String? effectiveFrom;
  String? lastWorkingDate;
  String? jobTitle;
  String? jobCode;
  dynamic newLastWorkingDate;
  String? remarks;
  dynamic newRemarks;
  int? approvalStatusID;
  dynamic employeeCode;
  dynamic companyCode;

  RequestSeparationDetail(
      {this.displayName,
        this.employeeName,
        this.effectiveFrom,
        this.lastWorkingDate,
        this.jobTitle,
        this.jobCode,
        this.newLastWorkingDate,
        this.remarks,
        this.newRemarks,
        this.approvalStatusID,
        this.employeeCode,
        this.companyCode});

  RequestSeparationDetail.fromJson(Map<String, dynamic> json) {
    displayName = json['DisplayName'];
    employeeName = json['EmployeeName'];
    effectiveFrom = json['EffectiveFrom'];
    lastWorkingDate = json['LastWorkingDate'];
    jobTitle = json['JobTitle'];
    jobCode = json['JobCode'];
    newLastWorkingDate = json['NewLastWorkingDate'];
    remarks = json['Remarks'];
    newRemarks = json['NewRemarks'];
    approvalStatusID = json['ApprovalStatusID'];
    employeeCode = json['EmployeeCode'];
    companyCode = json['CompanyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DisplayName'] = this.displayName;
    data['EmployeeName'] = this.employeeName;
    data['EffectiveFrom'] = this.effectiveFrom;
    data['LastWorkingDate'] = this.lastWorkingDate;
    data['JobTitle'] = this.jobTitle;
    data['JobCode'] = this.jobCode;
    data['NewLastWorkingDate'] = this.newLastWorkingDate;
    data['Remarks'] = this.remarks;
    data['NewRemarks'] = this.newRemarks;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['EmployeeCode'] = this.employeeCode;
    data['CompanyCode'] = this.companyCode;
    return data;
  }
}