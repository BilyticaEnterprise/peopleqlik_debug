class SaveSeparationCalendarRequestJson {
  bool? isSuccess;
  String? message;
  String? errorMessage;

  SaveSeparationCalendarRequestJson(
      {this.isSuccess,
        this.errorMessage});

  SaveSeparationCalendarRequestJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}