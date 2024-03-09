class TimeRegulationListModel {
  bool? isSuccess;
  ResultSet? resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;

  TimeRegulationListModel(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo});

  TimeRegulationListModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new ResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    documentNo = json['DocumentNo'];
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
    return data;
  }
}

class ResultSet {
  int? totalRecord;
  List<TimeRegulationDataList>? dataList;

  ResultSet({this.totalRecord, this.dataList});

  ResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = <TimeRegulationDataList>[];
      json['DataList'].forEach((v) {
        dataList!.add(new TimeRegulationDataList.fromJson(v));
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

class TimeRegulationDataList {
  int? requestMID;
  String? requestDate;
  int? typeID;
  int? statusID;
  String? waiveOffStatus;
  String? createdDate;
  String? timeIn;
  String? waiveOffTimeIn;
  String? timeOut;
  String? waiveOffTimeOut;
  int? notiStatusID;
  String? statusName;
  int? entryID;
  int? approvalStatusID;
  int? approvedBy;
  String? waiveOffRemarks;

  TimeRegulationDataList(
      {this.requestMID,
        this.requestDate,
        this.typeID,
        this.statusID,
        this.waiveOffStatus,
        this.createdDate,
        this.timeIn,
        this.waiveOffTimeIn,
        this.timeOut,
        this.waiveOffTimeOut,
        this.notiStatusID,
        this.statusName,
        this.waiveOffRemarks,
        this.entryID,
        this.approvalStatusID,
        this.approvedBy});

  TimeRegulationDataList.fromJson(Map<String, dynamic> json) {
    requestMID = json['RequestMID'];
    requestDate = json['RequestDate'];
    typeID = json['TypeID'];
    statusID = json['StatusID'];
    waiveOffStatus = json['WaiveOffStatus'];
    createdDate = json['CreatedDate'];
    timeIn = json['TimeIn'];
    waiveOffRemarks = json['WaiveOffRemarks'];
    waiveOffTimeIn = json['WaiveOffTimeIn'];
    timeOut = json['TimeOut'];
    waiveOffTimeOut = json['WaiveOffTimeOut'];
    notiStatusID = json['NotiStatusID'];
    statusName = json['StatusName'];
    entryID = json['EntryID'];
    approvalStatusID = json['ApprovalStatusID'];
    approvedBy = json['ApprovedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RequestMID'] = this.requestMID;
    data['RequestDate'] = this.requestDate;
    data['TypeID'] = this.typeID;
    data['WaiveOffRemarks'] = waiveOffRemarks;
    data['StatusID'] = this.statusID;
    data['WaiveOffStatus'] = this.waiveOffStatus;
    data['CreatedDate'] = this.createdDate;
    data['TimeIn'] = this.timeIn;
    data['WaiveOffTimeIn'] = this.waiveOffTimeIn;
    data['TimeOut'] = this.timeOut;
    data['WaiveOffTimeOut'] = this.waiveOffTimeOut;
    data['NotiStatusID'] = this.notiStatusID;
    data['StatusName'] = this.statusName;
    data['EntryID'] = this.entryID;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['ApprovedBy'] = this.approvedBy;
    return data;
  }
}