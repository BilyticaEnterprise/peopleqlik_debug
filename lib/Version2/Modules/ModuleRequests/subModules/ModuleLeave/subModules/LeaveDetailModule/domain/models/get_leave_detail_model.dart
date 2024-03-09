import 'package:peopleqlik_debug/Version1/Models/ApprovalsModel/get_approvals_detail_model.dart';

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
  List<ObjNotificationStatus>? lObjNotificationStatus;

  LeaveDetailResultSet({this.lObjLeaveApplication, this.lObjApprovalHistory, this.lObjNotificationStatus});

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
    if (json['_objNotificationStatus'] != null) {
      lObjNotificationStatus = <ObjNotificationStatus>[];
      json['_objNotificationStatus'].forEach((v) {
        lObjNotificationStatus!.add(new ObjNotificationStatus.fromJson(v));
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
    if (this.lObjNotificationStatus != null) {
      data['_objNotificationStatus'] =
          this.lObjNotificationStatus!.map((v) => v.toJson()).toList();
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
  IaEmployeeMf? iaEmployeeMf;
  dynamic iaEmployeeMf1;
  //List<Null>? laLeaveApplicationDocument;
  dynamic laLeaveReason;
  LaLeaveTypeMf? laLeaveTypeMf;
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
    iaEmployeeMf = json['ia_employee_mf'] != null
        ? new IaEmployeeMf.fromJson(json['ia_employee_mf'])
        : null;
    iaEmployeeMf1 = json['ia_employee_mf1'];
    // if (json['la_leave_application_document'] != null) {
    //   laLeaveApplicationDocument = <Null>[];
    //   json['la_leave_application_document'].forEach((v) {
    //     laLeaveApplicationDocument!.add(new Null.fromJson(v));
    //   });
    // }
    laLeaveReason = json['la_leave_reason'];
    laLeaveTypeMf = json['la_leave_type_mf'] != null
        ? new LaLeaveTypeMf.fromJson(json['la_leave_type_mf'])
        : null;
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
    if (this.iaEmployeeMf != null) {
      data['ia_employee_mf'] = this.iaEmployeeMf!.toJson();
    }
    data['ia_employee_mf1'] = this.iaEmployeeMf1;
    // if (this.laLeaveApplicationDocument != null) {
    //   data['la_leave_application_document'] =
    //       this.laLeaveApplicationDocument!.map((v) => v.toJson()).toList();
    // }
    data['la_leave_reason'] = this.laLeaveReason;
    if (this.laLeaveTypeMf != null) {
      data['la_leave_type_mf'] = this.laLeaveTypeMf!.toJson();
    }
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


class IaEmployeeMf {
  dynamic iD;
  dynamic employeeCode;
  dynamic companyCode;
  dynamic cultureID;
  dynamic codeParameterID;
  dynamic titleID;
  String? firstName;
  String? middleName;
  String? lastName;
  String? fullName;
  String? dOB;
  String? dateOfJoining;
  String? emailID;
  String? privateEmail;
  String? mobileNo;
  String? landLine;
  int? typeID;
  dynamic startDate;
  dynamic endDate;
  String? picture;
  String? identificationNo;
  int? genderID;
  int? statusID;
  String? departmentCode;
  String? subDepartmentCode;
  String? jobCode;
  String? effectiveDate;
  String? oldGradeCode;
  bool? autoRenewal;
  double? noticePeriod;
  bool? isGuest;
  bool? active;


  IaEmployeeMf(
      {this.iD,
        this.employeeCode,
        this.companyCode,
        this.cultureID,
        this.codeParameterID,
        this.titleID,
        this.firstName,
        this.middleName,
        this.lastName,
        this.fullName,
        this.dOB,
        this.dateOfJoining,
        this.emailID,
        this.privateEmail,
        this.mobileNo,
        this.landLine,
        this.typeID,
        this.startDate,
        this.endDate,
        this.picture,
        this.identificationNo,
        this.genderID,
        this.statusID,
        this.departmentCode,
        this.subDepartmentCode,
        this.jobCode,
        this.effectiveDate,
        this.oldGradeCode,
        this.autoRenewal,
        this.noticePeriod,
        this.isGuest,
        this.active,
        });

  IaEmployeeMf.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    employeeCode = json['EmployeeCode'];
    companyCode = json['CompanyCode'];
    cultureID = json['CultureID'];
    codeParameterID = json['CodeParameterID'];
    titleID = json['TitleID'];
    firstName = json['FirstName'];
    middleName = json['MiddleName'];
    lastName = json['LastName'];
    fullName = json['FullName'];
    dOB = json['DOB'];
    dateOfJoining = json['DateOfJoining'];
    emailID = json['EmailID'];
    privateEmail = json['PrivateEmail'];
    mobileNo = json['MobileNo'];
    landLine = json['LandLine'];
    typeID = json['TypeID'];
    startDate = json['StartDate'];
    endDate = json['EndDate'];
    picture = json['Picture'];
    identificationNo = json['IdentificationNo'];
    genderID = json['GenderID'];
    statusID = json['StatusID'];
    departmentCode = json['DepartmentCode'];
    subDepartmentCode = json['SubDepartmentCode'];
    jobCode = json['JobCode'];
    effectiveDate = json['EffectiveDate'];
    oldGradeCode = json['OldGradeCode'];
    autoRenewal = json['AutoRenewal'];
    noticePeriod = json['NoticePeriod'];
    isGuest = json['IsGuest'];
    active = json['Active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['EmployeeCode'] = this.employeeCode;
    data['CompanyCode'] = this.companyCode;
    data['CultureID'] = this.cultureID;
    data['CodeParameterID'] = this.codeParameterID;
    data['TitleID'] = this.titleID;
    data['FirstName'] = this.firstName;
    data['MiddleName'] = this.middleName;
    data['LastName'] = this.lastName;
    data['FullName'] = this.fullName;
    data['DOB'] = this.dOB;
    data['DateOfJoining'] = this.dateOfJoining;

    data['EmailID'] = this.emailID;
    data['PrivateEmail'] = this.privateEmail;
    data['MobileNo'] = this.mobileNo;
    data['LandLine'] = this.landLine;
    data['TypeID'] = this.typeID;
    data['StartDate'] = this.startDate;
    data['EndDate'] = this.endDate;
    data['Picture'] = this.picture;
    data['IdentificationNo'] = this.identificationNo;
    data['GenderID'] = this.genderID;
    data['StatusID'] = this.statusID;
    data['DepartmentCode'] = this.departmentCode;
    data['SubDepartmentCode'] = this.subDepartmentCode;
    data['JobCode'] = this.jobCode;
    data['EffectiveDate'] = this.effectiveDate;
    data['OldGradeCode'] = this.oldGradeCode;
    data['AutoRenewal'] = this.autoRenewal;
    data['NoticePeriod'] = this.noticePeriod;
    data['IsGuest'] = this.isGuest;
    data['Active'] = this.active;

    return data;
  }
}


class LaLeaveTypeMf {
  String? typeTitle;
  int? unitID;


  LaLeaveTypeMf(
      {
        this.typeTitle,
        this.unitID,

      });

  LaLeaveTypeMf.fromJson(Map<String, dynamic> json) {
    typeTitle = json['TypeTitle'];
    unitID = json['UnitID'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TypeTitle'] = this.typeTitle;
    data['UnitID'] = this.unitID;

    return data;
  }
}

class ObjNotificationStatus {
  int? statusID;
  String? statusName;

  ObjNotificationStatus({this.statusID, this.statusName});

  ObjNotificationStatus.fromJson(Map<String, dynamic> json) {
    statusID = json['StatusID'];
    statusName = json['StatusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusID'] = this.statusID;
    data['StatusName'] = this.statusName;
    return data;
  }
}