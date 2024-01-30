import '../PaysSlipApprovalsRequest/get_approvals_detail_model.dart';
import 'overtime_team_model.dart';

class OvertimeDetailModel {
  bool? isSuccess;
  OvertimeDetailResultSet? resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;
  dynamic errorResultSet;

  OvertimeDetailModel(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo,
        this.errorResultSet});

  OvertimeDetailModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new OvertimeDetailResultSet.fromJson(json['ResultSet'])
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

class OvertimeDetailResultSet {
  List<OvertimeTeamListDataList>? requestDetail;
  List<OvertimeTeamListDataList>? dataList;
  List<ApprovalHistory>? approvalHistory;

  OvertimeDetailResultSet({this.requestDetail, this.approvalHistory});

  OvertimeDetailResultSet.fromJson(Map<String, dynamic> json) {
    if (json['ReuestDetail'] != null) {
      requestDetail = <OvertimeTeamListDataList>[];
      json['ReuestDetail'].forEach((v) {
        requestDetail!.add(new OvertimeTeamListDataList.fromJson(v));
      });
    }
    if (json['LeaveDetail'] != null) {
      dataList = <OvertimeTeamListDataList>[];
      json['LeaveDetail'].forEach((v) {
        dataList!.add(new OvertimeTeamListDataList.fromJson(v));
      });
    }
    if (json['ApprovalHistory'] != null) {
      approvalHistory = <ApprovalHistory>[];
      json['ApprovalHistory'].forEach((v) {
        approvalHistory!.add(ApprovalHistory.fromJson(v));
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

class ReuestDetail {
  String? name;
  int? overtimeMinutes;
  String? appliedDate;
  String? overtimeType;
  String? shiftStartTime;
  String? shiftEndTime;
  String? employeeCode;
  bool? active;
  int? approvalStatusID;
  int? empCode;
  int? companyCode;
  int? cultureID;
  String? status;
  String? ovtDate;

  ReuestDetail(
      {this.name,
        this.overtimeMinutes,
        this.appliedDate,
        this.overtimeType,
        this.shiftStartTime,
        this.shiftEndTime,
        this.employeeCode,
        this.active,
        this.approvalStatusID,
        this.empCode,
        this.companyCode,
        this.cultureID,
        this.status,
        this.ovtDate});

  ReuestDetail.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    overtimeMinutes = json['OvertimeMinutes'];
    appliedDate = json['AppliedDate'];
    overtimeType = json['OvertimeType'];
    shiftStartTime = json['ShiftStartTime'];
    shiftEndTime = json['ShiftEndTime'];
    employeeCode = json['EmployeeCode'];
    active = json['Active'];
    approvalStatusID = json['ApprovalStatusID'];
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
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['EmpCode'] = this.empCode;
    data['CompanyCode'] = this.companyCode;
    data['CultureID'] = this.cultureID;
    data['Status'] = this.status;
    data['OvtDate'] = this.ovtDate;
    return data;
  }
}