class ApprovalRequestCommonModel {
  int? companyCode;
  String? documentNo;
  int? screenID;

  ApprovalRequestCommonModel({this.companyCode, this.documentNo, this.screenID});

  ApprovalRequestCommonModel.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    documentNo = json['DocumentNo'];
    screenID = json['ScreenID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyCode'] = this.companyCode;
    data['DocumentNo'] = this.documentNo;
    data['ScreenID'] = this.screenID;
    return data;
  }
}