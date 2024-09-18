class SignedOrganizationResponseModel {
  bool? isSuccess;
  dynamic message;
  dynamic errorMessage;

  SignedOrganizationResponseModel(
      {this.isSuccess, this.message, this.errorMessage});

  SignedOrganizationResponseModel.fromJson(Map<String, dynamic> json) {
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