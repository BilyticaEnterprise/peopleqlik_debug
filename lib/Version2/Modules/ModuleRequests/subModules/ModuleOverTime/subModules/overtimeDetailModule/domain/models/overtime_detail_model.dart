import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';

class OvertimeDetailModel {
  bool? isSuccess;
  dynamic message;
  dynamic errorMessage;
  ResultSet? resultSet;

  OvertimeDetailModel(
      {this.isSuccess, this.message, this.errorMessage, this.resultSet});

  OvertimeDetailModel.fromJson(Map<String, dynamic> json) {
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
  OvertimeResultIs? result;
  List<ApprovalList>? approvalList;

  Data({this.statusID, this.result, this.approvalList});

  Data.fromJson(Map<String, dynamic> json) {
    statusID = json['StatusID'];
    result =
    json['Result'] != null ? new OvertimeResultIs.fromJson(json['Result']) : null;
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

class OvertimeResultIs {
  int? approvalStatusID;
  int? createdBy;
  int? requestMID;
  List<OvertimeDetailList>? overtimeDetailList;

  OvertimeResultIs(
      {this.approvalStatusID,
        this.createdBy,
        this.requestMID,
        this.overtimeDetailList});

  OvertimeResultIs.fromJson(Map<String, dynamic> json) {
    approvalStatusID = json['ApprovalStatusID'];
    createdBy = json['CreatedBy'];
    requestMID = json['RequestMID'];
    if (json['OvertimeDetailList'] != null) {
      overtimeDetailList = <OvertimeDetailList>[];
      json['OvertimeDetailList'].forEach((v) {
        overtimeDetailList!.add(new OvertimeDetailList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['CreatedBy'] = this.createdBy;
    data['RequestMID'] = this.requestMID;
    if (this.overtimeDetailList != null) {
      data['OvertimeDetailList'] =
          this.overtimeDetailList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OvertimeDetailList {
  String? name;
  double? overtimeMinutes;
  String? appliedDate;
  String? overtimeType;
  String? shiftStartTime;
  String? shiftEndTime;
  String? employeeCode;
  bool? active;
  int? empCode;
  int? companyCode;
  int? cultureID;
  String? status;
  String? ovtDate;

  OvertimeDetailList(
      {this.name,
        this.overtimeMinutes,
        this.appliedDate,
        this.overtimeType,
        this.shiftStartTime,
        this.shiftEndTime,
        this.employeeCode,
        this.active,
        this.empCode,
        this.companyCode,
        this.cultureID,
        this.status,
        this.ovtDate});

  OvertimeDetailList.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    overtimeMinutes = json['OvertimeMinutes'];
    appliedDate = json['AppliedDate'];
    overtimeType = json['OvertimeType'];
    shiftStartTime = json['ShiftStartTime'];
    shiftEndTime = json['ShiftEndTime'];
    employeeCode = json['EmployeeCode'];
    active = json['Active'];
    empCode = json['EmpCode'];
    companyCode = json['CompanyCode'];
    cultureID = json['CultureID'];
    status = json['Status'];
    ovtDate = json['OvtDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['OvertimeMinutes'] = this.overtimeMinutes;
    data['AppliedDate'] = this.appliedDate;
    data['OvertimeType'] = this.overtimeType;
    data['ShiftStartTime'] = this.shiftStartTime;
    data['ShiftEndTime'] = this.shiftEndTime;
    data['EmployeeCode'] = this.employeeCode;
    data['Active'] = this.active;
    data['EmpCode'] = this.empCode;
    data['CompanyCode'] = this.companyCode;
    data['CultureID'] = this.cultureID;
    data['Status'] = this.status;
    data['OvtDate'] = this.ovtDate;
    return data;
  }
}