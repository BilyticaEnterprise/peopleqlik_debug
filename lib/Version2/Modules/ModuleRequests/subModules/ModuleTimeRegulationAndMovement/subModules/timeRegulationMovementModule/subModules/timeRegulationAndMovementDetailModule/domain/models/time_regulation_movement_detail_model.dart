import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/applied_for_employee.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';

class TimeRegulationMovementDetailModel {
  bool? isSuccess;
  dynamic message;
  dynamic errorMessage;
  ResultSet? resultSet;

  TimeRegulationMovementDetailModel(
      {this.isSuccess, this.message, this.errorMessage, this.resultSet});

  TimeRegulationMovementDetailModel.fromJson(Map<String, dynamic> json) {
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
  TimeRegulationResult? result;
  List<ApprovalList>? approvalList;

  Data({this.statusID, this.result, this.approvalList});

  Data.fromJson(Map<String, dynamic> json) {
    statusID = json['StatusID'];
    result =
    json['Result'] != null ? new TimeRegulationResult.fromJson(json['Result']) : null;
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

class TimeRegulationResult {
  int? requestMID;
  int? employeeCode;
  int? companyCode;
  String? picture;
  String? employeeName;
  String? timeIn;
  String? timeOut;
  String? waiveOffTimeIn;
  String? waiveOffTimeOut;
  String? waiveOffRemarks;
  String? attendanceDate;
  int? waiveOffApprovalStatusID;
  int? approvalStatusID;
  int? typeID;
  String? statusName;
  int? timeStatusId;
  String? offPerFromTime;
  String? offPerToTime;
  String? reqDate;
  String? fileName;
  String? waiveOffTypeName;
  int? waiveOffTypeIDs;
  String? waiveOffStatus;
  String? isOffPermission;
  AppliedForEmployee? appliedForEmployee;

  TimeRegulationResult(
      {this.requestMID,
        this.employeeCode,
        this.companyCode,
        this.picture,
        this.employeeName,
        this.timeIn,
        this.timeOut,
        this.waiveOffTimeIn,
        this.waiveOffTimeOut,
        this.waiveOffRemarks,
        this.attendanceDate,
        this.waiveOffApprovalStatusID,
        this.approvalStatusID,
        this.typeID,
        this.statusName,
        this.timeStatusId,
        this.offPerFromTime,
        this.offPerToTime,
        this.reqDate,
        this.fileName,
        this.waiveOffTypeName,
        this.waiveOffTypeIDs,
        this.waiveOffStatus,
        this.appliedForEmployee,
        this.isOffPermission});

  TimeRegulationResult.fromJson(Map<String, dynamic> json) {
    requestMID = json['RequestMID'];
    employeeCode = json['EmployeeCode'];
    companyCode = json['CompanyCode'];
    picture = json['Picture'];
    employeeName = json['EmployeeName'];
    timeIn = json['TimeIn'];
    timeOut = json['TimeOut'];
    waiveOffTimeIn = json['WaiveOffTimeIn'];
    waiveOffTimeOut = json['WaiveOffTimeOut'];
    waiveOffRemarks = json['WaiveOffRemarks'];
    attendanceDate = json['AttendanceDate'];
    waiveOffApprovalStatusID = json['WaiveOffApprovalStatusID'];
    approvalStatusID = json['ApprovalStatusID'];
    typeID = json['TypeID'];
    statusName = json['StatusName'];
    timeStatusId = json['TimeStatusId'];
    offPerFromTime = json['OffPerFromTime'];
    offPerToTime = json['OffPerToTime'];
    reqDate = json['ReqDate'];
    fileName = json['FileName'];
    waiveOffTypeName = json['WaiveOffTypeName'];
    waiveOffTypeIDs = json['WaiveOffTypeIDs'];
    waiveOffStatus = json['WaiveOffStatus'];
    isOffPermission = json['IsOffPermission'];
    appliedForEmployee = json['AppliedForEmployee'] != null
        ? new AppliedForEmployee.fromJson(json['AppliedForEmployee'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RequestMID'] = this.requestMID;
    data['EmployeeCode'] = this.employeeCode;
    data['CompanyCode'] = this.companyCode;
    data['Picture'] = this.picture;
    data['EmployeeName'] = this.employeeName;
    data['TimeIn'] = this.timeIn;
    data['TimeOut'] = this.timeOut;
    data['WaiveOffTimeIn'] = this.waiveOffTimeIn;
    data['WaiveOffTimeOut'] = this.waiveOffTimeOut;
    data['WaiveOffRemarks'] = this.waiveOffRemarks;
    data['AttendanceDate'] = this.attendanceDate;
    data['WaiveOffApprovalStatusID'] = this.waiveOffApprovalStatusID;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['TypeID'] = this.typeID;
    data['StatusName'] = this.statusName;
    data['TimeStatusId'] = this.timeStatusId;
    data['OffPerFromTime'] = this.offPerFromTime;
    data['OffPerToTime'] = this.offPerToTime;
    data['ReqDate'] = this.reqDate;
    data['FileName'] = this.fileName;
    data['WaiveOffTypeName'] = this.waiveOffTypeName;
    data['WaiveOffTypeIDs'] = this.waiveOffTypeIDs;
    data['WaiveOffStatus'] = this.waiveOffStatus;
    data['IsOffPermission'] = this.isOffPermission;
    if (this.appliedForEmployee != null) {
      data['AppliedForEmployee'] = this.appliedForEmployee!.toJson();
    }
    return data;
  }
}

