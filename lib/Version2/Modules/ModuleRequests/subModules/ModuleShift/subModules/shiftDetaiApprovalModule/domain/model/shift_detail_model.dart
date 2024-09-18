import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/applied_for_employee.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';

class ShiftDetailModel {
  bool? isSuccess;
  dynamic message;
  dynamic errorMessage;
  ResultSet? resultSet;

  ShiftDetailModel(
      {this.isSuccess, this.message, this.errorMessage, this.resultSet});

  ShiftDetailModel.fromJson(Map<String, dynamic> json) {
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
  ShiftResult? result;
  List<ApprovalList>? approvalList;

  Data({this.statusID, this.result, this.approvalList});

  Data.fromJson(Map<String, dynamic> json) {
    statusID = json['StatusID'];
    result =
    json['Result'] != null ? new ShiftResult.fromJson(json['Result']) : null;
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
    data['ApprovalList'] = this.approvalList;
    return data;
  }
}

class ShiftResult {
  int? companyCode;
  int? employeeCode;
  String? regularShift;
  String? ramadanShift;
  String? effectiveDate;
  int? permenantID;
  String? createdDate;
  int? requestMID;
  int? approvalStatusID;
  List<int>? offDays;
  AppliedForEmployee? appliedForEmployee;

  ShiftResult(
      {this.companyCode,
        this.employeeCode,
        this.regularShift,
        this.ramadanShift,
        this.effectiveDate,
        this.permenantID,
        this.createdDate,
        this.requestMID,
        this.approvalStatusID,
        this.appliedForEmployee,
        this.offDays});

  ShiftResult.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    regularShift = json['RegularShift'];
    ramadanShift = json['RamadanShift'];
    effectiveDate = json['EffectiveDate'];
    permenantID = json['PermenantID'];
    createdDate = json['CreatedDate'];
    requestMID = json['RequestMID'];
    approvalStatusID = json['ApprovalStatusID'];
    offDays = json['OffDays'].cast<int>();
    appliedForEmployee = json['AppliedForEmployee'] != null
        ? new AppliedForEmployee.fromJson(json['AppliedForEmployee'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    data['RegularShift'] = this.regularShift;
    data['RamadanShift'] = this.ramadanShift;
    data['EffectiveDate'] = this.effectiveDate;
    data['PermenantID'] = this.permenantID;
    data['CreatedDate'] = this.createdDate;
    data['RequestMID'] = this.requestMID;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['OffDays'] = this.offDays;
    if (this.appliedForEmployee != null) {
      data['AppliedForEmployee'] = this.appliedForEmployee!.toJson();
    }
    return data;
  }
}