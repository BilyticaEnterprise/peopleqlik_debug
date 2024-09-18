
class CommonNotificationModel<T> {
  int? notificationType;
  dynamic data;

  CommonNotificationModel({this.notificationType, this.data});

  CommonNotificationModel.fromJson(Map<String, dynamic> json) {
    notificationType = json['NotificationType'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationType'] = this.notificationType;
    data['data'] = this.data;
    return data;
  }
}