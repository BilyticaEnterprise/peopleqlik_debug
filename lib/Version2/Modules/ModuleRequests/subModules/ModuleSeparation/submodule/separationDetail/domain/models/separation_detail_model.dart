import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/applied_for_employee.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';

class SeparationDetailModel {
  bool? isSuccess;
  dynamic message;
  dynamic errorMessage;
  ResultSet? resultSet;

  SeparationDetailModel(
      {this.isSuccess, this.message, this.errorMessage, this.resultSet});

  SeparationDetailModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    resultSet = json['ResultSet'] != null
        ? new ResultSet.fromJson(json['ResultSet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    return data;
  }
}

class ResultSet {
  ApprovalInfo? approvalInfo;
  Data? data;

  ResultSet({this.approvalInfo, this.data});

  ResultSet.fromJson(Map<String, dynamic> json) {
    approvalInfo = json['ApprovalInfo'] != null
        ? new ApprovalInfo.fromJson(json['ApprovalInfo'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.approvalInfo != null) {
      data['ApprovalInfo'] = this.approvalInfo!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ApprovalInfo {
  int? companyCode;
  String? documentNo;
  int? screenID;

  ApprovalInfo({this.companyCode, this.documentNo, this.screenID});

  ApprovalInfo.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    documentNo = json['DocumentNo'];
    screenID = json['ScreenID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyCode'] = this.companyCode;
    data['DocumentNo'] = this.documentNo;
    data['ScreenID'] = this.screenID;
    return data;
  }
}

class Data {
  int? statusID;
  SeparationResult? result;
  List<ApprovalList>? approvalList;

  Data({this.statusID, this.result, this.approvalList});

  Data.fromJson(Map<String, dynamic> json) {
    statusID = json['StatusID'];
    result =
    json['Result'] != null ? new SeparationResult.fromJson(json['Result']) : null;
    if (json['ApprovalList'] != null) {
      approvalList = <ApprovalList>[];
      json['ApprovalList'].forEach((v) {
        approvalList!.add(new ApprovalList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusID'] = this.statusID;
    if (this.result != null) {
      data['Result'] = this.result!.toJson();
    }
    if (this.approvalList != null) {
      data['ApprovalList'] = this.approvalList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SeparationResult {
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
  int? employeeCode;
  int? companyCode;
  AppliedForEmployee? appliedForEmployee;

  SeparationResult(
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
        this.appliedForEmployee,
        this.companyCode});

  SeparationResult.fromJson(Map<String, dynamic> json) {
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
    appliedForEmployee = json['AppliedForEmployee'] != null
        ? new AppliedForEmployee.fromJson(json['AppliedForEmployee'])
        : null;

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
    if (this.appliedForEmployee != null) {
      data['AppliedForEmployee'] = this.appliedForEmployee!.toJson();
    }
    return data;
  }
}

