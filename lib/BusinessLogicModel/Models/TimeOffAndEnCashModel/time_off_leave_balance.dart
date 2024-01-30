class GetLeaveBalanceJson {
  bool? isSuccess;
  ResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetLeaveBalanceJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetLeaveBalanceJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new ResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsSuccess'] = isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    data['FilePath'] = filePath;
    data['Message'] = message;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}
class ResultSet {
  List<GetLeaveBalanceResultSet>? leaveTypes;
  List<LeaveReasons>? leaveReasons;

  ResultSet({this.leaveTypes, this.leaveReasons});

  ResultSet.fromJson(Map<String, dynamic> json) {
    if (json['LeaveTypes'] != null) {
      leaveTypes = <GetLeaveBalanceResultSet>[];
      json['LeaveTypes'].forEach((v) {
        leaveTypes!.add(new GetLeaveBalanceResultSet.fromJson(v));
      });
    }
    if (json['LeaveReasons'] != null) {
      leaveReasons = <LeaveReasons>[];
      json['LeaveReasons'].forEach((v) {
        leaveReasons!.add(new LeaveReasons.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.leaveTypes != null) {
      data['LeaveTypes'] = this.leaveTypes!.map((v) => v.toJson()).toList();
    }
    if (this.leaveReasons != null) {
      data['LeaveReasons'] = this.leaveReasons!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class GetLeaveBalanceResultSet {
  String? calendarCode;
  double? netBalance;
  double? entitleUnit;
  double? availmentUnit;
  double? totalLeaveAvailInService;
  int? unitID;
  String? unitName;
  bool? autoUnpaid;
  bool? autoLeaveBalanceDeduction;
  bool? includeWeedend;
  bool? allowNegativeBalance;
  double? maxAllowedBalanceInDay;
  bool? supportDocRequired;
  dynamic noOfSupportDocRequired;
  int? documentNoRequired;
  dynamic minLeave;
  dynamic noOfTimeInYear;
  dynamic noOfTimeInService;
  double? minimumUnitValue;
  double? maximumUnitValue;
  bool? carryOver;
  bool? changeSupervisor;
  bool? deductWorkingWeekend;
  bool? canApplyForNextYear;
  bool? leaveReturnApprovalRequired;
  bool? exitReEntryVisa;
  bool? airTicket;
  bool? leaveSalaryRequired;
  bool? leaveReasonRequired;
  bool? alternateContactForLeave;
  String? createdDate;

  GetLeaveBalanceResultSet(
      {this.calendarCode,
        this.netBalance,
        this.unitID,
        this.unitName,
        this.autoUnpaid,
        this.autoLeaveBalanceDeduction,
        this.includeWeedend,
        this.allowNegativeBalance,
        this.maxAllowedBalanceInDay,
        this.supportDocRequired,
        this.noOfSupportDocRequired,
        this.documentNoRequired,
        this.minLeave,
        this.noOfTimeInYear,
        this.noOfTimeInService,
        this.minimumUnitValue,
        this.maximumUnitValue,
        this.carryOver,
        this.changeSupervisor,
        this.canApplyForNextYear,
        this.leaveReturnApprovalRequired,
        this.exitReEntryVisa,
        this.airTicket,
        this.leaveSalaryRequired,
        this.leaveReasonRequired,
        this.alternateContactForLeave,
        this.createdDate});

  GetLeaveBalanceResultSet.fromJson(Map<String, dynamic> json) {
    print('codeeee');
    calendarCode = json['CalendarCode'];
    print('1codeeee');
    netBalance = json['NetBalance'];
    print('2codeeee');
    unitID = json['UnitID'];
    print('3codeeee');
    entitleUnit = json['EntittleUnit'];
    print('codeeee');
    availmentUnit = json['AvailmentUnit'];
    print('codeeee');
    totalLeaveAvailInService = json['TotalLeaveAvailInService'];
    deductWorkingWeekend = json['DeductWorkingWeekend'];
    print('codeeee');
    unitName = json['UnitName'];
    print('1codeeee');
    autoUnpaid = json['AutoUnpaid'];
    print('codeeee');
    autoLeaveBalanceDeduction = json['AutoLeaveBalanceDeduction'];
    print('codeeee');
    includeWeedend = json['IncludeWeedend'];
    print('codeeee');
    allowNegativeBalance = json['AllowNegativeBalance'];
    print('codeeee');
    maxAllowedBalanceInDay = json['MaxAllowedBalanceInDay'];
    print('codeeee');
    supportDocRequired = json['SupportDocRequired'];
    print('codeeee');
    noOfSupportDocRequired = json['NoOfSupportDocRequired'];
    print('codeeee');
    documentNoRequired = json['DocumentNoRequired'];
    print('codeeee');
    minLeave = json['MinLeave'];
    print('codeeee');
    noOfTimeInYear = json['NoOfTimeInYear'];
    print('codeeee');
    noOfTimeInService = json['NoOfTimeInService'];
    print('codeeee');
    minimumUnitValue = json['MinimumUnitValue'];
    print('codeeee');
    maximumUnitValue = json['MaximumUnitValue'];
    print('codeeee');
    carryOver = json['CarryOver'];
    print('codeeee');
    changeSupervisor = json['ChangeSupervisor'];
    print('codeeee');
    canApplyForNextYear = json['CanApplyForNextYear'];
    print('codeeee');
    leaveReturnApprovalRequired = json['LeaveReturnApprovalRequired'];
    print('codeeee');
    exitReEntryVisa = json['ExitReEntryVisa'];
    print('codeeee');
    airTicket = json['AirTicket'];
    print('codeeee');
    leaveSalaryRequired = json['LeaveSalaryRequired'];
    print('codeeee');
    leaveReasonRequired = json['LeaveReasonRequired'];
    print('codeeee');
    alternateContactForLeave = json['AlternateContactForLeave'];
    print('codeeee');
    createdDate = json['CreatedDate'];
    print('432codeeee');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CalendarCode'] = calendarCode;
    data['NetBalance'] = netBalance;
    data['UnitID'] = unitID;
    data['AvailmentUnit'] = availmentUnit;
    data['EntittleUnit'] = entitleUnit;
    data['DeductWorkingWeekend'] = deductWorkingWeekend;
    data['TotalLeaveAvailInService'] = totalLeaveAvailInService;
    data['UnitName'] = unitName;
    data['AutoUnpaid'] = autoUnpaid;
    data['AutoLeaveBalanceDeduction'] = autoLeaveBalanceDeduction;
    data['IncludeWeedend'] = includeWeedend;
    data['AllowNegativeBalance'] = allowNegativeBalance;
    data['MaxAllowedBalanceInDay'] = maxAllowedBalanceInDay;
    data['SupportDocRequired'] = supportDocRequired;
    data['NoOfSupportDocRequired'] = noOfSupportDocRequired;
    data['DocumentNoRequired'] = documentNoRequired;
    data['MinLeave'] = minLeave;
    data['NoOfTimeInYear'] = noOfTimeInYear;
    data['NoOfTimeInService'] = noOfTimeInService;
    data['MinimumUnitValue'] = minimumUnitValue;
    data['MaximumUnitValue'] = maximumUnitValue;
    data['CarryOver'] = carryOver;
    data['ChangeSupervisor'] = changeSupervisor;
    data['CanApplyForNextYear'] = canApplyForNextYear;
    data['LeaveReturnApprovalRequired'] = leaveReturnApprovalRequired;
    data['ExitReEntryVisa'] = exitReEntryVisa;
    data['AirTicket'] = airTicket;
    data['LeaveSalaryRequired'] = leaveSalaryRequired;
    data['LeaveReasonRequired'] = leaveReasonRequired;
    data['AlternateContactForLeave'] = alternateContactForLeave;
    data['CreatedDate'] = createdDate;
    return data;
  }
}
class LeaveReasons {
  int? iD;
  String? typeCode;
  int? reasonID;
  int? cultureID;
  String? reasonTitle;
  String? reasonDesc;
  bool? active;
  String? effectiveDate;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  String? iconName;
  dynamic maxLeaveLimit;
  int? companyCode;
  dynamic laLeaveApplicationMf;
  dynamic laLeaveTypeMf;
  int? trackingState;
  dynamic modifiedProperties;

  LeaveReasons(
      {this.iD,
        this.typeCode,
        this.reasonID,
        this.cultureID,
        this.reasonTitle,
        this.reasonDesc,
        this.active,
        this.effectiveDate,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.iconName,
        this.maxLeaveLimit,
        this.companyCode,
        this.laLeaveApplicationMf,
        this.laLeaveTypeMf,
        this.trackingState,
        this.modifiedProperties});

  LeaveReasons.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    typeCode = json['TypeCode'];
    reasonID = json['ReasonID'];
    cultureID = json['CultureID'];
    reasonTitle = json['ReasonTitle'];
    reasonDesc = json['ReasonDesc'];
    active = json['Active'];
    effectiveDate = json['EffectiveDate'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedBy = json['ModifiedBy'];
    modifiedDate = json['ModifiedDate'];
    iconName = json['IconName'];
    maxLeaveLimit = json['MaxLeaveLimit'];
    companyCode = json['CompanyCode'];
    // if (json['la_leave_application_mf'] != null) {
    //   laLeaveApplicationMf = <Null>[];
    //   json['la_leave_application_mf'].forEach((v) {
    //     laLeaveApplicationMf!.add(new Null.fromJson(v));
    //   });
    // }
    laLeaveTypeMf = json['la_leave_type_mf'];
    trackingState = json['TrackingState'];
    modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TypeCode'] = this.typeCode;
    data['ReasonID'] = this.reasonID;
    data['CultureID'] = this.cultureID;
    data['ReasonTitle'] = this.reasonTitle;
    data['ReasonDesc'] = this.reasonDesc;
    data['Active'] = this.active;
    data['EffectiveDate'] = this.effectiveDate;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedDate'] = this.modifiedDate;
    data['IconName'] = this.iconName;
    data['MaxLeaveLimit'] = this.maxLeaveLimit;
    data['CompanyCode'] = this.companyCode;
    // if (this.laLeaveApplicationMf != null) {
    //   data['la_leave_application_mf'] =
    //       this.laLeaveApplicationMf!.map((v) => v.toJson()).toList();
    // }
    data['la_leave_type_mf'] = this.laLeaveTypeMf;
    data['TrackingState'] = this.trackingState;
    data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}