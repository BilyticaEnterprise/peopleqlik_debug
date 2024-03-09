import 'error_result_model.dart';

class OverTimeSubmitModel {
  bool? isSuccess;
  dynamic resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;
  ErrorResultSet? errorResultSet;

  OverTimeSubmitModel(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo,
        this.errorResultSet});

  OverTimeSubmitModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'];
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    documentNo = json['DocumentNo'];
    errorResultSet = json['ErrorResultSet'] != null
        ? new ErrorResultSet.fromJson(json['ErrorResultSet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['ResultSet'] = this.resultSet;
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    data['DocumentNo'] = this.documentNo;
    if (this.errorResultSet != null) {
      data['ErrorResultSet'] = this.errorResultSet!.toJson();
    }
    return data;
  }
}