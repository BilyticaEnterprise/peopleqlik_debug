class GetSeparationRequestListsJson {
  bool? isSuccess;
  GetSeparationResultSet? resultSet;
  String? errorMessage;
  String? message;

  GetSeparationRequestListsJson(
      {this.isSuccess,
        this.resultSet,
        this.errorMessage});

  GetSeparationRequestListsJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new GetSeparationResultSet.fromJson(json['ResultSet'])
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

class GetSeparationResultSet {
  int? totalRecord;
  List<GetSeparationDataList>? dataList;

  GetSeparationResultSet({this.totalRecord, this.dataList});

  GetSeparationResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = <GetSeparationDataList>[];
      json['DataList'].forEach((v) {
        dataList!.add(new GetSeparationDataList.fromJson(v));
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

class GetSeparationDataList {
  int? iD;
  String? employeeName;
  String? effectiveFrom;
  String? createdDate;
  int? approvalStatusID;
  String? lastWorkingDate;
  dynamic newLastWorkingDate;
  String? statusName;
  String? remarks;
  dynamic newRemarks;
  String? jobCode;
  String? jobDesc;
  String? documentNo;
  int? screenID;
  int? companyCode;

  GetSeparationDataList(
      {this.iD,
        this.employeeName,
        this.effectiveFrom,
        this.createdDate,
        this.approvalStatusID,
        this.lastWorkingDate,
        this.newLastWorkingDate,
        this.statusName,
        this.remarks,
        this.newRemarks,
        this.jobCode,
        this.jobDesc,
        this.documentNo,
        this.screenID,
        this.companyCode
      });

  GetSeparationDataList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    employeeName = json['EmployeeName'];
    effectiveFrom = json['EffectiveFrom'];
    createdDate = json['CreatedDate'];
    approvalStatusID = json['ApprovalStatusID'];
    lastWorkingDate = json['LastWorkingDate'];
    newLastWorkingDate = json['NewLastWorkingDate'];
    statusName = json['StatusName'];
    remarks = json['Remarks'];
    newRemarks = json['NewRemarks'];
    jobCode = json['JobCode'];
    jobDesc = json['JobDesc'];
    documentNo = json['DocumentNo'];
    screenID = json['ScreenID'];
    companyCode = json['CompanyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['EmployeeName'] = this.employeeName;
    data['EffectiveFrom'] = this.effectiveFrom;
    data['CreatedDate'] = this.createdDate;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['LastWorkingDate'] = this.lastWorkingDate;
    data['NewLastWorkingDate'] = this.newLastWorkingDate;
    data['StatusName'] = this.statusName;
    data['Remarks'] = this.remarks;
    data['NewRemarks'] = this.newRemarks;
    data['JobCode'] = this.jobCode;
    data['JobDesc'] = this.jobDesc;
    data['DocumentNo'] = documentNo;
    data['ScreenID'] = screenID;
    data['CompanyCode'] = companyCode;
    return data;
  }
}