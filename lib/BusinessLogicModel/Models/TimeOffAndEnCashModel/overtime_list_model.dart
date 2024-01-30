class OvertimeListModel {
  bool? isSuccess;
  OvertimeListResultSet? resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;
  dynamic errorResultSet;

  OvertimeListModel(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo,
        this.errorResultSet});

  OvertimeListModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? OvertimeListResultSet.fromJson(json['ResultSet'])
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

class OvertimeListResultSet {
  int? totalRecord;
  List<OvertimeListData>? dataList;

  OvertimeListResultSet({this.totalRecord, this.dataList});

  OvertimeListResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = <OvertimeListData>[];
      json['DataList'].forEach((v) {
        dataList!.add(OvertimeListData.fromJson(v));
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

class OvertimeListData {
  int? documentNo;
  String? overtimeType;
  double? overtimeMinutes;
  int? noOfEmploees;
  int? approvalStatusID;
  String? appliedOvt;
  String? requestDate;
  String? status;
  String? minDate;
  String? maxDate;

  OvertimeListData(
      {this.documentNo,
        this.overtimeType,
        this.noOfEmploees,
        this.appliedOvt,
        this.approvalStatusID,
        this.overtimeMinutes,
        this.requestDate,
        this.status,
        this.minDate,
        this.maxDate});

  OvertimeListData.fromJson(Map<String, dynamic> json) {
    documentNo = json['DocumentNo'];
    overtimeType = json['OvertimeType'];
    noOfEmploees = json['NoOfEmploees'];
    overtimeMinutes = json['OvertimeMinutes'];
    appliedOvt = json['AppliedOvt'];
    approvalStatusID = json['ApprovalStatusID'];
    requestDate = json['RequestDate'];
    status = json['Status'];
    minDate = json['MinDate'];
    maxDate = json['MaxDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentNo'] = this.documentNo;
    data['OvertimeType'] = this.overtimeType;
    data['NoOfEmploees'] = this.noOfEmploees;
    data['OvertimeMinutes'] = overtimeMinutes;
    data['ApprovalStatusID'] = approvalStatusID;
    data['AppliedOvt'] = this.appliedOvt;
    data['RequestDate'] = this.requestDate;
    data['Status'] = this.status;
    data['MinDate'] = this.minDate;
    data['MaxDate'] = this.maxDate;
    return data;
  }
}