class NotificationPermissionModel {
  bool? isSuccess;
  NotificationPermissionResultSet? resultSet;
  dynamic message;
  dynamic errorMessage;
  dynamic errorResultSet;

  NotificationPermissionModel(
      {this.isSuccess,
        this.resultSet,
        this.message,
        this.errorMessage,
        this.errorResultSet});

  NotificationPermissionModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? NotificationPermissionResultSet.fromJson(json['ResultSet'])
        : null;
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    errorResultSet = json['ErrorResultSet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsSuccess'] = isSuccess;
    if (resultSet != null) {
      data['ResultSet'] = resultSet!.toJson();
    }
    data['Message'] = message;
    data['ErrorMessage'] = errorMessage;
    data['ErrorResultSet'] = errorResultSet;
    return data;
  }
}

class NotificationPermissionResultSet {
  bool? isNotificationPermissionAllow;

  NotificationPermissionResultSet({this.isNotificationPermissionAllow});

  NotificationPermissionResultSet.fromJson(Map<String, dynamic> json) {
    isNotificationPermissionAllow = json['IsNotificationPermissionAllow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsNotificationPermissionAllow'] = isNotificationPermissionAllow;
    return data;
  }
}