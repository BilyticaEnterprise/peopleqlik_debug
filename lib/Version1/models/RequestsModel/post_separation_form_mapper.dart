class SaveSeparationMapper {
  int? approvalStatusID;
  dynamic companyCode;
  String? createdBy;
  String? cultureID;
  String? effectiveFrom;
  dynamic employeeCode;
  String? jobCode;
  String? lastWorkingDate;
  String? modifiedBy;
  String? remarks;

  SaveSeparationMapper(
      {this.approvalStatusID,
        this.companyCode,
        this.createdBy,
        this.cultureID,
        this.effectiveFrom,
        this.employeeCode,
        this.jobCode,
        this.lastWorkingDate,
        this.modifiedBy,
        this.remarks});

  SaveSeparationMapper.fromJson(Map<String, dynamic> json) {
    approvalStatusID = json['ApprovalStatusID'];
    companyCode = json['CompanyCode'];
    createdBy = json['CreatedBy'];
    cultureID = json['CultureID'];
    effectiveFrom = json['EffectiveFrom'];
    employeeCode = json['EmployeeCode'];
    jobCode = json['JobCode'];
    lastWorkingDate = json['LastWorkingDate'];
    modifiedBy = json['ModifiedBy'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['CompanyCode'] = this.companyCode;
    data['CreatedBy'] = this.createdBy;
    data['CultureID'] = this.cultureID;
    data['EffectiveFrom'] = this.effectiveFrom;
    data['EmployeeCode'] = this.employeeCode;
    data['JobCode'] = this.jobCode;
    data['LastWorkingDate'] = this.lastWorkingDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['Remarks'] = this.remarks;
    return data;
  }
}