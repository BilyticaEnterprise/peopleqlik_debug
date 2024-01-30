class CancelLeaveJson {
  bool? isSuccess;
  dynamic resultSet;
  String? message;
  String? errorMessage;

  CancelLeaveJson(
      {this.isSuccess,
        this.resultSet,
        this.errorMessage});

  CancelLeaveJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['ResultSet'] = this.resultSet;
    data['Message'] = message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}