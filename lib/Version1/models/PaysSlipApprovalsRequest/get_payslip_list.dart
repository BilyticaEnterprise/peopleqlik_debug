class GetPaySlipListJson {
  bool? isSuccess;
  GetPaySlipListResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetPaySlipListJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetPaySlipListJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new GetPaySlipListResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet?.toJson();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class GetPaySlipListResultSet {
  int? totalRecord;
  List<GetPaySlipDataList>? dataList;

  GetPaySlipListResultSet({this.totalRecord, this.dataList});

  GetPaySlipListResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = new List<GetPaySlipDataList>.empty(growable: true);
      json['DataList'].forEach((v) {
        dataList?.add(new GetPaySlipDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalRecord'] = this.totalRecord;
    if (this.dataList != null) {
      data['DataList'] = this.dataList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GetPaySlipDataList {
  String? iD;
  int? cultureID;
  int? salarySlipNo;
  dynamic employeeCode;
  String? employeeName;
  dynamic companyCode;
  String? displayName;
  String? processDate;
  String? calendarTitle;
  String? periodCode;
  String? periodTitle;
  String? periodDate;
  int? quickPayrollReasonID;
  String? quickPayrollReason;

  GetPaySlipDataList(
      {this.iD,
        this.cultureID,
        this.salarySlipNo,
        this.employeeCode,
        this.employeeName,
        this.companyCode,
        this.displayName,
        this.processDate,
        this.calendarTitle,
        this.periodCode,
        this.periodTitle,
        this.periodDate,
        this.quickPayrollReasonID,
        this.quickPayrollReason});

  GetPaySlipDataList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    cultureID = json['CultureID'];
    salarySlipNo = json['SalarySlipNo'];
    employeeCode = json['EmployeeCode'];
    employeeName = json['EmployeeName'];
    companyCode = json['CompanyCode'];
    displayName = json['DisplayName'];
    processDate = json['ProcessDate'];
    calendarTitle = json['CalendarTitle'];
    periodCode = json['PeriodCode'];
    periodTitle = json['PeriodTitle'];
    periodDate = json['PeriodDate'];
    quickPayrollReasonID = json['QuickPayrollReasonID'];
    quickPayrollReason = json['QuickPayrollReason'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CultureID'] = this.cultureID;
    data['SalarySlipNo'] = this.salarySlipNo;
    data['EmployeeCode'] = this.employeeCode;
    data['EmployeeName'] = this.employeeName;
    data['CompanyCode'] = this.companyCode;
    data['DisplayName'] = this.displayName;
    data['ProcessDate'] = this.processDate;
    data['CalendarTitle'] = this.calendarTitle;
    data['PeriodCode'] = this.periodCode;
    data['PeriodTitle'] = this.periodTitle;
    data['PeriodDate'] = this.periodDate;
    data['QuickPayrollReasonID'] = this.quickPayrollReasonID;
    data['QuickPayrollReason'] = this.quickPayrollReason;
    return data;
  }
}