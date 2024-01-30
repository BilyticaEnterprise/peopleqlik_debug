class GetPaySlipMonthJson {
  bool? isSuccess;
  List<GetPaySlipResultSet>? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetPaySlipMonthJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetPaySlipMonthJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    if (json['ResultSet'] != null) {
      resultSet = new List<GetPaySlipResultSet>.empty(growable: true);
      json['ResultSet'].forEach((v) {
        resultSet?.add(new GetPaySlipResultSet.fromJson(v));
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

class GetPaySlipResultSet {
  String? departmentCode;
  String? departmentTitle;
  String? departmentDesc;
  dynamic employeeCode;
  String? employeeName;
  dynamic companyCode;
  String? legalName;
  int? currencyID;
  String? curTitle;
  String? curDescription;
  String? calendarCode;
  String? periodCode;
  String? classCode;
  String? classTiltle;
  String? classDesc;
  int? elementTypeID;
  String? elementTypeName;
  String? elementCode;
  String? elementTitle;
  String? elementDesc;
  double? amount;

  GetPaySlipResultSet(
      {this.departmentCode,
        this.departmentTitle,
        this.departmentDesc,
        this.employeeCode,
        this.employeeName,
        this.companyCode,
        this.legalName,
        this.currencyID,
        this.curTitle,
        this.curDescription,
        this.calendarCode,
        this.periodCode,
        this.classCode,
        this.classTiltle,
        this.classDesc,
        this.elementTypeID,
        this.elementTypeName,
        this.elementCode,
        this.elementTitle,
        this.elementDesc,
        this.amount});

  GetPaySlipResultSet.fromJson(Map<String, dynamic> json) {
    departmentCode = json['DepartmentCode'];
    departmentTitle = json['DepartmentTitle'];
    departmentDesc = json['DepartmentDesc'];
    employeeCode = json['EmployeeCode'];
    employeeName = json['EmployeeName'];
    companyCode = json['CompanyCode'];
    legalName = json['LegalName'];
    currencyID = json['CurrencyID'];
    curTitle = json['CurTitle'];
    curDescription = json['CurDescription'];
    calendarCode = json['CalendarCode'];
    periodCode = json['PeriodCode'];
    classCode = json['ClassCode'];
    classTiltle = json['ClassTiltle'];
    classDesc = json['ClassDesc'];
    elementTypeID = json['ElementTypeID'];
    elementTypeName = json['ElementTypeName'];
    elementCode = json['ElementCode'];
    elementTitle = json['ElementTitle'];
    elementDesc = json['ElementDesc'];
    amount = json['Amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DepartmentCode'] = this.departmentCode;
    data['DepartmentTitle'] = this.departmentTitle;
    data['DepartmentDesc'] = this.departmentDesc;
    data['EmployeeCode'] = this.employeeCode;
    data['EmployeeName'] = this.employeeName;
    data['CompanyCode'] = this.companyCode;
    data['LegalName'] = this.legalName;
    data['CurrencyID'] = this.currencyID;
    data['CurTitle'] = this.curTitle;
    data['CurDescription'] = this.curDescription;
    data['CalendarCode'] = this.calendarCode;
    data['PeriodCode'] = this.periodCode;
    data['ClassCode'] = this.classCode;
    data['ClassTiltle'] = this.classTiltle;
    data['ClassDesc'] = this.classDesc;
    data['ElementTypeID'] = this.elementTypeID;
    data['ElementTypeName'] = this.elementTypeName;
    data['ElementCode'] = this.elementCode;
    data['ElementTitle'] = this.elementTitle;
    data['ElementDesc'] = this.elementDesc;
    data['Amount'] = this.amount;
    return data;
  }
}