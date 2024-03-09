class ApplyLeaveForm {
  dynamic companyCode;
  dynamic employeeCode;
  String? leaveTypeCode;
  String? leaveFrom;
  String? leaveTo;
  String? remarks;
  String? eCINumber;
  String? eCIName;
  int? fullDayLeave;
  int? halfLeaveTypeID;
  double? totalLeaves;
  double? totalLeavesBalanceCalculator;
  int? reasonID;
  int? approvalStatusID;

  String? phoneNumber;
  String? timeStart;
  String? timeEnd;
  String? dateSelect;
  String? dateStart;
  String? dateEnd;
  String? actualDateToContinue;
  List<AttachmentData>? attachmentData;

  ApplyLeaveForm(
      {this.companyCode,
        this.employeeCode,
        this.leaveTypeCode,
        this.leaveFrom,
        this.leaveTo,
        this.fullDayLeave,
        this.halfLeaveTypeID,
        this.totalLeaves,
        this.approvalStatusID});

  ApplyLeaveForm.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    remarks = json['Remarks'];
    eCIName = json['ECIName'];
    employeeCode = json['EmployeeCode'];
    reasonID = json['ReasonID'];
    if (json['AttachmentData'] != null) {
      attachmentData = List<AttachmentData>.empty(growable: true);
      json['AttachmentData'].forEach((v) {
        attachmentData?.add(AttachmentData.fromJson(v));
      });
    }
    eCINumber = json['ECINumber'];
    leaveTypeCode = json['LeaveTypeCode'];
    leaveFrom = json['LeaveFrom'];
    leaveTo = json['LeaveTo'];
    fullDayLeave = json['FullDayLeave'];
    halfLeaveTypeID = json['HalfLeaveTypeID'];
    totalLeaves = json['TotalLeaves'];
    approvalStatusID = json['ApprovalStatusID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CompanyCode'] = companyCode;
    data['Remarks'] = remarks;
    data['ECIName'] = eCIName;
    data['ECINumber'] = eCINumber;
    if (attachmentData != null) {
      data['AttachmentData'] =
          attachmentData?.map((v) => v.toJson()).toList();
    }
    data['EmployeeCode'] = employeeCode;
    data['ReasonID'] = reasonID;
    data['LeaveTypeCode'] = leaveTypeCode;
    data['LeaveFrom'] = leaveFrom;
    data['LeaveTo'] = leaveTo;
    data['FullDayLeave'] = fullDayLeave;
    data['HalfLeaveTypeID'] = halfLeaveTypeID;
    data['TotalLeaves'] = totalLeaves;
    data['ApprovalStatusID'] = approvalStatusID;
    return data;
  }
}
class AttachmentData {
  String? fileName;

  AttachmentData({this.fileName});

  AttachmentData.fromJson(Map<String, dynamic> json) {
    fileName = json['FileName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['FileName'] = fileName;
    return data;
  }
}