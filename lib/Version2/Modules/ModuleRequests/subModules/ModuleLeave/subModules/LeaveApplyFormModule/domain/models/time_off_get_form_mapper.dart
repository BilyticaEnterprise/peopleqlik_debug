class LeaveCreateFormJson {
  bool? isSuccess;
  LeaveCreateFormResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  LeaveCreateFormJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  LeaveCreateFormJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new LeaveCreateFormResultSet.fromJson(json['ResultSet'])
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

class LeaveCreateFormResultSet {
  int? applicationCode;
  List<LeaveType>? leaveType;
  // List<LeaveReson>? leaveReson;
  List<ShiftInfo>? shiftInfo;
  CompanySetting? companySetting;
  List<HalfLeaveDropdown>? halfLeaveDropdown;
  LeaveCalander? leaveCalander;

  LeaveCreateFormResultSet(
      {this.applicationCode,
        this.leaveType,
        // this.leaveReson,
        this.leaveCalander});

  LeaveCreateFormResultSet.fromJson(Map<String, dynamic> json) {
    applicationCode = json['ApplicationCode'];
    if (json['LeaveType'] != null) {
      leaveType = new List<LeaveType>.empty(growable: true);
      json['LeaveType'].forEach((v) {
        leaveType?.add(new LeaveType.fromJson(v));
      });
    }

    if (json['ShiftInfo'] != null) {
      shiftInfo = <ShiftInfo>[];
      json['ShiftInfo'].forEach((v) {
        shiftInfo!.add(new ShiftInfo.fromJson(v));
      });
    }
    // if (json['LeaveReson'] != null) {
    //   leaveReson = new List<LeaveReson>.empty(growable: true);
    //   json['LeaveReson'].forEach((v) {
    //     leaveReson?.add(new LeaveReson.fromJson(v));
    //   });
    // }
    if (json['HalfLeaveDropdown'] != null) {
      halfLeaveDropdown = new List<HalfLeaveDropdown>.empty(growable: true);
      json['HalfLeaveDropdown'].forEach((v) {
        halfLeaveDropdown?.add(new HalfLeaveDropdown.fromJson(v));
      });
    }
    leaveCalander = json['LeaveCalander'] != null
        ? new LeaveCalander.fromJson(json['LeaveCalander'])
        : null;
    companySetting = json['CompanySetting'] != null
        ? new CompanySetting.fromJson(json['CompanySetting'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ApplicationCode'] = this.applicationCode;
    if (this.leaveType != null) {
      data['LeaveType'] = this.leaveType?.map((v) => v.toJson()).toList();
    }
    // if (this.leaveReson != null) {
    //   data['LeaveReson'] = this.leaveReson?.map((v) => v.toJson()).toList();
    // }
    if (this.companySetting != null) {
      data['CompanySetting'] = this.companySetting!.toJson();
    }
    if (this.leaveCalander != null) {
      data['LeaveCalander'] = this.leaveCalander?.toJson();
    }
    if (this.shiftInfo != null) {
      data['ShiftInfo'] = this.shiftInfo!.map((v) => v.toJson()).toList();
    }
    if (this.halfLeaveDropdown != null) {
      data['HalfLeaveDropdown'] =
          this.halfLeaveDropdown?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveType {
  int? iD;
  String? typeCode;
  int? cultureID;
  String? typeTitle;
  String? typeDesc;
  int? unitID;
  bool? includeWeedend;
  int? holidayPayTypeID;
  int? methodID;
  double? methodValue;
  bool? accrual;
  int? accrualFrequencyID;
  int? accrualCreditID;
  bool? carryOver;
  // Null maxCarryOverUnit;
  bool? encashment;
  double? encashmentUnit;
  bool? airTicket;
  // Null airTicketControlledInDay;
  bool? exitReEntryVisa;
  // Null exitReEntryVisaControlledInDay;
  bool? genderSpecific;
  // Null genderID;
  bool? maritalStatus;
  // Null maritalStatusID;
  bool? allowNegativeBalance;
  // Null maxAllowedBalanceInDay;
  bool? supportDocRequired;
  int? noOfSupportDocRequired;
  bool? leaveAlterGracePeriod;
  // //Null leaveAlterGracePeriodInDay;
  double? minimumService;
  int? minimumServiceFrequencyID;
  // Null noOfTimeInYear;
  // Null noOfTimeInService;
  double? minimumUnitValue;
  double? maximumUnitValue;
  bool? leaveReturnApprovalRequired;
  bool? alternateContactForLeave;
  double? maximumBalanceUnit;
  bool? balanceAdjustable;
  bool? enableSelfService;
  //Null leaveBalanceAdjTypeID;
  bool? leaveReasonRequired;
  bool? leaveSalaryRequired;
  String? effectiveDate;
  bool? active;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  String? iconName;
  bool? autoLeaveBalanceDeduction;
  int? minLeave;
  bool? changeSupervisor;
  bool? autoUnpaid;
  int? leaveTypeOrder;
  bool? emergencyContact;
  bool? timeSheetDeduction;
  // Null payTypeDropDownID;
  // Null payTypeDropDownValueID;
  bool? onlyApplyForFullDay;
  bool? canApplyForNextYear;
  bool? deductWorkingWeekend;
  String? canAvailOn;
  // List<Null> iaGradeLeave;
  // List<Null> laLeaveAdjustment;
  // List<Null> laLeaveApplicationMf;
  // List<Null> laLeaveBalance;
  // List<Null> laLeaveBalanceHistory;
  // List<Null> laLeaveCalendarDt;
  // List<Null> laLeaveCarryOver;
  // List<Null> laLeaveEncashment;
  // List<Null> laLeaveEncashmentRequest;
  // List<Null> laLeaveEntitlement;
  // List<Null> laLeaveReason;
  // List<Null> laLeaveTypeDt;
  // List<Null> laLeaveTypeMappingDt;
  int? trackingState;
  //Null modifiedProperties;

  LeaveType(
      {this.iD,
        this.typeCode,
        this.cultureID,
        this.typeTitle,
        this.typeDesc,
        this.unitID,
        this.includeWeedend,
        this.holidayPayTypeID,
        this.methodID,
        //this.methodValue,
        this.accrual,
        this.accrualFrequencyID,
        this.accrualCreditID,
        this.carryOver,
       // this.maxCarryOverUnit,
        this.encashment,
        this.encashmentUnit,
        this.airTicket,
       // this.airTicketControlledInDay,
        this.exitReEntryVisa,
       // this.exitReEntryVisaControlledInDay,
        this.genderSpecific,
       // this.genderID,
        this.maritalStatus,
        //this.maritalStatusID,
        this.allowNegativeBalance,
       // this.maxAllowedBalanceInDay,
        this.supportDocRequired,
        this.noOfSupportDocRequired,
        this.leaveAlterGracePeriod,
      //  this.leaveAlterGracePeriodInDay,
        this.minimumService,
        this.minimumServiceFrequencyID,
        // this.noOfTimeInYear,
        // this.noOfTimeInService,
        this.minimumUnitValue,
        this.maximumUnitValue,
        this.leaveReturnApprovalRequired,
        this.alternateContactForLeave,
        this.maximumBalanceUnit,
        this.balanceAdjustable,
        this.enableSelfService,
      //  this.leaveBalanceAdjTypeID,
        this.leaveReasonRequired,
        this.leaveSalaryRequired,
        this.effectiveDate,
        this.active,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.iconName,
        this.autoLeaveBalanceDeduction,
        this.minLeave,
        this.changeSupervisor,
        this.autoUnpaid,
        this.leaveTypeOrder,
        this.emergencyContact,
        this.timeSheetDeduction,
        // this.payTypeDropDownID,
        // this.payTypeDropDownValueID,
        this.onlyApplyForFullDay,
        this.canApplyForNextYear,
        this.deductWorkingWeekend,
        this.canAvailOn,
        // this.iaGradeLeave,
        // this.laLeaveAdjustment,
        // this.laLeaveApplicationMf,
        // this.laLeaveBalance,
        // this.laLeaveBalanceHistory,
        // this.laLeaveCalendarDt,
        // this.laLeaveCarryOver,
        // this.laLeaveEncashment,
        // this.laLeaveEncashmentRequest,
        // this.laLeaveEntitlement,
        // this.laLeaveReason,
        // this.laLeaveTypeDt,
        // this.laLeaveTypeMappingDt,
        this.trackingState,
      //  this.modifiedProperties
      });

  LeaveType.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    typeCode = json['TypeCode'];
    cultureID = json['CultureID'];
    typeTitle = json['TypeTitle'];
    typeDesc = json['TypeDesc'];
    unitID = json['UnitID'];
    includeWeedend = json['IncludeWeedend'];
    holidayPayTypeID = json['HolidayPayTypeID'];
    methodID = json['MethodID'];
    methodValue = json['MethodValue'];
    accrual = json['Accrual'];
    accrualFrequencyID = json['AccrualFrequencyID'];
    accrualCreditID = json['AccrualCreditID'];
    carryOver = json['CarryOver'];
    //maxCarryOverUnit = json['MaxCarryOverUnit'];
    encashment = json['Encashment'];
    encashmentUnit = json['EncashmentUnit'];
    airTicket = json['AirTicket'];
   // airTicketControlledInDay = json['AirTicketControlledInDay'];
    exitReEntryVisa = json['ExitReEntryVisa'];
   // exitReEntryVisaControlledInDay = json['ExitReEntryVisaControlledInDay'];
    genderSpecific = json['GenderSpecific'];
  //  genderID = json['GenderID'];
    maritalStatus = json['MaritalStatus'];
  //  maritalStatusID = json['MaritalStatusID'];
    allowNegativeBalance = json['AllowNegativeBalance'];
 //   maxAllowedBalanceInDay = json['MaxAllowedBalanceInDay'];
    supportDocRequired = json['SupportDocRequired'];
    noOfSupportDocRequired = json['NoOfSupportDocRequired'];
    leaveAlterGracePeriod = json['LeaveAlterGracePeriod'];
 //   leaveAlterGracePeriodInDay = json['LeaveAlterGracePeriodInDay'];
    minimumService = json['MinimumService'];
    minimumServiceFrequencyID = json['MinimumServiceFrequencyID'];
    // noOfTimeInYear = json['NoOfTimeInYear'];
    // noOfTimeInService = json['NoOfTimeInService'];
    minimumUnitValue = json['MinimumUnitValue'];
    maximumUnitValue = json['MaximumUnitValue'];
    leaveReturnApprovalRequired = json['LeaveReturnApprovalRequired'];
    alternateContactForLeave = json['AlternateContactForLeave'];
    maximumBalanceUnit = json['MaximumBalanceUnit'];
    balanceAdjustable = json['BalanceAdjustable'];
    enableSelfService = json['EnableSelfService'];
  //  leaveBalanceAdjTypeID = json['LeaveBalanceAdjTypeID'];
    leaveReasonRequired = json['LeaveReasonRequired'];
    leaveSalaryRequired = json['LeaveSalaryRequired'];
    effectiveDate = json['EffectiveDate'];
    active = json['Active'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedBy = json['ModifiedBy'];
    modifiedDate = json['ModifiedDate'];
    iconName = json['IconName'];
    autoLeaveBalanceDeduction = json['AutoLeaveBalanceDeduction'];
    minLeave = json['MinLeave'];
    changeSupervisor = json['ChangeSupervisor'];
    autoUnpaid = json['AutoUnpaid'];
    leaveTypeOrder = json['LeaveTypeOrder'];
    emergencyContact = json['EmergencyContact'];
    timeSheetDeduction = json['TimeSheetDeduction'];
    // payTypeDropDownID = json['PayTypeDropDownID'];
    // payTypeDropDownValueID = json['PayTypeDropDownValueID'];
    onlyApplyForFullDay = json['OnlyApplyForFullDay'];
    canApplyForNextYear = json['CanApplyForNextYear'];
    deductWorkingWeekend = json['DeductWorkingWeekend'];
    canAvailOn = json['CanAvailOn'];
    // if (json['ia_grade_leave'] != null) {
    //   iaGradeLeave = new List<Null>();
    //   json['ia_grade_leave'].forEach((v) {
    //     iaGradeLeave.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_adjustment'] != null) {
    //   laLeaveAdjustment = new List<Null>();
    //   json['la_leave_adjustment'].forEach((v) {
    //     laLeaveAdjustment.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_application_mf'] != null) {
    //   laLeaveApplicationMf = new List<Null>();
    //   json['la_leave_application_mf'].forEach((v) {
    //     laLeaveApplicationMf.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_balance'] != null) {
    //   laLeaveBalance = new List<Null>();
    //   json['la_leave_balance'].forEach((v) {
    //     laLeaveBalance.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_balance_history'] != null) {
    //   laLeaveBalanceHistory = new List<Null>();
    //   json['la_leave_balance_history'].forEach((v) {
    //     laLeaveBalanceHistory.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_calendar_dt'] != null) {
    //   laLeaveCalendarDt = new List<Null>();
    //   json['la_leave_calendar_dt'].forEach((v) {
    //     laLeaveCalendarDt.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_carry_over'] != null) {
    //   laLeaveCarryOver = new List<Null>();
    //   json['la_leave_carry_over'].forEach((v) {
    //     laLeaveCarryOver.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_encashment'] != null) {
    //   laLeaveEncashment = new List<Null>();
    //   json['la_leave_encashment'].forEach((v) {
    //     laLeaveEncashment.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_encashment_request'] != null) {
    //   laLeaveEncashmentRequest = new List<Null>();
    //   json['la_leave_encashment_request'].forEach((v) {
    //     laLeaveEncashmentRequest.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_entitlement'] != null) {
    //   laLeaveEntitlement = new List<Null>();
    //   json['la_leave_entitlement'].forEach((v) {
    //     laLeaveEntitlement.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_reason'] != null) {
    //   laLeaveReason = new List<Null>();
    //   json['la_leave_reason'].forEach((v) {
    //     laLeaveReason.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_type_dt'] != null) {
    //   laLeaveTypeDt = new List<Null>();
    //   json['la_leave_type_dt'].forEach((v) {
    //     laLeaveTypeDt.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_type_mapping_dt'] != null) {
    //   laLeaveTypeMappingDt = new List<Null>();
    //   json['la_leave_type_mapping_dt'].forEach((v) {
    //     laLeaveTypeMappingDt.add(new Null.fromJson(v));
    //   });
    // }
    trackingState = json['TrackingState'];
    //modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TypeCode'] = this.typeCode;
    data['CultureID'] = this.cultureID;
    data['TypeTitle'] = this.typeTitle;
    data['TypeDesc'] = this.typeDesc;
    data['UnitID'] = this.unitID;
    data['IncludeWeedend'] = this.includeWeedend;
    data['HolidayPayTypeID'] = this.holidayPayTypeID;
    data['MethodID'] = this.methodID;
    data['MethodValue'] = this.methodValue;
    data['Accrual'] = this.accrual;
    data['AccrualFrequencyID'] = this.accrualFrequencyID;
    data['AccrualCreditID'] = this.accrualCreditID;
    data['CarryOver'] = this.carryOver;
    //data['MaxCarryOverUnit'] = this.maxCarryOverUnit;
    data['Encashment'] = this.encashment;
    data['EncashmentUnit'] = this.encashmentUnit;
    data['AirTicket'] = this.airTicket;
   // data['AirTicketControlledInDay'] = this.airTicketControlledInDay;
    data['ExitReEntryVisa'] = this.exitReEntryVisa;
    // data['ExitReEntryVisaControlledInDay'] =
    //     this.exitReEntryVisaControlledInDay;
    data['GenderSpecific'] = this.genderSpecific;
   // data['GenderID'] = this.genderID;
    data['MaritalStatus'] = this.maritalStatus;
  //  data['MaritalStatusID'] = this.maritalStatusID;
    data['AllowNegativeBalance'] = this.allowNegativeBalance;
  //  data['MaxAllowedBalanceInDay'] = this.maxAllowedBalanceInDay;
    data['SupportDocRequired'] = this.supportDocRequired;
    data['NoOfSupportDocRequired'] = this.noOfSupportDocRequired;
    data['LeaveAlterGracePeriod'] = this.leaveAlterGracePeriod;
  //  data['LeaveAlterGracePeriodInDay'] = this.leaveAlterGracePeriodInDay;
    data['MinimumService'] = this.minimumService;
    data['MinimumServiceFrequencyID'] = this.minimumServiceFrequencyID;
    // data['NoOfTimeInYear'] = this.noOfTimeInYear;
    // data['NoOfTimeInService'] = this.noOfTimeInService;
    data['MinimumUnitValue'] = this.minimumUnitValue;
    data['MaximumUnitValue'] = this.maximumUnitValue;
    data['LeaveReturnApprovalRequired'] = this.leaveReturnApprovalRequired;
    data['AlternateContactForLeave'] = this.alternateContactForLeave;
    data['MaximumBalanceUnit'] = this.maximumBalanceUnit;
    data['BalanceAdjustable'] = this.balanceAdjustable;
    data['EnableSelfService'] = this.enableSelfService;
 //   data['LeaveBalanceAdjTypeID'] = this.leaveBalanceAdjTypeID;
    data['LeaveReasonRequired'] = this.leaveReasonRequired;
    data['LeaveSalaryRequired'] = this.leaveSalaryRequired;
    data['EffectiveDate'] = this.effectiveDate;
    data['Active'] = this.active;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedDate'] = this.modifiedDate;
    data['IconName'] = this.iconName;
    data['AutoLeaveBalanceDeduction'] = this.autoLeaveBalanceDeduction;
    data['MinLeave'] = this.minLeave;
    data['ChangeSupervisor'] = this.changeSupervisor;
    data['AutoUnpaid'] = this.autoUnpaid;
    data['LeaveTypeOrder'] = this.leaveTypeOrder;
    data['EmergencyContact'] = this.emergencyContact;
    data['TimeSheetDeduction'] = this.timeSheetDeduction;
    // data['PayTypeDropDownID'] = this.payTypeDropDownID;
    // data['PayTypeDropDownValueID'] = this.payTypeDropDownValueID;
    data['OnlyApplyForFullDay'] = this.onlyApplyForFullDay;
    data['CanApplyForNextYear'] = this.canApplyForNextYear;
    data['DeductWorkingWeekend'] = this.deductWorkingWeekend;
    data['CanAvailOn'] = this.canAvailOn;
    // if (this.iaGradeLeave != null) {
    //   data['ia_grade_leave'] =
    //       this.iaGradeLeave.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveAdjustment != null) {
    //   data['la_leave_adjustment'] =
    //       this.laLeaveAdjustment.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveApplicationMf != null) {
    //   data['la_leave_application_mf'] =
    //       this.laLeaveApplicationMf.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveBalance != null) {
    //   data['la_leave_balance'] =
    //       this.laLeaveBalance.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveBalanceHistory != null) {
    //   data['la_leave_balance_history'] =
    //       this.laLeaveBalanceHistory.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveCalendarDt != null) {
    //   data['la_leave_calendar_dt'] =
    //       this.laLeaveCalendarDt.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveCarryOver != null) {
    //   data['la_leave_carry_over'] =
    //       this.laLeaveCarryOver.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveEncashment != null) {
    //   data['la_leave_encashment'] =
    //       this.laLeaveEncashment.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveEncashmentRequest != null) {
    //   data['la_leave_encashment_request'] =
    //       this.laLeaveEncashmentRequest.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveEntitlement != null) {
    //   data['la_leave_entitlement'] =
    //       this.laLeaveEntitlement.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveReason != null) {
    //   data['la_leave_reason'] =
    //       this.laLeaveReason.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveTypeDt != null) {
    //   data['la_leave_type_dt'] =
    //       this.laLeaveTypeDt.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveTypeMappingDt != null) {
    //   data['la_leave_type_mapping_dt'] =
    //       this.laLeaveTypeMappingDt.map((v) => v.toJson()).toList();
    // }
    data['TrackingState'] = this.trackingState;
   // data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}

// class LeaveReson {
//   int? reasonID;
//   String? leaveTypeCode;
//   String? reasonTitle;
//   String? reasonDesc;
//
//   LeaveReson(
//       {this.reasonID, this.leaveTypeCode, this.reasonTitle, this.reasonDesc});
//
//   LeaveReson.fromJson(Map<String, dynamic> json) {
//     reasonID = json['ReasonID'];
//     leaveTypeCode = json['LeaveTypeCode'];
//     reasonTitle = json['ReasonTitle'];
//     reasonDesc = json['ReasonDesc'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ReasonID'] = this.reasonID;
//     data['LeaveTypeCode'] = this.leaveTypeCode;
//     data['ReasonTitle'] = this.reasonTitle;
//     data['ReasonDesc'] = this.reasonDesc;
//     return data;
//   }
// }
class ShiftInfo {
  String? shiftCode;
  // String? shiftStartTime;
  // String? shiftEndTime;
  // String? breakStartTime;
  // String? breakEndTime;
  int? weekDayID;
  bool? offDay;

  ShiftInfo(
      {this.shiftCode,
        // this.shiftStartTime,
        // this.shiftEndTime,
        // this.breakStartTime,
        // this.breakEndTime,
        this.weekDayID,
        this.offDay});

  ShiftInfo.fromJson(Map<String, dynamic> json) {
    shiftCode = json['ShiftCode'];
    // shiftStartTime = json['ShiftStartTime'];
    // shiftEndTime = json['ShiftEndTime'];
    // breakStartTime = json['BreakStartTime'];
    // breakEndTime = json['BreakEndTime'];
    weekDayID = json['WeekDayID'];
    offDay = json['OffDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ShiftCode'] = this.shiftCode;
    // data['ShiftStartTime'] = this.shiftStartTime;
    // data['ShiftEndTime'] = this.shiftEndTime;
    // data['BreakStartTime'] = this.breakStartTime;
    // data['BreakEndTime'] = this.breakEndTime;
    data['WeekDayID'] = this.weekDayID;
    data['OffDay'] = this.offDay;
    return data;
  }
}

class LeaveCalander {
  String? calendarCode;
  String? calendarTitle;

  LeaveCalander({this.calendarCode, this.calendarTitle});

  LeaveCalander.fromJson(Map<String, dynamic> json) {
    calendarCode = json['CalendarCode'];
    calendarTitle = json['CalendarTitle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CalendarCode'] = this.calendarCode;
    data['CalendarTitle'] = this.calendarTitle;
    return data;
  }
}

class HalfLeaveDropdown {
  int? iD;
  int? dropDownID;
  int? cultureID;
  String? value;
  bool? isDeleted;
  String? remarks;
  // Null dependedDropDownID;
  // Null dependedDropDownValueID;
  // List<Null> admAlertMf;
  // List<Null> admAlertMf1;
  // List<Null> admAlertMf2;
  // List<Null> admAlertMf3;
  // List<Null> admCustomReportTerm;
  // List<Null> admLetterMf;
  // List<Null> admLetterMf1;
  // List<Null> admLetterParameter;
  // List<Null> admVisitor;
  // List<Null> btTravelRequestMf;
  // List<Null> btTravelRequestMf1;
  // List<Null> cpElementMf;
  // List<Null> iaEmployeeSeperationMf;
  // List<Null> iaTodosWorkflowMf;
  // List<Null> iaTodosWorkflowSubset;
  // List<Null> iaTodosWorkflowSubset1;
  // List<Null> iaTodosWorkflowSubset2;
  // List<Null> iaTodosWorkflowTaskMf;
  // List<Null> iaTodosWorkflowTaskSubset;
  // List<Null> iaTodosWorkflowTaskSubset1;
  // List<Null> iaTodosWorkflowTaskSubset2;
  // List<Null> laHolidayCalendarDt;
  // List<Null> laLeaveApplicationTimeoff;
  // List<Null> laTimeSheet;
  // List<Null> laTimeSheet1;
  // List<Null> rsInterviewMf;
  // List<Null> rsOfferCondition;
  // List<Null> rsOfferDocument;
  // List<Null> rsOfferMf;
  // Null sysDropDownMf;
  // List<Null> iaUserEmployeeMf;
  int? trackingState;
  //Null modifiedProperties;

  HalfLeaveDropdown(
      {this.iD,
        this.dropDownID,
        this.cultureID,
        this.value,
        this.isDeleted,
        this.remarks,
        // this.dependedDropDownID,
        // this.dependedDropDownValueID,
        // this.admAlertMf,
        // this.admAlertMf1,
        // this.admAlertMf2,
        // this.admAlertMf3,
        // this.admCustomReportTerm,
        // this.admLetterMf,
        // this.admLetterMf1,
        // this.admLetterParameter,
        // this.admVisitor,
        // this.btTravelRequestMf,
        // this.btTravelRequestMf1,
        // this.cpElementMf,
        // this.iaEmployeeSeperationMf,
        // this.iaTodosWorkflowMf,
        // this.iaTodosWorkflowSubset,
        // this.iaTodosWorkflowSubset1,
        // this.iaTodosWorkflowSubset2,
        // this.iaTodosWorkflowTaskMf,
        // this.iaTodosWorkflowTaskSubset,
        // this.iaTodosWorkflowTaskSubset1,
        // this.iaTodosWorkflowTaskSubset2,
        // this.laHolidayCalendarDt,
        // this.laLeaveApplicationTimeoff,
        // this.laTimeSheet,
        // this.laTimeSheet1,
        // this.rsInterviewMf,
        // this.rsOfferCondition,
        // this.rsOfferDocument,
        // this.rsOfferMf,
        // this.sysDropDownMf,
        // this.iaUserEmployeeMf,
        this.trackingState,
      //  this.modifiedProperties
      });

  HalfLeaveDropdown.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    dropDownID = json['DropDownID'];
    cultureID = json['CultureID'];
    value = json['Value'];
    isDeleted = json['IsDeleted'];
    remarks = json['Remarks'];
    // dependedDropDownID = json['DependedDropDownID'];
    // dependedDropDownValueID = json['DependedDropDownValueID'];
    // if (json['adm_alert_mf'] != null) {
    //   admAlertMf = new List<Null>();
    //   json['adm_alert_mf'].forEach((v) {
    //     admAlertMf.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['adm_alert_mf1'] != null) {
    //   admAlertMf1 = new List<Null>();
    //   json['adm_alert_mf1'].forEach((v) {
    //     admAlertMf1.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['adm_alert_mf2'] != null) {
    //   admAlertMf2 = new List<Null>();
    //   json['adm_alert_mf2'].forEach((v) {
    //     admAlertMf2.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['adm_alert_mf3'] != null) {
    //   admAlertMf3 = new List<Null>();
    //   json['adm_alert_mf3'].forEach((v) {
    //     admAlertMf3.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['adm_custom_report_term'] != null) {
    //   admCustomReportTerm = new List<Null>();
    //   json['adm_custom_report_term'].forEach((v) {
    //     admCustomReportTerm.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['adm_letter_mf'] != null) {
    //   admLetterMf = new List<Null>();
    //   json['adm_letter_mf'].forEach((v) {
    //     admLetterMf.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['adm_letter_mf1'] != null) {
    //   admLetterMf1 = new List<Null>();
    //   json['adm_letter_mf1'].forEach((v) {
    //     admLetterMf1.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['adm_letter_parameter'] != null) {
    //   admLetterParameter = new List<Null>();
    //   json['adm_letter_parameter'].forEach((v) {
    //     admLetterParameter.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['adm_visitor'] != null) {
    //   admVisitor = new List<Null>();
    //   json['adm_visitor'].forEach((v) {
    //     admVisitor.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['bt_travel_request_mf'] != null) {
    //   btTravelRequestMf = new List<Null>();
    //   json['bt_travel_request_mf'].forEach((v) {
    //     btTravelRequestMf.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['bt_travel_request_mf1'] != null) {
    //   btTravelRequestMf1 = new List<Null>();
    //   json['bt_travel_request_mf1'].forEach((v) {
    //     btTravelRequestMf1.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['cp_element_mf'] != null) {
    //   cpElementMf = new List<Null>();
    //   json['cp_element_mf'].forEach((v) {
    //     cpElementMf.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['ia_employee_seperation_mf'] != null) {
    //   iaEmployeeSeperationMf = new List<Null>();
    //   json['ia_employee_seperation_mf'].forEach((v) {
    //     iaEmployeeSeperationMf.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['ia_todos_workflow_mf'] != null) {
    //   iaTodosWorkflowMf = new List<Null>();
    //   json['ia_todos_workflow_mf'].forEach((v) {
    //     iaTodosWorkflowMf.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['ia_todos_workflow_subset'] != null) {
    //   iaTodosWorkflowSubset = new List<Null>();
    //   json['ia_todos_workflow_subset'].forEach((v) {
    //     iaTodosWorkflowSubset.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['ia_todos_workflow_subset1'] != null) {
    //   iaTodosWorkflowSubset1 = new List<Null>();
    //   json['ia_todos_workflow_subset1'].forEach((v) {
    //     iaTodosWorkflowSubset1.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['ia_todos_workflow_subset2'] != null) {
    //   iaTodosWorkflowSubset2 = new List<Null>();
    //   json['ia_todos_workflow_subset2'].forEach((v) {
    //     iaTodosWorkflowSubset2.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['ia_todos_workflow_task_mf'] != null) {
    //   iaTodosWorkflowTaskMf = new List<Null>();
    //   json['ia_todos_workflow_task_mf'].forEach((v) {
    //     iaTodosWorkflowTaskMf.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['ia_todos_workflow_task_subset'] != null) {
    //   iaTodosWorkflowTaskSubset = new List<Null>();
    //   json['ia_todos_workflow_task_subset'].forEach((v) {
    //     iaTodosWorkflowTaskSubset.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['ia_todos_workflow_task_subset1'] != null) {
    //   iaTodosWorkflowTaskSubset1 = new List<Null>();
    //   json['ia_todos_workflow_task_subset1'].forEach((v) {
    //     iaTodosWorkflowTaskSubset1.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['ia_todos_workflow_task_subset2'] != null) {
    //   iaTodosWorkflowTaskSubset2 = new List<Null>();
    //   json['ia_todos_workflow_task_subset2'].forEach((v) {
    //     iaTodosWorkflowTaskSubset2.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_holiday_calendar_dt'] != null) {
    //   laHolidayCalendarDt = new List<Null>();
    //   json['la_holiday_calendar_dt'].forEach((v) {
    //     laHolidayCalendarDt.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_application_timeoff'] != null) {
    //   laLeaveApplicationTimeoff = new List<Null>();
    //   json['la_leave_application_timeoff'].forEach((v) {
    //     laLeaveApplicationTimeoff.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_time_sheet'] != null) {
    //   laTimeSheet = new List<Null>();
    //   json['la_time_sheet'].forEach((v) {
    //     laTimeSheet.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_time_sheet1'] != null) {
    //   laTimeSheet1 = new List<Null>();
    //   json['la_time_sheet1'].forEach((v) {
    //     laTimeSheet1.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['rs_interview_mf'] != null) {
    //   rsInterviewMf = new List<Null>();
    //   json['rs_interview_mf'].forEach((v) {
    //     rsInterviewMf.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['rs_offer_condition'] != null) {
    //   rsOfferCondition = new List<Null>();
    //   json['rs_offer_condition'].forEach((v) {
    //     rsOfferCondition.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['rs_offer_document'] != null) {
    //   rsOfferDocument = new List<Null>();
    //   json['rs_offer_document'].forEach((v) {
    //     rsOfferDocument.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['rs_offer_mf'] != null) {
    //   rsOfferMf = new List<Null>();
    //   json['rs_offer_mf'].forEach((v) {
    //     rsOfferMf.add(new Null.fromJson(v));
    //   });
    // }
    // sysDropDownMf = json['sys_drop_down_mf'];
    // if (json['ia_user_employee_mf'] != null) {
    //   iaUserEmployeeMf = new List<Null>();
    //   json['ia_user_employee_mf'].forEach((v) {
    //     iaUserEmployeeMf.add(new Null.fromJson(v));
    //   });
    // }
    trackingState = json['TrackingState'];
    //modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['DropDownID'] = this.dropDownID;
    data['CultureID'] = this.cultureID;
    data['Value'] = this.value;
    data['IsDeleted'] = this.isDeleted;
    data['Remarks'] = remarks;
    // data['DependedDropDownID'] = this.dependedDropDownID;
    // data['DependedDropDownValueID'] = this.dependedDropDownValueID;
    // if (this.admAlertMf != null) {
    //   data['adm_alert_mf'] = this.admAlertMf.map((v) => v.toJson()).toList();
    // }
    // if (this.admAlertMf1 != null) {
    //   data['adm_alert_mf1'] = this.admAlertMf1.map((v) => v.toJson()).toList();
    // }
    // if (this.admAlertMf2 != null) {
    //   data['adm_alert_mf2'] = this.admAlertMf2.map((v) => v.toJson()).toList();
    // }
    // if (this.admAlertMf3 != null) {
    //   data['adm_alert_mf3'] = this.admAlertMf3.map((v) => v.toJson()).toList();
    // }
    // if (this.admCustomReportTerm != null) {
    //   data['adm_custom_report_term'] =
    //       this.admCustomReportTerm.map((v) => v.toJson()).toList();
    // }
    // if (this.admLetterMf != null) {
    //   data['adm_letter_mf'] = this.admLetterMf.map((v) => v.toJson()).toList();
    // }
    // if (this.admLetterMf1 != null) {
    //   data['adm_letter_mf1'] =
    //       this.admLetterMf1.map((v) => v.toJson()).toList();
    // }
    // if (this.admLetterParameter != null) {
    //   data['adm_letter_parameter'] =
    //       this.admLetterParameter.map((v) => v.toJson()).toList();
    // }
    // if (this.admVisitor != null) {
    //   data['adm_visitor'] = this.admVisitor.map((v) => v.toJson()).toList();
    // }
    // if (this.btTravelRequestMf != null) {
    //   data['bt_travel_request_mf'] =
    //       this.btTravelRequestMf.map((v) => v.toJson()).toList();
    // }
    // if (this.btTravelRequestMf1 != null) {
    //   data['bt_travel_request_mf1'] =
    //       this.btTravelRequestMf1.map((v) => v.toJson()).toList();
    // }
    // if (this.cpElementMf != null) {
    //   data['cp_element_mf'] = this.cpElementMf.map((v) => v.toJson()).toList();
    // }
    // if (this.iaEmployeeSeperationMf != null) {
    //   data['ia_employee_seperation_mf'] =
    //       this.iaEmployeeSeperationMf.map((v) => v.toJson()).toList();
    // }
    // if (this.iaTodosWorkflowMf != null) {
    //   data['ia_todos_workflow_mf'] =
    //       this.iaTodosWorkflowMf.map((v) => v.toJson()).toList();
    // }
    // if (this.iaTodosWorkflowSubset != null) {
    //   data['ia_todos_workflow_subset'] =
    //       this.iaTodosWorkflowSubset.map((v) => v.toJson()).toList();
    // }
    // if (this.iaTodosWorkflowSubset1 != null) {
    //   data['ia_todos_workflow_subset1'] =
    //       this.iaTodosWorkflowSubset1.map((v) => v.toJson()).toList();
    // }
    // if (this.iaTodosWorkflowSubset2 != null) {
    //   data['ia_todos_workflow_subset2'] =
    //       this.iaTodosWorkflowSubset2.map((v) => v.toJson()).toList();
    // }
    // if (this.iaTodosWorkflowTaskMf != null) {
    //   data['ia_todos_workflow_task_mf'] =
    //       this.iaTodosWorkflowTaskMf.map((v) => v.toJson()).toList();
    // }
    // if (this.iaTodosWorkflowTaskSubset != null) {
    //   data['ia_todos_workflow_task_subset'] =
    //       this.iaTodosWorkflowTaskSubset.map((v) => v.toJson()).toList();
    // }
    // if (this.iaTodosWorkflowTaskSubset1 != null) {
    //   data['ia_todos_workflow_task_subset1'] =
    //       this.iaTodosWorkflowTaskSubset1.map((v) => v.toJson()).toList();
    // }
    // if (this.iaTodosWorkflowTaskSubset2 != null) {
    //   data['ia_todos_workflow_task_subset2'] =
    //       this.iaTodosWorkflowTaskSubset2.map((v) => v.toJson()).toList();
    // }
    // if (this.laHolidayCalendarDt != null) {
    //   data['la_holiday_calendar_dt'] =
    //       this.laHolidayCalendarDt.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveApplicationTimeoff != null) {
    //   data['la_leave_application_timeoff'] =
    //       this.laLeaveApplicationTimeoff.map((v) => v.toJson()).toList();
    // }
    // if (this.laTimeSheet != null) {
    //   data['la_time_sheet'] = this.laTimeSheet.map((v) => v.toJson()).toList();
    // }
    // if (this.laTimeSheet1 != null) {
    //   data['la_time_sheet1'] =
    //       this.laTimeSheet1.map((v) => v.toJson()).toList();
    // }
    // if (this.rsInterviewMf != null) {
    //   data['rs_interview_mf'] =
    //       this.rsInterviewMf.map((v) => v.toJson()).toList();
    // }
    // if (this.rsOfferCondition != null) {
    //   data['rs_offer_condition'] =
    //       this.rsOfferCondition.map((v) => v.toJson()).toList();
    // }
    // if (this.rsOfferDocument != null) {
    //   data['rs_offer_document'] =
    //       this.rsOfferDocument.map((v) => v.toJson()).toList();
    // }
    // if (this.rsOfferMf != null) {
    //   data['rs_offer_mf'] = this.rsOfferMf.map((v) => v.toJson()).toList();
    // }
    // data['sys_drop_down_mf'] = this.sysDropDownMf;
    // if (this.iaUserEmployeeMf != null) {
    //   data['ia_user_employee_mf'] =
    //       this.iaUserEmployeeMf.map((v) => v.toJson()).toList();
    // }
    data['TrackingState'] = this.trackingState;
   // data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}
class CompanySetting {
  dynamic companyCode;
  int? companyWeekend;

  CompanySetting({this.companyCode, this.companyWeekend});

  CompanySetting.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    companyWeekend = json['CompanyWeekend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyCode'] = this.companyCode;
    data['CompanyWeekend'] = this.companyWeekend;
    return data;
  }
}