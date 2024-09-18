class DocumentPolicyDetailModel {
  String? documentTitle;
  String? fileName;
  String? description;
  int? typeID;
  String? documentCode;
  int? companyCode;
  bool? readAcknowledgement;
  bool? acknowledgement;
  String? acknowledgementBody;
  String? typeName;
  bool? canDownload;
  String? createdDate;


  DocumentPolicyDetailModel(
      {this.documentTitle,
        this.fileName,
        this.description,
        this.typeID,
        this.acknowledgement,
        this.documentCode,
        this.companyCode,
        this.readAcknowledgement,
        this.acknowledgementBody,
        this.typeName,
        this.canDownload,
        this.createdDate});

  DocumentPolicyDetailModel.fromJson(Map<String, dynamic> json) {
    documentTitle = json['DocumentTitle'];
    fileName = json['FileName'];
    acknowledgement = json['Acknowledgement'];
    description = json['Description'];
    typeID = json['TypeID'];
    documentCode = json['DocumentCode'];
    companyCode = json['CompanyCode'];
    readAcknowledgement = json['ReadAcknowledgement'];
    acknowledgementBody = json['AcknowledgementBody'];
    typeName = json['TypeName'];
    canDownload = json['CanDownload'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentTitle'] = this.documentTitle;
    data['FileName'] = this.fileName;
    data['Acknowledgement'] = this.acknowledgement;
    data['Description'] = this.description;
    data['TypeID'] = this.typeID;
    data['DocumentCode'] = this.documentCode;
    data['CompanyCode'] = this.companyCode;
    data['ReadAcknowledgement'] = this.readAcknowledgement;
    data['AcknowledgementBody'] = this.acknowledgementBody;
    data['TypeName'] = this.typeName;
    data['CanDownload'] = this.canDownload;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}