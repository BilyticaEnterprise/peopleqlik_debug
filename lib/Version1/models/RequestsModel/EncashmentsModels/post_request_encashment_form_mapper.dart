class SaveEncashmentRequestFormMapper {
  String? cultureID;
  String? paymentTypeID;
  String? leaveTypeCode;
  String? encashmentUnit;
  dynamic companyCode;
  dynamic employeeCode;
  String? balanceUnit;
  String? maxEncashmentUnit;
  String? typeID;
  String? leaveType;
  int? approvalStatusID;
  String? calendarCode;
  List<LaLeaveEncashmentRequestDt>? laLeaveEncashmentRequestDt;

  SaveEncashmentRequestFormMapper(
      {this.cultureID,
        this.paymentTypeID,
        this.leaveTypeCode,
        this.encashmentUnit,
        this.balanceUnit,
        this.maxEncashmentUnit,
        this.typeID,
        this.leaveType,
        this.approvalStatusID,
        this.calendarCode,
        this.laLeaveEncashmentRequestDt});

  SaveEncashmentRequestFormMapper.fromJson(Map<String, dynamic> json) {
    cultureID = json['CultureID'];
    paymentTypeID = json['PaymentTypeID'];
    leaveTypeCode = json['LeaveTypeCode'];
    encashmentUnit = json['EncashmentUnit'];
    balanceUnit = json['BalanceUnit'];
    maxEncashmentUnit = json['MaxEncashmentUnit'];
    typeID = json['TypeID'];
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    leaveType = json['LeaveType'];
    approvalStatusID = json['ApprovalStatusID'];
    calendarCode = json['CalendarCode'];
    if (json['la_leave_encashment_request_dt'] != null) {
      laLeaveEncashmentRequestDt = <LaLeaveEncashmentRequestDt>[];
      json['la_leave_encashment_request_dt'].forEach((v) {
        laLeaveEncashmentRequestDt!
            .add(new LaLeaveEncashmentRequestDt.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CultureID'] = this.cultureID;
    data['PaymentTypeID'] = this.paymentTypeID;
    data['LeaveTypeCode'] = this.leaveTypeCode;
    data['EncashmentUnit'] = this.encashmentUnit;
    data['CompanyCode'] = companyCode;
    data['EmployeeCode'] = employeeCode;
    data['BalanceUnit'] = this.balanceUnit;
    data['MaxEncashmentUnit'] = this.maxEncashmentUnit;
    data['TypeID'] = this.typeID;
    data['LeaveType'] = this.leaveType;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['CalendarCode'] = this.calendarCode;
    if (this.laLeaveEncashmentRequestDt != null) {
      data['la_leave_encashment_request_dt'] =
          this.laLeaveEncashmentRequestDt!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LaLeaveEncashmentRequestDt {
  int? iD;
  String? cultureID;
  String? fileName;
  String? fileSize;

  LaLeaveEncashmentRequestDt(
      {this.iD, this.cultureID, this.fileName, this.fileSize});

  LaLeaveEncashmentRequestDt.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    cultureID = json['CultureID'];
    fileName = json['FileName'];
    fileSize = json['FileSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CultureID'] = this.cultureID;
    data['FileName'] = this.fileName;
    data['FileSize'] = this.fileSize;
    return data;
  }
}