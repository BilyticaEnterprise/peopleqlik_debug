class ApplyOvertimeMapper {
  List<OvertimeList>? overtimeList;
  String? fromDate;
  String? toDate;

  ApplyOvertimeMapper({this.overtimeList, this.fromDate, this.toDate});

  ApplyOvertimeMapper.fromJson(Map<String, dynamic> json) {
    if (json['OvertimeList'] != null) {
      overtimeList = <OvertimeList>[];
      json['OvertimeList'].forEach((v) {
        overtimeList!.add(new OvertimeList.fromJson(v));
      });
    }
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.overtimeList != null) {
      data['OvertimeList'] = this.overtimeList!.map((v) => v.toJson()).toList();
    }
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    return data;
  }
}

class OvertimeList {
  int? entryID;
  int? companyCode;
  int? employeeCode;
  int? cultureID;
  int? actualOVTHours;
  int? approvedOVTHours;
  String? calendarCode;
  String? fromDate;
  String? toDate;
  int? approvalStatusID;
  int? typeID;
  int? active;

  OvertimeList(
      {this.entryID,
        this.companyCode,
        this.employeeCode,
        this.cultureID,
        this.actualOVTHours,
        this.approvedOVTHours,
        this.calendarCode,
        this.fromDate,
        this.toDate,
        this.approvalStatusID,
        this.typeID,
        this.active});

  OvertimeList.fromJson(Map<String, dynamic> json) {
    entryID = json['EntryID'];
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    cultureID = json['CultureID'];
    actualOVTHours = json['ActualOVTHours'];
    approvedOVTHours = json['ApprovedOVTHours'];
    calendarCode = json['CalendarCode'];
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    approvalStatusID = json['ApprovalStatusID'];
    typeID = json['TypeID'];
    active = json['Active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EntryID'] = this.entryID;
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    data['CultureID'] = this.cultureID;
    data['ActualOVTHours'] = this.actualOVTHours;
    data['ApprovedOVTHours'] = this.approvedOVTHours;
    data['CalendarCode'] = this.calendarCode;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['TypeID'] = this.typeID;
    data['Active'] = this.active;
    return data;
  }
}