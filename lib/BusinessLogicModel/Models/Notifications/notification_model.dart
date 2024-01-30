class NotificationJson {
  bool? isSuccess;
  List<NotificationResultSet>? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  NotificationJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  NotificationJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    if (json['ResultSet'] != null) {
      resultSet = new List<NotificationResultSet>.empty(growable: true);
      json['ResultSet'].forEach((v) {
        resultSet?.add(new NotificationResultSet.fromJson(v));
      });
    }
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet?.map((v) => v.toJson()).toList();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class NotificationResultSet {
  String? employeeName;
  String? documentNo;
  String? createdDate;
  String? subject;
  int? userID;
  int? typeID;
  bool? isActive;
  bool? isRead;
  String? sentTime;
  int? iD;
  String? body;
  int? screenID;
  String? picture;

  NotificationResultSet(
      {this.employeeName,
        this.documentNo,
        this.createdDate,
        this.subject,
        this.userID,
        this.typeID,
        this.isActive,
        this.isRead,
        this.sentTime,
        this.iD,
        this.body,
        this.screenID,
        this.picture});

  NotificationResultSet.fromJson(Map<String, dynamic> json) {
    employeeName = json['EmployeeName'];
    documentNo = json['DocumentNo'];
    createdDate = json['CreatedDate'];
    subject = json['Subject'];
    userID = json['UserID'];
    typeID = json['TypeID'];
    isActive = json['IsActive'];
    isRead = json['IsRead'];
    sentTime = json['SentTime'];
    iD = json['ID'];
    body = json['Body'];
    screenID = json['ScreenID'];
    picture = json['Picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeName'] = this.employeeName;
    data['DocumentNo'] = this.documentNo;
    data['CreatedDate'] = this.createdDate;
    data['Subject'] = this.subject;
    data['UserID'] = this.userID;
    data['TypeID'] = this.typeID;
    data['IsActive'] = this.isActive;
    data['IsRead'] = this.isRead;
    data['SentTime'] = this.sentTime;
    data['ID'] = this.iD;
    data['Body'] = this.body;
    data['ScreenID'] = this.screenID;
    data['Picture'] = this.picture;
    return data;
  }
}