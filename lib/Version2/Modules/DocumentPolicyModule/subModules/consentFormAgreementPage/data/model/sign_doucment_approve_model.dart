class DocumentPolicySignedModel {
  String? documentCode;

  DocumentPolicySignedModel({this.documentCode});

  DocumentPolicySignedModel.fromJson(Map<String, dynamic> json) {
    documentCode = json['DocumentCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentCode'] = this.documentCode;
    return data;
  }
}