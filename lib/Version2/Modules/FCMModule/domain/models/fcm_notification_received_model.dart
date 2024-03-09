class NotificationReceivedModel {
  String? notificationType;
  ScreenData? screenData;
  ExtraData? extraData;

  NotificationReceivedModel(
      {this.notificationType, this.screenData, this.extraData});

  NotificationReceivedModel.fromJson(Map<String, dynamic> json) {
    notificationType = json['NotificationType'];
    screenData = json['ScreenData'] != null
        ? new ScreenData.fromJson(json['ScreenData'])
        : null;
    extraData = json['ExtraData'] != null
        ? new ExtraData.fromJson(json['ExtraData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['NotificationType'] = this.notificationType;
    if (this.screenData != null) {
      data['ScreenData'] = this.screenData!.toJson();
    }
    if (this.extraData != null) {
      data['ExtraData'] = this.extraData!.toJson();
    }
    return data;
  }
}

class ScreenData {
  String? screenID;
  String? managerID;

  ScreenData({this.screenID, this.managerID});

  ScreenData.fromJson(Map<String, dynamic> json) {
    screenID = json['ScreenID'];
    managerID = json['ManagerID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ScreenID'] = this.screenID;
    data['ManagerID'] = this.managerID;
    return data;
  }
}

class ExtraData {
  String? documentNo;
  String? companyCode;
  String? requestCode;
  String? statusID;
  String? iD;

  ExtraData({this.documentNo, this.companyCode, this.requestCode, this.statusID, this.iD});

  ExtraData.fromJson(Map<String, dynamic> json) {
    documentNo = json['DocumentNo'];
    companyCode = json['CompanyCode'];
    requestCode = json['RequestCode'];
    statusID = json['StatusID'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentNo'] = this.documentNo;
    data['CompanyCode'] = this.companyCode;
    data['RequestCode'] = this.requestCode;
    data['StatusID'] = statusID;
    data['ID'] = this.iD;
    return data;
  }
}