import '../ApprovalsModel/get_approvals_detail_model.dart';

class TimeRegulationApprovalDetailModel {
  bool? isSuccess;
  TimeRegulationDetailResultSet? resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;

  TimeRegulationApprovalDetailModel(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo});

  TimeRegulationApprovalDetailModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new TimeRegulationDetailResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    documentNo = json['DocumentNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    data['DocumentNo'] = this.documentNo;
    return data;
  }
}

class TimeRegulationDetailResultSet {
  List<TimeRegulationLeaveDetail>? leaveDetail;
  dynamic approvalRemarks;
  List<ApprovalHistory>? approvalHistory;

  TimeRegulationDetailResultSet({this.leaveDetail, this.approvalRemarks, this.approvalHistory});

  TimeRegulationDetailResultSet.fromJson(Map<String, dynamic> json) {
    if (json['LeaveDetail'] != null) {
      leaveDetail = <TimeRegulationLeaveDetail>[];
      json['LeaveDetail'].forEach((v) {
        leaveDetail!.add(new TimeRegulationLeaveDetail.fromJson(v));
      });
    }
    approvalRemarks = json['ApprovalRemarks'];
    if (json['ApprovalHistory'] != null) {
      approvalHistory = <ApprovalHistory>[];
      json['ApprovalHistory'].forEach((v) {
        approvalHistory!.add(new ApprovalHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveDetail != null) {
      data['LeaveDetail'] = this.leaveDetail!.map((v) => v.toJson()).toList();
    }
    data['ApprovalRemarks'] = this.approvalRemarks;
    if (this.approvalHistory != null) {
      data['ApprovalHistory'] =
          this.approvalHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeRegulationLeaveDetail {
  int? requestMID;
  String? requestDate;
  String? reqDate; /// Because backend team was not fixing this duplication. he created two models separately without any need there was no reuse ability concept implement by team. In short bad coding by backend team
  int? typeID;
  int? statusID;
  String? waiveOffStatus;
  String? waiveOffRemarks;
  String? createdDate;
  String? timeIn;
  String? waiveOffTimeIn;
  String? timeOut;
  String? waiveOffTimeOut;
  int? notiStatusID;
  String? statusName;
  int? entryID;
  int? approvalStatusID;
  int? approvedBy;

  TimeRegulationLeaveDetail(
      {this.requestMID,
        this.requestDate,
        this.typeID,
        this.waiveOffRemarks,
        this.statusID,
        this.waiveOffStatus,
        this.createdDate,
        this.timeIn,
        this.waiveOffTimeIn,
        this.timeOut,
        this.waiveOffTimeOut,
        this.notiStatusID,
        this.statusName,
        this.entryID,
        this.approvalStatusID,
        this.approvedBy});

  TimeRegulationLeaveDetail.fromJson(Map<String, dynamic> json) {
    requestMID = json['RequestMID'];
    requestDate = json['RequestDate'];
    reqDate = json['ReqDate'];
    waiveOffRemarks = json['WaiveOffRemarks'];
    typeID = json['TypeID'];
    statusID = json['StatusID'];
    waiveOffStatus = json['WaiveOffStatus'];
    createdDate = json['CreatedDate'];
    timeIn = json['TimeIn'];
    waiveOffTimeIn = json['WaiveOffTimeIn'];
    timeOut = json['TimeOut'];
    waiveOffTimeOut = json['WaiveOffTimeOut'];
    notiStatusID = json['NotiStatusID'];
    statusName = json['StatusName'];
    entryID = json['EntryID'];
    approvalStatusID = json['ApprovalStatusID'];
    approvedBy = json['ApprovedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RequestMID'] = this.requestMID;
    data['RequestDate'] = this.requestDate;
    data['ReqDate'] = reqDate;
    data['WaiveOffRemarks'] = waiveOffRemarks;
    data['TypeID'] = this.typeID;
    data['StatusID'] = this.statusID;
    data['WaiveOffStatus'] = this.waiveOffStatus;
    data['CreatedDate'] = this.createdDate;
    data['TimeIn'] = this.timeIn;
    data['WaiveOffTimeIn'] = this.waiveOffTimeIn;
    data['TimeOut'] = this.timeOut;
    data['WaiveOffTimeOut'] = this.waiveOffTimeOut;
    data['NotiStatusID'] = this.notiStatusID;
    data['StatusName'] = this.statusName;
    data['EntryID'] = this.entryID;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['ApprovedBy'] = this.approvedBy;
    return data;
  }
}

