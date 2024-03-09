class TimeOffJson {
  bool? isSuccess;
  LeavesResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  TimeOffJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  TimeOffJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new LeavesResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet?.toJson();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class LeavesResultSet {
  int? totalRecord;
  List<LeavesDataList>? dataList;

  LeavesResultSet({this.totalRecord, this.dataList});

  LeavesResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = new List<LeavesDataList>.empty(growable: true);
      json['DataList'].forEach((v) {
        dataList?.add(new LeavesDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalRecord'] = this.totalRecord;
    if (this.dataList != null) {
      data['DataList'] = this.dataList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeavesDataList {
  int? cultureID;
  dynamic applicationCode;
  String? requestDate;
  int? iD;
  bool? dependentTraveling;
  bool? advancedSalary;
  String? displayName;
  String? employeeName;
  dynamic companyCode;
  dynamic employeeCode;
  String? typeTitle;
  int? approvalStatusID;
  int? unitID;
  String? unitName;
  List<TimeoffDetail>? timeoffDetail;
  String? statusName;
  String? modifiedDate;
  String? eCIName;
  String? eCINumber;
  String? remarks;
  String? documentNo;
  int? screenID;

  LeavesDataList(
      {this.cultureID,
        this.applicationCode,
        this.requestDate,
        this.iD,
        this.dependentTraveling,
        this.advancedSalary,
        this.displayName,
        this.employeeName,
        this.companyCode,
        this.remarks,
        this.employeeCode,
        this.typeTitle,
        this.eCIName,
        this.eCINumber,
        this.approvalStatusID,
        this.unitID,
        this.unitName,
        this.timeoffDetail,
        this.statusName,
        this.modifiedDate,
        this.documentNo,
        this.screenID
      });

  LeavesDataList.fromJson(Map<String, dynamic> json) {
    cultureID = json['CultureID'];
    applicationCode = json['ApplicationCode'];
    requestDate = json['RequestDate'];
    iD = json['ID'];
    dependentTraveling = json['DependentTraveling'];
    advancedSalary = json['AdvancedSalary'];
    displayName = json['DisplayName'];
    employeeName = json['EmployeeName'];
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    typeTitle = json['TypeTitle'];
    approvalStatusID = json['ApprovalStatusID'];
    unitID = json['UnitID'];
    remarks = json['Remarks'];
    eCINumber = json['ECINumber'];
    eCIName = json['ECIName'];
    unitName = json['UnitName'];
    if (json['Timeoff_detail'] != null) {
      timeoffDetail = List<TimeoffDetail>.empty(growable: true);
      json['Timeoff_detail'].forEach((v) {
        timeoffDetail?.add(TimeoffDetail.fromJson(v));
      });
    }
    statusName = json['StatusName'];
    modifiedDate = json['ModifiedDate'];
    documentNo = json['DocumentNo'];
    screenID = json['ScreenID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CultureID'] = this.cultureID;
    data['ApplicationCode'] = this.applicationCode;
    data['RequestDate'] = this.requestDate;
    data['ID'] = this.iD;
    data['DependentTraveling'] = this.dependentTraveling;
    data['AdvancedSalary'] = this.advancedSalary;
    data['DisplayName'] = this.displayName;
    data['EmployeeName'] = this.employeeName;
    data['CompanyCode'] = this.companyCode;
    data['ECIName'] = eCIName;
    data['Remarks'] = remarks;
    data['EmployeeCode'] = this.employeeCode;
    data['TypeTitle'] = this.typeTitle;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['UnitID'] = this.unitID;
    data['ECINumber'] = eCINumber;
    data['UnitName'] = this.unitName;
    if (this.timeoffDetail != null) {
      data['Timeoff_detail'] =
          this.timeoffDetail?.map((v) => v.toJson()).toList();
    }
    data['StatusName'] = this.statusName;
    data['ModifiedDate'] = this.modifiedDate;
    data['DocumentNo'] = documentNo;
    data['ScreenID'] = screenID;
    return data;
  }
}

class TimeoffDetail {
  int? iD;
  String? applicationCode;
  int? cultureID;
  dynamic companyCode;
  dynamic employeeCode;
  String? leaveFrom;
  String? leaveTo;
  bool? fullDayLeave;
  int? halfLeaveTypeDropDownID;
  int? halfLeaveTypeID;
  double? totalLeaves;
  // Null laLeaveApplicationMf;
  // Null sysDropDownValue;
  int? trackingState;
 // Null modifiedProperties;

  TimeoffDetail(
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
        // this.laLeaveApplicationMf,
        // this.sysDropDownValue,
        this.trackingState,
      //  this.modifiedProperties
      });

  TimeoffDetail.fromJson(Map<String, dynamic> json) {
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
    // laLeaveApplicationMf = json['la_leave_application_mf'];
    // sysDropDownValue = json['sys_drop_down_value'];
    trackingState = json['TrackingState'];
    //modifiedProperties = json['ModifiedProperties'];
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
    // data['la_leave_application_mf'] = this.laLeaveApplicationMf;
    // data['sys_drop_down_value'] = this.sysDropDownValue;
    data['TrackingState'] = this.trackingState;
    //data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}