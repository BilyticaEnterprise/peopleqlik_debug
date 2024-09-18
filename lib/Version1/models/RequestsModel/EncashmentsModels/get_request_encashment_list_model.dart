class GetEncashmentRequestListsJson {
  bool? isSuccess;
  SpecialRequestResultSet? resultSet;
  String? errorMessage;
  String? message;

  GetEncashmentRequestListsJson(
      {this.isSuccess,
        this.resultSet,
        this.errorMessage});

  GetEncashmentRequestListsJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new SpecialRequestResultSet.fromJson(json['ResultSet'])
        : null;
    errorMessage = json['ErrorMessage'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    data['ErrorMessage'] = this.errorMessage;
    data['Message'] = message;
    return data;
  }
}

class SpecialRequestResultSet {
  int? totalRecord;
  List<RequestSpecialDataList>? dataList;

  SpecialRequestResultSet({this.totalRecord, this.dataList});

  SpecialRequestResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = <RequestSpecialDataList>[];
      json['DataList'].forEach((v) {
        dataList!.add(new RequestSpecialDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalRecord'] = this.totalRecord;
    if (this.dataList != null) {
      data['DataList'] = this.dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestSpecialDataList {
  int? iD;
  dynamic companyCode;
  dynamic employeeCode;
  String? requestCode;
  double? encashmentUnit;
  String? paymentTypeName;
  int? cultureID;
  bool? encashment;
  String? leaveTypeTitle;
  int? approvalStatusID;
  String? statusName;
  String? modifiedDate;
  String? documentNo;
  int? screenID;

  RequestSpecialDataList(
      {this.iD,
        this.companyCode,
        this.employeeCode,
        this.requestCode,
        this.encashmentUnit,
        this.paymentTypeName,
        this.cultureID,
        this.encashment,
        this.leaveTypeTitle,
        this.approvalStatusID,
        this.statusName,
        this.modifiedDate,
        this.documentNo,
        this.screenID
      });

  RequestSpecialDataList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    requestCode = json['RequestCode'];
    encashmentUnit = json['EncashmentUnit'];
    paymentTypeName = json['PaymentTypeName'];
    cultureID = json['CultureID'];
    encashment = json['Encashment'];
    leaveTypeTitle = json['LeaveTypeTitle'];
    approvalStatusID = json['ApprovalStatusID'];
    statusName = json['StatusName'];
    modifiedDate = json['ModifiedDate'];
    documentNo = json['DocumentNo'];
    screenID = json['ScreenID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    data['RequestCode'] = this.requestCode;
    data['EncashmentUnit'] = this.encashmentUnit;
    data['PaymentTypeName'] = this.paymentTypeName;
    data['CultureID'] = this.cultureID;
    data['Encashment'] = this.encashment;
    data['LeaveTypeTitle'] = this.leaveTypeTitle;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['StatusName'] = this.statusName;
    data['ModifiedDate'] = this.modifiedDate;
    data['DocumentNo'] = documentNo;
    data['ScreenID'] = screenID;
    return data;
  }
}