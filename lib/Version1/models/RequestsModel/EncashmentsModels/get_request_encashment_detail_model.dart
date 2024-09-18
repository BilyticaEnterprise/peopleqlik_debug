import 'package:peopleqlik_debug/Version1/models/ApprovalsModel/get_approvals_detail_model.dart';

class GetRequestEncashmentDetailsJson {
  bool? isSuccess;
  EncashmentDetailResultSet? resultSet;
  String? errorMessage;

  GetRequestEncashmentDetailsJson(
      {this.isSuccess,
        this.resultSet,
        this.errorMessage});

  GetRequestEncashmentDetailsJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new EncashmentDetailResultSet.fromJson(json['ResultSet'])
        : null;
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class EncashmentDetailResultSet {
  List<ReuestDetail>? reuestDetail;
  List<ApprovalHistory>? approvalHistory;

  EncashmentDetailResultSet({this.reuestDetail, this.approvalHistory});

  EncashmentDetailResultSet.fromJson(Map<String, dynamic> json) {
    if (json['ReuestDetail'] != null) {
      reuestDetail = <ReuestDetail>[];
      json['ReuestDetail'].forEach((v) {
        reuestDetail!.add(new ReuestDetail.fromJson(v));
      });
    }
    if (json['ApprovalHistory'] != null) {
      approvalHistory = <ApprovalHistory>[];
      json['ApprovalHistory'].forEach((v) {
        approvalHistory!.add(new ApprovalHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reuestDetail != null) {
      data['ReuestDetail'] = this.reuestDetail!.map((v) => v.toJson()).toList();
    }
    if (this.approvalHistory != null) {
      data['ApprovalHistory'] =
          this.approvalHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReuestDetail {
  dynamic iD;
  String? requestCode;
  dynamic cultureID;
  // dynamic companyCode;
  // dynamic employeeCode;
  dynamic paymentTypeID;
  String? leaveTypeCode;
  dynamic encashmentUnit;
  dynamic createdBy;
  String? createdDate;
  dynamic modifiedBy;
  String? modifiedDate;
  double? balanceUnit;
  dynamic maxEncashmentUnit;
  dynamic typeID;
  String? leaveType;
  String? calendarCode;
  dynamic approvalStatusID;
  ArPaymentType? arPaymentType;
  dynamic iaEmployeeMf;
  dynamic laLeaveTypeMf;
  //List<LaLeaveEncashmentRequestDt>? laLeaveEncashmentRequestDt;
  int? trackingState;
  dynamic modifiedProperties;

  ReuestDetail(
      {
        this.iD,
        this.requestCode,
        this.cultureID,
        // this.companyCode,
        // this.employeeCode,
        this.paymentTypeID,
        this.leaveTypeCode,
        this.encashmentUnit,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.balanceUnit,
        this.maxEncashmentUnit,
        this.typeID,
        this.leaveType,
        this.calendarCode,
        this.approvalStatusID,
        this.arPaymentType,
        this.iaEmployeeMf,
        this.laLeaveTypeMf,
        // this.laLeaveEncashmentRequestDt,
        this.trackingState,
        this.modifiedProperties});

  ReuestDetail.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    requestCode = json['RequestCode'];
    cultureID = json['CultureID'];
    // companyCode = json['CompanyCode'];
    // employeeCode = json['EmployeeCode'];
    paymentTypeID = json['PaymentTypeID'];
    leaveTypeCode = json['LeaveTypeCode'];
    encashmentUnit = json['EncashmentUnit'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedBy = json['ModifiedBy'];
    modifiedDate = json['ModifiedDate'];
    balanceUnit = json['BalanceUnit'];
    maxEncashmentUnit = json['MaxEncashmentUnit'];
    typeID = json['TypeID'];
    leaveType = json['LeaveType'];
    calendarCode = json['CalendarCode'];
    approvalStatusID = json['ApprovalStatusID'];
    arPaymentType = json['ar_payment_type'] != null
        ? new ArPaymentType.fromJson(json['ar_payment_type'])
        : null;
    iaEmployeeMf = json['ia_employee_mf'];
    laLeaveTypeMf = json['la_leave_type_mf'];
    // if (json['la_leave_encashment_request_dt'] != null) {
    //   laLeaveEncashmentRequestDt = <LaLeaveEncashmentRequestDt>[];
    //   json['la_leave_encashment_request_dt'].forEach((v) {
    //     laLeaveEncashmentRequestDt!
    //         .add(new LaLeaveEncashmentRequestDt.fromJson(v));
    //   });
    // }
    trackingState = json['TrackingState'];
    modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['RequestCode'] = this.requestCode;
    data['CultureID'] = this.cultureID;
    // data['CompanyCode'] = this.companyCode;
    // data['EmployeeCode'] = this.employeeCode;
    data['PaymentTypeID'] = this.paymentTypeID;
    data['LeaveTypeCode'] = this.leaveTypeCode;
    data['EncashmentUnit'] = this.encashmentUnit;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedDate'] = this.modifiedDate;
    data['BalanceUnit'] = this.balanceUnit;
    data['MaxEncashmentUnit'] = this.maxEncashmentUnit;
    data['TypeID'] = this.typeID;
    data['LeaveType'] = this.leaveType;
    data['CalendarCode'] = this.calendarCode;
    data['ApprovalStatusID'] = this.approvalStatusID;
    if (this.arPaymentType != null) {
      data['ar_payment_type'] = this.arPaymentType!.toJson();
    }
    data['ia_employee_mf'] = this.iaEmployeeMf;
    data['la_leave_type_mf'] = this.laLeaveTypeMf;
    // if (this.laLeaveEncashmentRequestDt != null) {
    //   data['la_leave_encashment_request_dt'] =
    //       this.laLeaveEncashmentRequestDt!.map((v) => v.toJson()).toList();
    // }
    data['TrackingState'] = this.trackingState;
    data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}

class ArPaymentType {
  int? iD;
  int? typeID;
  int? cultureID;
  String? typeName;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  int? trackingState;
  dynamic modifiedProperties;

  ArPaymentType(
      {this.iD,
        this.typeID,
        this.cultureID,
        this.typeName,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.trackingState,
        this.modifiedProperties});

  ArPaymentType.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    typeID = json['TypeID'];
    cultureID = json['CultureID'];
    typeName = json['TypeName'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedBy = json['ModifiedBy'];
    modifiedDate = json['ModifiedDate'];
    // if (json['ar_advance_mf'] != null) {
    //   arAdvanceMf = <Null>[];
    //   json['ar_advance_mf'].forEach((v) {
    //     arAdvanceMf!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['ar_expense_item'] != null) {
    //   arExpenseItem = <Null>[];
    //   json['ar_expense_item'].forEach((v) {
    //     arExpenseItem!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['la_leave_encashment_request'] != null) {
    //   laLeaveEncashmentRequest = <Null>[];
    //   json['la_leave_encashment_request'].forEach((v) {
    //     laLeaveEncashmentRequest!.add(new Null.fromJson(v));
    //   });
    // }
    trackingState = json['TrackingState'];
    modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['TypeID'] = this.typeID;
    data['CultureID'] = this.cultureID;
    data['TypeName'] = this.typeName;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedDate'] = this.modifiedDate;
    // if (this.arAdvanceMf != null) {
    //   data['ar_advance_mf'] = this.arAdvanceMf!.map((v) => v.toJson()).toList();
    // }
    // if (this.arExpenseItem != null) {
    //   data['ar_expense_item'] =
    //       this.arExpenseItem!.map((v) => v.toJson()).toList();
    // }
    // if (this.laLeaveEncashmentRequest != null) {
    //   data['la_leave_encashment_request'] =
    //       this.laLeaveEncashmentRequest!.map((v) => v.toJson()).toList();
    // }
    data['TrackingState'] = this.trackingState;
    data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}

class LaLeaveEncashmentRequestDt {
  dynamic iD;
  String? requestCode;
  dynamic cultureID;
  dynamic companyCode;
  String? fileName;
  String? fileSize;
  int? trackingState;
  dynamic modifiedProperties;

  LaLeaveEncashmentRequestDt(
      {this.iD,
        this.requestCode,
        this.cultureID,
        this.companyCode,
        this.fileName,
        this.fileSize,
        this.trackingState,
        this.modifiedProperties});

  LaLeaveEncashmentRequestDt.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    requestCode = json['RequestCode'];
    cultureID = json['CultureID'];
    companyCode = json['CompanyCode'];
    fileName = json['FileName'];
    fileSize = json['FileSize'];
    trackingState = json['TrackingState'];
    modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['RequestCode'] = this.requestCode;
    data['CultureID'] = this.cultureID;
    data['CompanyCode'] = this.companyCode;
    data['FileName'] = this.fileName;
    data['FileSize'] = this.fileSize;
    data['TrackingState'] = this.trackingState;
    data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}