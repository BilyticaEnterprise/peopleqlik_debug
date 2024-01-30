class ShiftFormMapper {
  int? permenantID;
  int? companyCode;
  int? employeeCode;
  int? cultureID;
  int? regularShiftID;
  int? ramadanShiftID;
  int? approvalStatusID;
  int? active;
  String? effectiveDate;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  List<LaShiftSchedulePermenantDt>? laShiftSchedulePermenantDt;

  ShiftFormMapper(
      {this.permenantID = 0,
        this.companyCode,
        this.employeeCode,
        this.cultureID,
        this.regularShiftID,
        this.ramadanShiftID,
        this.approvalStatusID,
        this.active = 0,
        this.effectiveDate,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.laShiftSchedulePermenantDt});

  ShiftFormMapper.fromJson(Map<String, dynamic> json) {
    permenantID = json['PermenantID'];
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    cultureID = json['CultureID'];
    regularShiftID = json['RegularShiftID'];
    ramadanShiftID = json['RamadanShiftID'];
    approvalStatusID = json['ApprovalStatusID'];
    active = json['Active'];
    effectiveDate = json['EffectiveDate'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedBy = json['ModifiedBy'];
    modifiedDate = json['ModifiedDate'];
    if (json['la_shift_schedule_permenant_dt'] != null) {
      laShiftSchedulePermenantDt = <LaShiftSchedulePermenantDt>[];
      json['la_shift_schedule_permenant_dt'].forEach((v) {
        laShiftSchedulePermenantDt!
            .add(new LaShiftSchedulePermenantDt.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PermenantID'] = this.permenantID;
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    data['CultureID'] = this.cultureID;
    data['RegularShiftID'] = this.regularShiftID;
    data['RamadanShiftID'] = this.ramadanShiftID;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['Active'] = this.active;
    data['EffectiveDate'] = this.effectiveDate;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedDate'] = this.modifiedDate;
    if (this.laShiftSchedulePermenantDt != null) {
      data['la_shift_schedule_permenant_dt'] =
          this.laShiftSchedulePermenantDt!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LaShiftSchedulePermenantDt {
  int? permenantID;
  int? weekDayID;

  LaShiftSchedulePermenantDt({this.permenantID, this.weekDayID});

  LaShiftSchedulePermenantDt.fromJson(Map<String, dynamic> json) {
    permenantID = json['PermenantID'];
    weekDayID = json['WeekDayID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PermenantID'] = this.permenantID;
    data['WeekDayID'] = this.weekDayID;
    return data;
  }
}