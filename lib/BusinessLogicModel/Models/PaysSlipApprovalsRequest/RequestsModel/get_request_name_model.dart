class GetRequestNamesJson {
  bool? isSuccess;
  List<RequestNamesResultSet>? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetRequestNamesJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetRequestNamesJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    if (json['ResultSet'] != null) {
      resultSet = new List<RequestNamesResultSet>.empty(growable: true);
      json['ResultSet'].forEach((v) {
        resultSet?.add(new RequestNamesResultSet.fromJson(v));
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

class RequestNamesResultSet {
  int? managerID;
  String? requestTitle;
  String? fileName;
  dynamic screenID;
  dynamic extraData;

  RequestNamesResultSet({this.managerID, this.requestTitle, this.fileName, this.extraData});

  RequestNamesResultSet.fromJson(Map<String, dynamic> json) {
    managerID = json['ManagerID'];
    requestTitle = json['RequestTitle'];
    fileName = json['FileName'];
    screenID = json['ScreenID'];
    extraData = json['ExtraData'] != null
        ? new ExtraData.fromJson(json['ExtraData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ManagerID'] = managerID;
    data['RequestTitle'] = requestTitle;
    data['FileName'] = fileName;
    data['ScreenID'] = screenID;
    data['ExtraData'] = extraData;
    if (this.extraData != null) {
      data['ExtraData'] = this.extraData!.toJson();
    }
    return data;

  }
}
class ExtraData {
  String? redirectUrl;
  String? now;

  ExtraData({this.redirectUrl, this.now});

  ExtraData.fromJson(Map<String, dynamic> json) {
    redirectUrl = json['RedirectUrl'];
    now = json['Now'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RedirectUrl'] = this.redirectUrl;
    data['Now'] = this.now;
    return data;
  }
}