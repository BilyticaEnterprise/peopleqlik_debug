class ShiftListModel {
  bool? isSuccess;
  ShiftListResultSet? resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;
  dynamic errorResultSet;

  ShiftListModel(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo,
        this.errorResultSet});

  ShiftListModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new ShiftListResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    documentNo = json['DocumentNo'];
    errorResultSet = json['ErrorResultSet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    data['DocumentNo'] = this.documentNo;
    data['ErrorResultSet'] = this.errorResultSet;
    return data;
  }
}

class ShiftListResultSet {
  int? totalRecord;
  List<ShiftListDataList>? dataList;

  ShiftListResultSet({this.totalRecord, this.dataList});

  ShiftListResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = <ShiftListDataList>[];
      json['DataList'].forEach((v) {
        dataList!.add(new ShiftListDataList.fromJson(v));
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

class ShiftListDataList {
  int? requestMID;
  String? statusName;
  String? createdDate;
  int? statusID;
  String? effectiveDate;
  String? regularShift;
  String? ramadanShift;

  ShiftListDataList(
      {this.requestMID,
        this.statusName,
        this.createdDate,
        this.statusID,
        this.effectiveDate,
        this.regularShift,
        this.ramadanShift});

  ShiftListDataList.fromJson(Map<String, dynamic> json) {
    requestMID = json['RequestMID'];
    statusName = json['StatusName'];
    createdDate = json['CreatedDate'];
    statusID = json['StatusID'];
    effectiveDate = json['EffectiveDate'];
    regularShift = json['RegularShift'];
    ramadanShift = json['RamadanShift'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RequestMID'] = this.requestMID;
    data['StatusName'] = this.statusName;
    data['CreatedDate'] = this.createdDate;
    data['StatusID'] = this.statusID;
    data['EffectiveDate'] = this.effectiveDate;
    data['RegularShift'] = this.regularShift;
    data['RamadanShift'] = this.ramadanShift;
    return data;
    return data;
  }
}