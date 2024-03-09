import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';

class LeaveDetailModel {
  bool? isSuccess;
  String? message;
  String? errorMessage;
  ResultSet? resultSet;

  LeaveDetailModel(
      {this.isSuccess, this.message, this.errorMessage, this.resultSet});

  LeaveDetailModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    resultSet = json['ResultSet'] != null
        ? ResultSet.fromJson(json['ResultSet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsSuccess'] = isSuccess;
    data['Message'] = message;
    data['ErrorMessage'] = errorMessage;
    if (resultSet != null) {
      data['ResultSet'] = resultSet!.toJson();
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
        ? ApprovalInfo.fromJson(json['ApprovalInfo'])
        : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (approvalInfo != null) {
      data['ApprovalInfo'] = approvalInfo!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CompanyCode'] = companyCode;
    data['DocumentNo'] = documentNo;
    data['ScreenID'] = screenID;
    return data;
  }
}

class Data {
  int? statusID;
  LeaveDetailResult? result;
  List<ApprovalList>? approvalList;

  Data({this.statusID, this.result, this.approvalList});

  Data.fromJson(Map<String, dynamic> json) {
    statusID = json['StatusID'];
    result =
    json['Result'] != null ? LeaveDetailResult.fromJson(json['Result']) : null;
    if (json['ApprovalList'] != null) {
      approvalList = <ApprovalList>[];
      json['ApprovalList'].forEach((v) {
        approvalList!.add(ApprovalList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['StatusID'] = statusID;
    if (result != null) {
      data['Result'] = result!.toJson();
    }
    if (approvalList != null) {
      data['ApprovalList'] = approvalList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveDetailResult {
  String? requestDate;
  String? applicationCode;
  String? eCIName;
  String? eCINumber;
  String? remarks;
  String? fullName;
  String? typeTitle;
  int? unitID;
  int? approvalStatusID;
  List<LeaveTimeOff>? leaveTimeOff;
  List<dynamic>? leaveDocuments;

  LeaveDetailResult(
      {this.requestDate,
        this.applicationCode,
        this.eCIName,
        this.eCINumber,
        this.remarks,
        this.fullName,
        this.typeTitle,
        this.unitID,
        this.approvalStatusID,
        this.leaveTimeOff,
        this.leaveDocuments});

  LeaveDetailResult.fromJson(Map<String, dynamic> json) {
    requestDate = json['RequestDate'];
    applicationCode = json['ApplicationCode'];
    eCIName = json['ECIName'];
    eCINumber = json['ECINumber'];
    remarks = json['Remarks'];
    fullName = json['FullName'];
    typeTitle = json['TypeTitle'];
    unitID = json['UnitID'];
    approvalStatusID = json['ApprovalStatusID'];
    if (json['LeaveTimeOff'] != null) {
      leaveTimeOff = <LeaveTimeOff>[];
      json['LeaveTimeOff'].forEach((v) {
        leaveTimeOff!.add(new LeaveTimeOff.fromJson(v));
      });
    }
    // if (json['LeaveDocuments'] != null) {
    //   leaveDocuments = <dynamic>[];
    //   json['LeaveDocuments'].forEach((v) {
    //     leaveDocuments!.add(new Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RequestDate'] = this.requestDate;
    data['ApplicationCode'] = this.applicationCode;
    data['ECIName'] = this.eCIName;
    data['ECINumber'] = this.eCINumber;
    data['Remarks'] = this.remarks;
    data['UnitID'] = unitID;
    data['FullName'] = this.fullName;
    data['TypeTitle'] = this.typeTitle;
    data['ApprovalStatusID'] = this.approvalStatusID;
    if (this.leaveTimeOff != null) {
      data['LeaveTimeOff'] = this.leaveTimeOff!.map((v) => v.toJson()).toList();
    }
    if (this.leaveDocuments != null) {
      data['LeaveDocuments'] =
          this.leaveDocuments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveTimeOff {
  String? leaveFrom;
  String? leaveTo;
  int? totalLeaves;

  LeaveTimeOff({this.leaveFrom, this.leaveTo, this.totalLeaves});

  LeaveTimeOff.fromJson(Map<String, dynamic> json) {
    leaveFrom = json['LeaveFrom'];
    leaveTo = json['LeaveTo'];
    totalLeaves = json['TotalLeaves'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeaveFrom'] = this.leaveFrom;
    data['LeaveTo'] = this.leaveTo;
    data['TotalLeaves'] = this.totalLeaves;
    return data;
  }
}

