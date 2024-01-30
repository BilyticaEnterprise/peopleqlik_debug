class GetSpecialRequestFormJson {
  bool? isSuccess;
  SpecialRequestResultSet? resultSet;
  String? errorMessage;

  GetSpecialRequestFormJson(
      {this.isSuccess,
        this.resultSet,
        this.errorMessage});

  GetSpecialRequestFormJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new SpecialRequestResultSet.fromJson(json['ResultSet'])
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

class SpecialRequestResultSet {
  List<EmployeeLeaveType>? employeeLeaveType;
  List<PaymentType>? paymentType;

  SpecialRequestResultSet({this.employeeLeaveType, this.paymentType});

  SpecialRequestResultSet.fromJson(Map<String, dynamic> json) {
    if (json['EmployeeLeaveType'] != null) {
      employeeLeaveType = <EmployeeLeaveType>[];
      json['EmployeeLeaveType'].forEach((v) {
        employeeLeaveType!.add(new EmployeeLeaveType.fromJson(v));
      });
    }
    if (json['PaymentType'] != null) {
      paymentType = <PaymentType>[];
      json['PaymentType'].forEach((v) {
        paymentType!.add(new PaymentType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employeeLeaveType != null) {
      data['EmployeeLeaveType'] =
          this.employeeLeaveType!.map((v) => v.toJson()).toList();
    }
    if (this.paymentType != null) {
      data['PaymentType'] = this.paymentType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeLeaveType {
  String? typeCode;
  String? typeTitle;
  String? typeName;
  String? calendarCode;

  EmployeeLeaveType(
      {this.typeCode, this.typeTitle, this.typeName, this.calendarCode});

  EmployeeLeaveType.fromJson(Map<String, dynamic> json) {
    typeCode = json['TypeCode'];
    typeTitle = json['TypeTitle'];
    typeName = json['TypeName'];
    calendarCode = json['CalendarCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TypeCode'] = this.typeCode;
    data['TypeTitle'] = this.typeTitle;
    data['TypeName'] = this.typeName;
    data['CalendarCode'] = this.calendarCode;
    return data;
  }
}

class PaymentType {
  int? typeID;
  String? typeName;

  PaymentType({this.typeID, this.typeName});

  PaymentType.fromJson(Map<String, dynamic> json) {
    typeID = json['TypeID'];
    typeName = json['TypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TypeID'] = this.typeID;
    data['TypeName'] = this.typeName;
    return data;
  }
}