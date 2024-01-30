import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';

class ShiftDetailModel {
  bool? isSuccess;
  ResultSet? resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;
  dynamic errorResultSet;

  ShiftDetailModel(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo,
        this.errorResultSet});

  ShiftDetailModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new ResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    documentNo = json['DocumentNo'];
    errorResultSet = json['ErrorResultSet'];
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
    data['ErrorResultSet'] = this.errorResultSet;
    return data;
  }
}

class ResultSet {
  List<ShiftRequestDetail>? requestDetail;
  List<ApprovalHistory>? approvalHistory;
  List<ShiftRequestDetail>? dataList;

  ResultSet({this.requestDetail, this.approvalHistory,this.dataList});

  ResultSet.fromJson(Map<String, dynamic> json) {
    if (json['ReuestDetail'] != null) {
      requestDetail = <ShiftRequestDetail>[];
      json['ReuestDetail'].forEach((v) {
        requestDetail!.add(new ShiftRequestDetail.fromJson(v));
      });
    }
    if (json['LeaveDetail'] != null) {
      dataList = <ShiftRequestDetail>[];
      json['LeaveDetail'].forEach((v) {
        dataList!.add(new ShiftRequestDetail.fromJson(v));
      });
    }
    if (json['ApprovalHistory'] != null) {
      approvalHistory = <ApprovalHistory>[];
      json['ApprovalHistory'].forEach((v) {
        approvalHistory!.add(new ApprovalHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requestDetail != null) {
      data['ReuestDetail'] = this.requestDetail!.map((v) => v.toJson()).toList();
    }
    if (this.dataList != null) {
      data['LeaveDetail'] = this.dataList!.map((v) => v.toJson()).toList();
    }
    if (this.approvalHistory != null) {
      data['ApprovalHistory'] =
          this.approvalHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShiftRequestDetail {
  int? companyCode;
  int? employeeCode;
  String? regularShift;
  String? createdDate;
  String? ramadanShift;
  String? effectiveDate;
  int? permanentID;
  int? requestMID;
  List<int>? offDays;
  List<String?>? offDaysName; /// Custom made

  ShiftRequestDetail(
      {this.companyCode,
        this.employeeCode,
        this.regularShift,
        this.ramadanShift,
        this.createdDate,
        this.requestMID,
        this.effectiveDate,
        this.permanentID,
        this.offDays});

  ShiftRequestDetail.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    regularShift = json['RegularShift'];
    createdDate = json['CreatedDate'];
    requestMID = json['RequestMID'];
    ramadanShift = json['RamadanShift'];
    effectiveDate = json['EffectiveDate'];
    permanentID = json['PermenantID'];
    offDays = json['OffDays'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    data['RegularShift'] = this.regularShift;
    data['CreatedDate'] = createdDate;
    data['RequestMID'] = requestMID;
    data['RamadanShift'] = this.ramadanShift;
    data['EffectiveDate'] = this.effectiveDate;
    data['PermenantID'] = this.permanentID;
    data['OffDays'] = this.offDays;
    return data;
  }
}