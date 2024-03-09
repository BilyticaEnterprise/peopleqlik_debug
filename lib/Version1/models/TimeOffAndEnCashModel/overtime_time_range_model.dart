class OvertimeTimeRangeModel {
  bool? isSuccess;
  List<OvertimeTimeRangeResultSet>? resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;

  OvertimeTimeRangeModel(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo});

  OvertimeTimeRangeModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    if (json['ResultSet'] != null) {
      resultSet = <OvertimeTimeRangeResultSet>[];
      json['ResultSet'].forEach((v) {
        resultSet!.add(OvertimeTimeRangeResultSet.fromJson(v));
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

class OvertimeTimeRangeResultSet {
  int? employeeCode;
  int? companyCode;
  bool? isOffday;
  int? publicHolidayHours;
  int? weekEndHours;
  int? shiftID;
  bool? isShiftPlanning;
  String? tDate;
  bool? isRamadan;
  int? religionID;
  int? ethnicityID;
  int? nationality;
  String? departmentCode;
  dynamic subDepartmentCode;
  String? shiftCode;
  int? maxWorkingHourDay;
  bool? isAllow;

  OvertimeTimeRangeResultSet(
      {this.employeeCode,
        this.companyCode,
        this.isOffday,
        this.publicHolidayHours,
        this.weekEndHours,
        this.shiftID,
        this.isShiftPlanning,
        this.tDate,
        this.isRamadan,
        this.religionID,
        this.ethnicityID,
        this.nationality,
        this.departmentCode,
        this.subDepartmentCode,
        this.shiftCode,
        this.maxWorkingHourDay,
        this.isAllow});

  OvertimeTimeRangeResultSet.fromJson(Map<String, dynamic> json) {
    employeeCode = json['EmployeeCode'];
    companyCode = json['CompanyCode'];
    isOffday = json['IsOffday'];
    publicHolidayHours = json['PublicHolidayHours'];
    weekEndHours = json['WeekEndHours'];
    shiftID = json['ShiftID'];
    isShiftPlanning = json['IsShiftPlanning'];
    tDate = json['TDate'];
    isRamadan = json['IsRamadan'];
    religionID = json['ReligionID'];
    ethnicityID = json['EthnicityID'];
    nationality = json['Nationality'];
    departmentCode = json['DepartmentCode'];
    subDepartmentCode = json['SubDepartmentCode'];
    shiftCode = json['ShiftCode'];
    maxWorkingHourDay = json['MaxWorkingHourDay'];
    isAllow = json['IsAllow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeCode'] = this.employeeCode;
    data['CompanyCode'] = this.companyCode;
    data['IsOffday'] = this.isOffday;
    data['PublicHolidayHours'] = this.publicHolidayHours;
    data['WeekEndHours'] = this.weekEndHours;
    data['ShiftID'] = this.shiftID;
    data['IsShiftPlanning'] = this.isShiftPlanning;
    data['TDate'] = this.tDate;
    data['IsRamadan'] = this.isRamadan;
    data['ReligionID'] = this.religionID;
    data['EthnicityID'] = this.ethnicityID;
    data['Nationality'] = this.nationality;
    data['DepartmentCode'] = this.departmentCode;
    data['SubDepartmentCode'] = this.subDepartmentCode;
    data['ShiftCode'] = this.shiftCode;
    data['MaxWorkingHourDay'] = this.maxWorkingHourDay;
    data['IsAllow'] = this.isAllow;
    return data;
  }
}