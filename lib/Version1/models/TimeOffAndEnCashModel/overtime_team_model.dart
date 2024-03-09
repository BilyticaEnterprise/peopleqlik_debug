class OvertimeTeamListMapper {
  bool? isSuccess;
  OvertimeTeamListResultSet? resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;

  OvertimeTeamListMapper(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo});

  OvertimeTeamListMapper.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new OvertimeTeamListResultSet.fromJson(json['ResultSet'])
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

class OvertimeTeamListResultSet {
  int? totalRecord;
  List<OvertimeTeamListDataList>? dataList;

  OvertimeTeamListResultSet({this.totalRecord, this.dataList});

  OvertimeTeamListResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = <OvertimeTeamListDataList>[];
      json['DataList'].forEach((v) {
        dataList!.add(new OvertimeTeamListDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalRecord'] = this.totalRecord;
    if (this.dataList != null) {
      data['DataList'] = this.dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OvertimeTeamListDataList {
  String? name;
  double? overtimeMinutes;
  String? appliedDate;
  String? overtimeType;
  String? shiftStartTime;
  String? shiftEndTime;
  dynamic employeeCode;
  String? ovtDate;
  bool? active;
  int? approvalStatusID;
  String? status;

  OvertimeTeamListDataList(
      {this.name,
        this.overtimeMinutes,
        this.appliedDate,
        this.overtimeType,
        this.shiftStartTime,
        this.shiftEndTime,
        this.employeeCode,
        this.active,
        this.ovtDate,
        this.approvalStatusID,
        this.status});

  OvertimeTeamListDataList.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    overtimeMinutes = json['OvertimeMinutes'];
    appliedDate = json['AppliedDate'];
    overtimeType = json['OvertimeType'];
    shiftStartTime = json['ShiftStartTime'];
    ovtDate = json['OvtDate'];
    shiftEndTime = json['ShiftEndTime'];
    employeeCode = json['EmployeeCode'];
    active = json['Active'];
    approvalStatusID = json['ApprovalStatusID'];
    status = json['Status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['OvertimeMinutes'] = this.overtimeMinutes;
    data['AppliedDate'] = this.appliedDate;
    data['OvertimeType'] = this.overtimeType;
    data['OvtDate'] = ovtDate;
    data['ShiftStartTime'] = this.shiftStartTime;
    data['ShiftEndTime'] = this.shiftEndTime;
    data['EmployeeCode'] = this.employeeCode;
    data['Active'] = this.active;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['Status'] = this.status;
    return data;
  }
}