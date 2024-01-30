class CompanyJson {
  bool? isSuccess;
  CompanyResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  CompanyJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  CompanyJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new CompanyResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet?.toJson();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class CompanyResultSet {
  String? instanceAPIURL;
  String? instanceFileServerURL;

  CompanyResultSet({this.instanceAPIURL, this.instanceFileServerURL});

  CompanyResultSet.fromJson(Map<String, dynamic> json) {
    instanceAPIURL = json['InstanceAPIURL'];
    instanceFileServerURL = json['InstanceFileServerURL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['InstanceAPIURL'] = this.instanceAPIURL;
    data['InstanceFileServerURL'] = this.instanceFileServerURL;
    return data;
  }
}