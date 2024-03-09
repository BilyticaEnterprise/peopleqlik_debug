class GetTimeSheetJson {
  bool? isSuccess;
  List<TimeSheetResultSet>? resultSet;
  String? errorMessage;
  String? message;

  GetTimeSheetJson(
      {this.isSuccess,
        this.resultSet,
        this.errorMessage});

  GetTimeSheetJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    if (json['ResultSet'] != null) {
      resultSet = <TimeSheetResultSet>[];
      json['ResultSet'].forEach((v) {
        resultSet!.add(new TimeSheetResultSet.fromJson(v));
      });
    }
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = message;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.map((v) => v.toJson()).toList();
    }
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class TimeSheetResultSet {
  String? attendanceDate;
  String? timeIn;
  String? timeOut;
  dynamic cultureID;
  dynamic statusID;
  String? statusName;
  dynamic companyCode;
  dynamic employeeCode;
  String? employeeName;

  TimeSheetResultSet(
      {this.attendanceDate,
        this.timeIn,
        this.timeOut,
        this.cultureID,
        this.statusID,
        this.statusName,
        this.companyCode,
        this.employeeCode,
        this.employeeName});

  TimeSheetResultSet.fromJson(Map<String, dynamic> json) {
    attendanceDate = json['AttendanceDate'];
    timeIn = json['TimeIn'];
    timeOut = json['TimeOut'];
    cultureID = json['CultureID'];
    statusID = json['StatusID'];
    statusName = json['StatusName'];
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    employeeName = json['EmployeeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AttendanceDate'] = this.attendanceDate;
    data['TimeIn'] = this.timeIn;
    data['TimeOut'] = this.timeOut;
    data['CultureID'] = this.cultureID;
    data['StatusID'] = this.statusID;
    data['StatusName'] = this.statusName;
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    data['EmployeeName'] = this.employeeName;
    return data;
  }
}