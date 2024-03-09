class LeaveSummaryJson {
  bool? isSuccess;
  List<LeaveSummaryResultSet>? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  LeaveSummaryJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  LeaveSummaryJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    if (json['ResultSet'] != null) {
      resultSet = new List<LeaveSummaryResultSet>.empty(growable: true);
      json['ResultSet'].forEach((v) {
        resultSet?.add(new LeaveSummaryResultSet.fromJson(v));
      });
    }
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet?.map((v) => v.toJson()).toList();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class LeaveSummaryResultSet {
  int? iD;
  dynamic employeeCode;
  int? cultureID;
  dynamic companyCode;
  String? leaveTypeCode;
  String? typeTitle;
  String? calendarCode;
  String? balance;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;

  LeaveSummaryResultSet(
      {this.iD,
        this.employeeCode,
        this.cultureID,
        this.companyCode,
        this.leaveTypeCode,
        this.typeTitle,
        this.calendarCode,
        this.balance,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate});

  LeaveSummaryResultSet.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    employeeCode = json['EmployeeCode'];
    cultureID = json['CultureID'];
    companyCode = json['CompanyCode'];
    leaveTypeCode = json['LeaveTypeCode'];
    typeTitle = json['TypeTitle'];
    calendarCode = json['CalendarCode'];
    balance = json['balance'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedBy = json['ModifiedBy'];
    modifiedDate = json['ModifiedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['EmployeeCode'] = this.employeeCode;
    data['CultureID'] = this.cultureID;
    data['CompanyCode'] = this.companyCode;
    data['LeaveTypeCode'] = this.leaveTypeCode;
    data['TypeTitle'] = this.typeTitle;
    data['CalendarCode'] = this.calendarCode;
    data['balance'] = this.balance;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedDate'] = this.modifiedDate;
    return data;
  }
}
