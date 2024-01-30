class GetRequestListsJson {
  bool? isSuccess;
  RequestListsResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetRequestListsJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetRequestListsJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? RequestListsResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsSuccess'] = isSuccess;
    if (resultSet != null) {
      data['ResultSet'] = resultSet?.toJson();
    }
    data['FilePath'] = filePath;
    data['Message'] = message;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}

class RequestListsResultSet {
  int? totalRecord;
  List<RequestListDataList>? dataList;

  RequestListsResultSet({this.totalRecord, this.dataList});

  RequestListsResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = List<RequestListDataList>.empty(growable: true);
      json['DataList'].forEach((v) {
        dataList?.add(RequestListDataList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TotalRecord'] = totalRecord;
    if (dataList != null) {
      data['DataList'] = dataList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RequestListDataList {
  int? iD;
  String? requestCode;
  int? cultureID;
  String? requestDate;
  int? approvalStatusID;
  dynamic employeeCode;
  String? employeeName;
  String? statusName;
  String? orderDate;

  RequestListDataList(
      {this.iD,
        this.requestCode,
        this.cultureID,
        this.requestDate,
        this.employeeCode,
        this.approvalStatusID,
        this.employeeName,
        this.statusName,
        this.orderDate});

  RequestListDataList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    requestCode = json['RequestCode'];
    cultureID = json['CultureID'];
    requestDate = json['RequestDate'];
    employeeCode = json['EmployeeCode'];
    approvalStatusID = json['ApprovalStatusID'];
    employeeName = json['EmployeeName'];
    statusName = json['StatusName'];
    orderDate = json['OrderDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['RequestCode'] = requestCode;
    data['CultureID'] = cultureID;
    data['EmployeeCode'] = employeeCode;
    data['RequestDate'] = requestDate;
    data['ApprovalStatusID'] = approvalStatusID;
    data['EmployeeName'] = employeeName;
    data['StatusName'] = statusName;
    data['OrderDate'] = orderDate;
    return data;
  }
}