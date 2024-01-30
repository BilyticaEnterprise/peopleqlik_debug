class TimeRegulationMonthlyModel {
  bool? isSuccess;
  ResultSet? resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;

  TimeRegulationMonthlyModel(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo});

  TimeRegulationMonthlyModel.fromJson(Map<String, dynamic> json) {
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
  List<TimeRegulationMonthlyDataList>? dataList;

  ResultSet({this.totalRecord, this.dataList});

  ResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = <TimeRegulationMonthlyDataList>[];
      json['DataList'].forEach((v) {
        dataList!.add(new TimeRegulationMonthlyDataList.fromJson(v));
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

class TimeRegulationMonthlyDataList {
  int? entryID;
  String? attendanceDate;
  String? timeIn;
  String? currentDate;
  String? timeOut;
  int? waiveOff;
  dynamic waiveOffTypeIDs;
  String? statusName;
  List<String>? statusList;
  String? statusId;
  bool? canApplyforthisTransaction;

  TimeRegulationMonthlyDataList(
      {this.entryID,
        this.attendanceDate,
        this.timeIn,
        this.currentDate,
        this.timeOut,
        this.waiveOff,
        this.waiveOffTypeIDs,
        this.statusName,
        this.statusId,
        this.canApplyforthisTransaction});

  TimeRegulationMonthlyDataList.fromJson(Map<String, dynamic> json) {
    entryID = json['EntryID'];
    attendanceDate = json['AttendanceDate'];
    timeIn = json['TimeIn'];
    currentDate = json['CurrentDate'];
    timeOut = json['TimeOut'];
    waiveOff = json['WaiveOff'];
    waiveOffTypeIDs = json['WaiveOffTypeIDs'];
    statusName = json['StatusName'];
    statusId = json['StatusId'];
    canApplyforthisTransaction = json['CanApplyforthisTransaction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EntryID'] = this.entryID;
    data['AttendanceDate'] = this.attendanceDate;
    data['TimeIn'] = this.timeIn;
    data['CurrentDate'] = this.currentDate;
    data['TimeOut'] = this.timeOut;
    data['WaiveOff'] = this.waiveOff;
    data['WaiveOffTypeIDs'] = this.waiveOffTypeIDs;
    data['StatusName'] = this.statusName;
    data['StatusId'] = this.statusId;
    data['CanApplyforthisTransaction'] = this.canApplyforthisTransaction;
    return data;
  }
}