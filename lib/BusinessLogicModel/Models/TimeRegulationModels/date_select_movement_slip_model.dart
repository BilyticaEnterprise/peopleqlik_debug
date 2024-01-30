class DateSelectMovementSlipModel {
  bool? isSuccess;
  List<DateSelectResultSet>? resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;

  DateSelectMovementSlipModel(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo});

  DateSelectMovementSlipModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    if (json['ResultSet'] != null) {
      resultSet = <DateSelectResultSet>[];
      json['ResultSet'].forEach((v) {
        resultSet!.add(DateSelectResultSet.fromJson(v));
      });
    }
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    documentNo = json['DocumentNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.map((v) => v.toJson()).toList();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    data['DocumentNo'] = this.documentNo;
    return data;
  }
}

class DateSelectResultSet {
  int? entryID;
  String? timeIn;
  int? employeeCode;
  int? companyCode;
  String? fullName;
  String? timeOut;
  dynamic waiveOffTypeIDs;
  String? attendanceDate;
  List<int>? statusIDs;
  String? statusName;
  String? statusId;
  bool? canApplyforthistransaction;

  DateSelectResultSet(
      {this.entryID,
        this.timeIn,
        this.employeeCode,
        this.companyCode,
        this.fullName,
        this.timeOut,
        this.waiveOffTypeIDs,
        this.attendanceDate,
        this.statusIDs,
        this.statusName,
        this.statusId,
        this.canApplyforthistransaction});

  DateSelectResultSet.fromJson(Map<String, dynamic> json) {
    entryID = json['EntryID'];
    timeIn = json['TimeIn'];
    employeeCode = json['EmployeeCode'];
    companyCode = json['CompanyCode'];
    fullName = json['FullName'];
    timeOut = json['TimeOut'];
    waiveOffTypeIDs = json['WaiveOffTypeIDs'];
    attendanceDate = json['AttendanceDate'];
    statusIDs = json['StatusIDs'].cast<int>();
    statusName = json['StatusName'];
    statusId = json['StatusId'];
    canApplyforthistransaction = json['CanApplyforthistransaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EntryID'] = this.entryID;
    data['TimeIn'] = this.timeIn;
    data['EmployeeCode'] = this.employeeCode;
    data['CompanyCode'] = this.companyCode;
    data['FullName'] = this.fullName;
    data['TimeOut'] = this.timeOut;
    data['WaiveOffTypeIDs'] = this.waiveOffTypeIDs;
    data['AttendanceDate'] = this.attendanceDate;
    data['StatusIDs'] = this.statusIDs;
    data['StatusName'] = this.statusName;
    data['StatusId'] = this.statusId;
    data['CanApplyforthistransaction'] = this.canApplyforthistransaction;
    return data;
  }
}