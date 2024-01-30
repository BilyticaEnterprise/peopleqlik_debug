import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';

class GetLeaveDetailsJson {
  bool? isSuccess;
  LeaveDetailResultSet? resultSet;
  String? message;
  String? errorMessage;

  GetLeaveDetailsJson(
      {this.isSuccess,
        this.resultSet,
        this.message,
        this.errorMessage
      });

  GetLeaveDetailsJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new LeaveDetailResultSet.fromJson(json['ResultSet'])
        : null;
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class LeaveDetailResultSet {
  List<ObjLeaveApplication>? lObjLeaveApplication;
  List<ApprovalHistory>? lObjApprovalHistory;

  LeaveDetailResultSet({this.lObjLeaveApplication, this.lObjApprovalHistory});

  LeaveDetailResultSet.fromJson(Map<String, dynamic> json) {
    if (json['_objLeaveApplication'] != null) {
      lObjLeaveApplication = <ObjLeaveApplication>[];
      json['_objLeaveApplication'].forEach((v) {
        lObjLeaveApplication!.add(new ObjLeaveApplication.fromJson(v));
      });
    }
    if (json['_objApprovalHistory'] != null) {
      lObjApprovalHistory = <ApprovalHistory>[];
      json['_objApprovalHistory'].forEach((v) {
        lObjApprovalHistory!.add(new ApprovalHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lObjLeaveApplication != null) {
      data['_objLeaveApplication'] =
          this.lObjLeaveApplication!.map((v) => v.toJson()).toList();
    }
    if (this.lObjApprovalHistory != null) {
      data['_objApprovalHistory'] =
          this.lObjApprovalHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ObjLeaveApplication {
  int? iD;
  String? applicationCode;
  int? cultureID;
  dynamic companyCode;
  dynamic employeeCode;
  String? requestDate;
  String? leaveTypeCode;
  dynamic reasonID;
  dynamic coveringEmployeeCode;
  dynamic workFlowSubstituteUserID;
  String? remarks;
  bool? exitReEntry;
  bool? airTicket;
  bool? dependentTraveling;
  bool? advancedSalary;
  dynamic eCINumber;
  dynamic eCIName;
  int? departureFrom;
  int? departureDestination;
  double? unPaidLeave;
  dynamic returningToWorkDate;
  dynamic rTWorkRemarks;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  int? approvalStatusID;
  dynamic cancelLeaveDate;
  dynamic cancelLeaveRemarks;
  dynamic admUser;
  dynamic iaEmployeeMf;
  dynamic iaEmployeeMf1;
  //List<Null>? laLeaveApplicationDocument;
  dynamic laLeaveReason;
  dynamic laLeaveTypeMf;
  List<LaLeaveApplicationTimeoff>? laLeaveApplicationTimeoff;
  int? trackingState;
  dynamic modifiedProperties;

  ObjLeaveApplication(
      {this.iD,
        this.applicationCode,
        this.cultureID,
        this.companyCode,
        this.employeeCode,
        this.requestDate,
        this.leaveTypeCode,
        this.reasonID,
        this.coveringEmployeeCode,
        this.workFlowSubstituteUserID,
        this.remarks,
        this.exitReEntry,
        this.airTicket,
        this.dependentTraveling,
        this.advancedSalary,
        this.eCINumber,
        this.eCIName,
        this.departureFrom,
        this.departureDestination,
        this.unPaidLeave,
        this.returningToWorkDate,
        this.rTWorkRemarks,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.approvalStatusID,
        this.cancelLeaveDate,
        this.cancelLeaveRemarks,
        this.admUser,
        this.iaEmployeeMf,
        this.iaEmployeeMf1,
     //   this.laLeaveApplicationDocument,
        this.laLeaveReason,
        this.laLeaveTypeMf,
        this.laLeaveApplicationTimeoff,
        this.trackingState,
        this.modifiedProperties});

  ObjLeaveApplication.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    applicationCode = json['ApplicationCode'];
    cultureID = json['CultureID'];
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    requestDate = json['RequestDate'];
    leaveTypeCode = json['LeaveTypeCode'];
    reasonID = json['ReasonID'];
    coveringEmployeeCode = json['CoveringEmployeeCode'];
    workFlowSubstituteUserID = json['WorkFlowSubstituteUserID'];
    remarks = json['Remarks'];
    exitReEntry = json['ExitReEntry'];
    airTicket = json['AirTicket'];
    dependentTraveling = json['DependentTraveling'];
    advancedSalary = json['AdvancedSalary'];
    eCINumber = json['ECINumber'];
    eCIName = json['ECIName'];
    departureFrom = json['DepartureFrom'];
    departureDestination = json['DepartureDestination'];
    unPaidLeave = json['UnPaidLeave'];
    returningToWorkDate = json['ReturningToWorkDate'];
    rTWorkRemarks = json['RTWorkRemarks'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedBy = json['ModifiedBy'];
    modifiedDate = json['ModifiedDate'];
    approvalStatusID = json['ApprovalStatusID'];
    cancelLeaveDate = json['CancelLeaveDate'];
    cancelLeaveRemarks = json['CancelLeaveRemarks'];
    admUser = json['adm_user'];
    iaEmployeeMf = json['ia_employee_mf'];
    iaEmployeeMf1 = json['ia_employee_mf1'];
    // if (json['la_leave_application_document'] != null) {
    //   laLeaveApplicationDocument = <Null>[];
    //   json['la_leave_application_document'].forEach((v) {
    //     laLeaveApplicationDocument!.add(new Null.fromJson(v));
    //   });
    // }
    laLeaveReason = json['la_leave_reason'];
    laLeaveTypeMf = json['la_leave_type_mf'];
    if (json['la_leave_application_timeoff'] != null) {
      laLeaveApplicationTimeoff = <LaLeaveApplicationTimeoff>[];
      json['la_leave_application_timeoff'].forEach((v) {
        laLeaveApplicationTimeoff!
            .add(new LaLeaveApplicationTimeoff.fromJson(v));
      });
    }
    trackingState = json['TrackingState'];
    modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ApplicationCode'] = this.applicationCode;
    data['CultureID'] = this.cultureID;
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    data['RequestDate'] = this.requestDate;
    data['LeaveTypeCode'] = this.leaveTypeCode;
    data['ReasonID'] = this.reasonID;
    data['CoveringEmployeeCode'] = this.coveringEmployeeCode;
    data['WorkFlowSubstituteUserID'] = this.workFlowSubstituteUserID;
    data['Remarks'] = this.remarks;
    data['ExitReEntry'] = this.exitReEntry;
    data['AirTicket'] = this.airTicket;
    data['DependentTraveling'] = this.dependentTraveling;
    data['AdvancedSalary'] = this.advancedSalary;
    data['ECINumber'] = this.eCINumber;
    data['ECIName'] = this.eCIName;
    data['DepartureFrom'] = this.departureFrom;
    data['DepartureDestination'] = this.departureDestination;
    data['UnPaidLeave'] = this.unPaidLeave;
    data['ReturningToWorkDate'] = this.returningToWorkDate;
    data['RTWorkRemarks'] = this.rTWorkRemarks;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedDate'] = this.modifiedDate;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['CancelLeaveDate'] = this.cancelLeaveDate;
    data['CancelLeaveRemarks'] = this.cancelLeaveRemarks;
    data['adm_user'] = this.admUser;
    data['ia_employee_mf'] = this.iaEmployeeMf;
    data['ia_employee_mf1'] = this.iaEmployeeMf1;
    // if (this.laLeaveApplicationDocument != null) {
    //   data['la_leave_application_document'] =
    //       this.laLeaveApplicationDocument!.map((v) => v.toJson()).toList();
    // }
    data['la_leave_reason'] = this.laLeaveReason;
    data['la_leave_type_mf'] = this.laLeaveTypeMf;
    if (this.laLeaveApplicationTimeoff != null) {
      data['la_leave_application_timeoff'] =
          this.laLeaveApplicationTimeoff!.map((v) => v.toJson()).toList();
    }
    data['TrackingState'] = this.trackingState;
    data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}

class LaLeaveApplicationTimeoff {
  int? iD;
  String? applicationCode;
  int? cultureID;
  dynamic companyCode;
  dynamic employeeCode;
  String? leaveFrom;
  String? leaveTo;
  bool? fullDayLeave;
  int? halfLeaveTypeDropDownID;
  dynamic halfLeaveTypeID;
  double? totalLeaves;
  dynamic sysDropDownValue;
  int? trackingState;
  dynamic modifiedProperties;

  LaLeaveApplicationTimeoff(
      {this.iD,
        this.applicationCode,
        this.cultureID,
        this.companyCode,
        this.employeeCode,
        this.leaveFrom,
        this.leaveTo,
        this.fullDayLeave,
        this.halfLeaveTypeDropDownID,
        this.halfLeaveTypeID,
        this.totalLeaves,
        this.sysDropDownValue,
        this.trackingState,
        this.modifiedProperties});

  LaLeaveApplicationTimeoff.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    applicationCode = json['ApplicationCode'];
    cultureID = json['CultureID'];
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    leaveFrom = json['LeaveFrom'];
    leaveTo = json['LeaveTo'];
    fullDayLeave = json['FullDayLeave'];
    halfLeaveTypeDropDownID = json['HalfLeaveTypeDropDownID'];
    halfLeaveTypeID = json['HalfLeaveTypeID'];
    totalLeaves = json['TotalLeaves'];
    sysDropDownValue = json['sys_drop_down_value'];
    trackingState = json['TrackingState'];
    modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ApplicationCode'] = this.applicationCode;
    data['CultureID'] = this.cultureID;
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    data['LeaveFrom'] = this.leaveFrom;
    data['LeaveTo'] = this.leaveTo;
    data['FullDayLeave'] = this.fullDayLeave;
    data['HalfLeaveTypeDropDownID'] = this.halfLeaveTypeDropDownID;
    data['HalfLeaveTypeID'] = this.halfLeaveTypeID;
    data['TotalLeaves'] = this.totalLeaves;
    data['sys_drop_down_value'] = this.sysDropDownValue;
    data['TrackingState'] = this.trackingState;
    data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}