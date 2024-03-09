class ErrorResultSet {
  List<LimitErrorList>? limitErrorList;
  List<EmployeeErrorList>? employeeErrorList;
  List<ShiftPendingList>? shiftPendingList;

  ErrorResultSet(
      {this.limitErrorList, this.employeeErrorList, this.shiftPendingList});

  ErrorResultSet.fromJson(Map<String, dynamic> json) {
    if (json['LimitErrorList'] != null) {
      limitErrorList = <LimitErrorList>[];
      json['LimitErrorList'].forEach((v) {
        limitErrorList!.add(new LimitErrorList.fromJson(v));
      });
    }
    if (json['EmployeeErrorList'] != null) {
      employeeErrorList = <EmployeeErrorList>[];
      json['EmployeeErrorList'].forEach((v) {
        employeeErrorList!.add(new EmployeeErrorList.fromJson(v));
      });
    }
    if (json['ShiftPendingList'] != null) {
      shiftPendingList = <ShiftPendingList>[];
      json['ShiftPendingList'].forEach((v) {
        shiftPendingList!.add(new ShiftPendingList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.limitErrorList != null) {
      data['LimitErrorList'] =
          this.limitErrorList!.map((v) => v.toJson()).toList();
    }
    if (this.employeeErrorList != null) {
      data['EmployeeErrorList'] =
          this.employeeErrorList!.map((v) => v.toJson()).toList();
    }
    if (this.shiftPendingList != null) {
      data['ShiftPendingList'] =
          this.shiftPendingList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LimitErrorList {
  String? employee;
  String? monthlyOvertimeApplied;
  String? monthlyOvertimeLimit;
  String? yearlyOvertimeApplied;
  String? yearlyOvertimeLimit;
  String? weeklyOvertimeApplied;
  String? weeklyOvertimeLimit;

  LimitErrorList(
      {this.employee,
        this.monthlyOvertimeApplied,
        this.monthlyOvertimeLimit,
        this.yearlyOvertimeApplied,
        this.yearlyOvertimeLimit,
        this.weeklyOvertimeApplied,
        this.weeklyOvertimeLimit});

  LimitErrorList.fromJson(Map<String, dynamic> json) {
    employee = json['Employee'];
    monthlyOvertimeApplied = json['MonthlyOvetimeApplied'];
    monthlyOvertimeLimit = json['MonthlyOvertimeLimit'];
    yearlyOvertimeApplied = json['YearlyOvertimeApplied'];
    yearlyOvertimeLimit = json['YearlyOvertimeLimit'];
    weeklyOvertimeApplied = json['WeeklyOvertimeApplied'];
    weeklyOvertimeLimit = json['WeeklyOvertimeLimit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Employee'] = this.employee;
    data['MonthlyOvetimeApplied'] = this.monthlyOvertimeApplied;
    data['MonthlyOvertimeLimit'] = this.monthlyOvertimeLimit;
    data['YearlyOvertimeApplied'] = this.yearlyOvertimeApplied;
    data['YearlyOvertimeLimit'] = this.yearlyOvertimeLimit;
    data['WeeklyOvertimeApplied'] = this.weeklyOvertimeApplied;
    data['WeeklyOvertimeLimit'] = this.weeklyOvertimeLimit;
    return data;
  }
}

class EmployeeErrorList {
  String? employee;
  String? oVTDate;
  String? oVTDateFormat;
  double? ovtHours;

  EmployeeErrorList(
      {this.employee, this.oVTDate, this.oVTDateFormat, this.ovtHours});

  EmployeeErrorList.fromJson(Map<String, dynamic> json) {
    employee = json['Employee'];
    oVTDate = json['OVTDate'];
    oVTDateFormat = json['OVTDateFormat'];
    ovtHours = json['OvtHours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Employee'] = this.employee;
    data['OVTDate'] = this.oVTDate;
    data['OVTDateFormat'] = this.oVTDateFormat;
    data['OvtHours'] = this.ovtHours;
    return data;
  }
}

class ShiftPendingList {
  String? employee;
  String? shiftDate;
  String? shiftName;

  ShiftPendingList({this.employee, this.shiftDate, this.shiftName});

  ShiftPendingList.fromJson(Map<String, dynamic> json) {
    employee = json['Employee'];
    shiftDate = json['ShiftDate'];
    shiftName = json['ShiftName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Employee'] = this.employee;
    data['ShiftDate'] = this.shiftDate;
    data['ShiftName'] = this.shiftName;
    return data;
  }
}