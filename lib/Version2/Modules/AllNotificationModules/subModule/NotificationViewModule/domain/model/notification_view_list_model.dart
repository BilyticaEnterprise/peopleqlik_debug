import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/FCMModule/domain/models/common_notification_received_model.dart';

class NotificationViewListModel {
  bool? isSuccess;
  List<NotificationListResultSet>? resultSet;
  dynamic message;
  dynamic errorMessage;

  NotificationViewListModel(
      {
        this.isSuccess,
        this.resultSet,
        this.message,
        this.errorMessage,
      });

  NotificationViewListModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    if (json['ResultSet'] != null) {
      resultSet = <NotificationListResultSet>[];
      json['ResultSet'].forEach((v) {
        resultSet!.add(new NotificationListResultSet.fromJson(v));
      });
    }
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.map((v) => v.toJson()).toList();
    }
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class NotificationListResultSet {
  String? title;
  String? body;
  String? employeeName;
  String? picture;
  int? notificationID;
  String? createdDate;
  bool? isRead;
  CommonNotificationModel? payload;

  NotificationListResultSet(
      {this.title,
        this.body,
        this.employeeName,
        this.picture,
        this.notificationID,
        this.createdDate,
        this.isRead,
        this.payload});

  NotificationListResultSet.fromJson(Map<String, dynamic> json) {
    title = json['Title'];
    body = json['Body'];
    employeeName = json['EmployeeName'];
    picture = json['Picture'];
    notificationID = json['NotificationID'];
    createdDate = json['CreatedDate'];
    isRead = json['IsRead'];
    payload =
    json['payload'] != null ? CommonNotificationModel.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Title'] = this.title;
    data['Body'] = this.body;
    data['EmployeeName'] = this.employeeName;
    data['Picture'] = this.picture;
    data['NotificationID'] = this.notificationID;
    data['CreatedDate'] = this.createdDate;
    data['IsRead'] = this.isRead;
    if (this.payload != null) {
      data['payload'] = this.payload!.toJson();
    }
    return data;
  }
}

class Data {
  int? screenID;
  String? documentNo;
  int? companyCode;

  Data({this.screenID, this.documentNo, this.companyCode});

  Data.fromJson(Map<String, dynamic> json) {
    screenID = json['ScreenID'];
    documentNo = json['DocumentNo'];
    companyCode = json['CompanyCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ScreenID'] = this.screenID;
    data['DocumentNo'] = this.documentNo;
    data['CompanyCode'] = this.companyCode;
    return data;
  }
}