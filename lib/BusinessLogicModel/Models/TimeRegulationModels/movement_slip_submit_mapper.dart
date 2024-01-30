class MovementSlipSubmitMapper {
  int? approvalStatusID;
  String? attendanceDate;
  dynamic officePermissionTypeID;
  int? typeID;
  List<LaWaiveOffRequestDt>? laWaiveOffRequestDt;

  MovementSlipSubmitMapper(
      {this.approvalStatusID,
        this.attendanceDate,
        this.officePermissionTypeID,
        this.typeID,
        this.laWaiveOffRequestDt});

  MovementSlipSubmitMapper.fromJson(Map<String, dynamic> json) {
    approvalStatusID = json['ApprovalStatusID'];
    attendanceDate = json['AttendanceDate'];
    officePermissionTypeID = json['OfficePermissionTypeID'];
    typeID = json['TypeID'];
    if (json['la_waive_off_request_dt'] != null) {
      laWaiveOffRequestDt = <LaWaiveOffRequestDt>[];
      json['la_waive_off_request_dt'].forEach((v) {
        laWaiveOffRequestDt!.add(new LaWaiveOffRequestDt.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['AttendanceDate'] = this.attendanceDate;
    data['OfficePermissionTypeID'] = this.officePermissionTypeID;
    data['TypeID'] = this.typeID;
    if (this.laWaiveOffRequestDt != null) {
      data['la_waive_off_request_dt'] =
          this.laWaiveOffRequestDt!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LaWaiveOffRequestDt {
  int? entryID;
  String? fileName;
  String? remarks;
  String? timeIn;
  String? timeOut;
  int? employeeCode;
  int? companyCode;

  LaWaiveOffRequestDt(
      {this.entryID,
        this.fileName,
        this.remarks,
        this.timeIn,
        this.timeOut,
        this.employeeCode,
        this.companyCode});

  LaWaiveOffRequestDt.fromJson(Map<String, dynamic> json) {
    entryID = json['EntryID'];
    fileName = json['FileName'];
    remarks = json['Remarks'];
    timeIn = json['TimeIn'];
    timeOut = json['TimeOut'];
    employeeCode = json['EmployeeCode'];
    companyCode = json['CompanyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EntryID'] = this.entryID;
    data['FileName'] = this.fileName;
    data['Remarks'] = this.remarks;
    data['TimeIn'] = this.timeIn;
    data['TimeOut'] = this.timeOut;
    data['EmployeeCode'] = this.employeeCode;
    data['CompanyCode'] = this.companyCode;
    return data;
  }
}