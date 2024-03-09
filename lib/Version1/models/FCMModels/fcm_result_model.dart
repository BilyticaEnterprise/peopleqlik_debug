
class FCMResultModel {
  bool? isSuccess;
  String? errorMessage;
  String? message;

  FCMResultModel(
      {this.isSuccess,
        this.errorMessage,
        this.message
      });

  FCMResultModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    errorMessage = json['ErrorMessage'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = isSuccess;
    data['ErrorMessage'] = errorMessage;
    data['Message'] = message;
    return data;
  }
}