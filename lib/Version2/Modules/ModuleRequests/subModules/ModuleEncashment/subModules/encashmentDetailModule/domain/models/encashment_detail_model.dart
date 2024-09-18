import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/applied_for_employee.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';

class EncashmentDetailModel {
  bool? isSuccess;
  dynamic message;
  dynamic errorMessage;
  ResultSet? resultSet;

  EncashmentDetailModel(
      {this.isSuccess, this.message, this.errorMessage, this.resultSet});

  EncashmentDetailModel.fromJson(Map<String, dynamic> json) {
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
  EncashmentResult? result;
  List<ApprovalList>? approvalList;

  Data({this.statusID, this.result, this.approvalList});

  Data.fromJson(Map<String, dynamic> json) {
    statusID = json['StatusID'];
    result =
    json['Result'] != null ? new EncashmentResult.fromJson(json['Result']) : null;
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

class EncashmentResult {
  String? requestCode;
  String? leaveType;
  String? createdDate;
  double? balanceUnit;
  double? maxEncashmentUnit;
  int? typeID;
  double? encashmentUnit;
  String? typeName;
  int? approvalStatusID;
  AppliedForEmployee? appliedForEmployee;

  EncashmentResult(
      {this.requestCode,
        this.leaveType,
        this.createdDate,
        this.balanceUnit,
        this.maxEncashmentUnit,
        this.typeID,
        this.encashmentUnit,
        this.typeName,
        this.appliedForEmployee,
        this.approvalStatusID});

  EncashmentResult.fromJson(Map<String, dynamic> json) {
    requestCode = json['RequestCode'];
    leaveType = json['LeaveType'];
    createdDate = json['CreatedDate'];
    balanceUnit = json['BalanceUnit'];
    maxEncashmentUnit = json['MaxEncashmentUnit'];
    typeID = json['TypeID'];
    encashmentUnit = json['EncashmentUnit'];
    typeName = json['TypeName'];
    approvalStatusID = json['ApprovalStatusID'];
    appliedForEmployee = json['AppliedForEmployee'] != null
        ? new AppliedForEmployee.fromJson(json['AppliedForEmployee'])
        : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RequestCode'] = this.requestCode;
    data['LeaveType'] = this.leaveType;
    data['CreatedDate'] = this.createdDate;
    data['BalanceUnit'] = this.balanceUnit;
    data['MaxEncashmentUnit'] = this.maxEncashmentUnit;
    data['TypeID'] = this.typeID;
    data['EncashmentUnit'] = this.encashmentUnit;
    data['TypeName'] = this.typeName;
    data['ApprovalStatusID'] = this.approvalStatusID;
    if (this.appliedForEmployee != null) {
      data['AppliedForEmployee'] = this.appliedForEmployee!.toJson();
    }
    return data;
  }
}