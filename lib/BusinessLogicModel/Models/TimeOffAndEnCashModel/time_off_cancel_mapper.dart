class CancelLeaveMapper {
  String? applicationCode;
  String? cancelLeaveDate;
  String? cancelLeaveRemarks;
  dynamic companyCode;
  dynamic cultureID;
  dynamic employeeCode;
  String? laLeaveApplicationDocument;
  String? laLeaveApplicationTimeoff;

  CancelLeaveMapper(
      {
        // this.advancedSalary,
        // this.airTicket,
        this.applicationCode,
        //this.approvalStatusID,
        this.cancelLeaveDate,
        this.cancelLeaveRemarks,
        this.companyCode,
        // this.coveringEmployeeCode,
        // this.createdBy,
        this.cultureID,
        // this.dependentTraveling,
        // this.eCIName,
        // this.eCINumber,
        this.employeeCode,
        // this.exitReEntry,
        // this.iD,
        // this.leaveTypeCode,
        // this.modifiedBy,
        // this.reasonID,
        // this.remarks,
        // this.requestDate,
        this.laLeaveApplicationDocument,
        this.laLeaveApplicationTimeoff});

  CancelLeaveMapper.fromJson(Map<String, dynamic> json) {
    // advancedSalary = json['AdvancedSalary'];
    // airTicket = json['AirTicket'];
    applicationCode = json['ApplicationCode'];
    //approvalStatusID = json['ApprovalStatusID'];
    cancelLeaveDate = json['CancelLeaveDate'];
    cancelLeaveRemarks = json['CancelLeaveRemarks'];
    companyCode = json['CompanyCode'];
    // coveringEmployeeCode = json['CoveringEmployeeCode'];
    // createdBy = json['CreatedBy'];
    cultureID = json['CultureID'];
    // dependentTraveling = json['DependentTraveling'];
    // eCIName = json['ECIName'];
    // eCINumber = json['ECINumber'];
    employeeCode = json['EmployeeCode'];
    // exitReEntry = json['ExitReEntry'];
    // iD = json['ID'];
    // leaveTypeCode = json['LeaveTypeCode'];
    // modifiedBy = json['ModifiedBy'];
    // reasonID = json['ReasonID'];
    // remarks = json['Remarks'];
    // requestDate = json['RequestDate'];
    laLeaveApplicationDocument = json['la_leave_application_document'];
    laLeaveApplicationTimeoff = json['la_leave_application_timeoff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['AdvancedSalary'] = this.advancedSalary;
    // data['AirTicket'] = this.airTicket;
    data['ApplicationCode'] = this.applicationCode;
    //data['ApprovalStatusID'] = this.approvalStatusID;
    data['CancelLeaveDate'] = this.cancelLeaveDate;
    data['CancelLeaveRemarks'] = this.cancelLeaveRemarks;
    data['CompanyCode'] = this.companyCode;
    // data['CoveringEmployeeCode'] = this.coveringEmployeeCode;
    // data['CreatedBy'] = this.createdBy;
    data['CultureID'] = this.cultureID;
    // data['DependentTraveling'] = this.dependentTraveling;
    // data['ECIName'] = this.eCIName;
    // data['ECINumber'] = this.eCINumber;
    data['EmployeeCode'] = this.employeeCode;
    // data['ExitReEntry'] = this.exitReEntry;
    // data['ID'] = this.iD;
    // data['LeaveTypeCode'] = this.leaveTypeCode;
    // data['ModifiedBy'] = this.modifiedBy;
    // data['ReasonID'] = this.reasonID;
    // data['Remarks'] = this.remarks;
    // data['RequestDate'] = this.requestDate;
    data['la_leave_application_document'] = this.laLeaveApplicationDocument;
    data['la_leave_application_timeoff'] = this.laLeaveApplicationTimeoff;
    return data;
  }
}