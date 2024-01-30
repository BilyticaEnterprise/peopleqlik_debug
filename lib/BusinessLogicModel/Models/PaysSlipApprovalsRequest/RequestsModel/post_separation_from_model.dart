class SaveSeparationRequestJson {
  bool? isSuccess;
  String? message;
  String? errorMessage;

  SaveSeparationRequestJson(
      {this.isSuccess,
        this.message,
        this.errorMessage});

  SaveSeparationRequestJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}