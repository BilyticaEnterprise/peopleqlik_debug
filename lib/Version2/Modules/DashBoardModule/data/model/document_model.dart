class ObjDocument {
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

  ObjDocument(
      {this.documentTitle,
        this.fileName,
        this.description,
        this.typeID,
        this.documentCode,
        this.companyCode,
        this.acknowledgement,
        this.readAcknowledgement,
        this.acknowledgementBody,
        this.typeName,
        this.canDownload,
        this.createdDate});

  ObjDocument.fromJson(Map<String, dynamic> json) {
    documentTitle = json['DocumentTitle'];
    fileName = json['FileName'];
    description = json['Description'];
    typeID = json['TypeID'];
    documentCode = json['DocumentCode'];
    companyCode = json['CompanyCode'];
    readAcknowledgement = json['ReadAcknowledgement'];
    acknowledgement = json['Acknowledgement'];
    acknowledgementBody = json['AcknowledgementBody'];
    typeName = json['TypeName'];
    canDownload = json['CanDownload'];
    createdDate = json['CreatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DocumentTitle'] = this.documentTitle;
    data['FileName'] = this.fileName;
    data['Description'] = this.description;
    data['TypeID'] = this.typeID;
    data['DocumentCode'] = this.documentCode;
    data['CompanyCode'] = this.companyCode;
    data['ReadAcknowledgement'] = this.readAcknowledgement;
    data['Acknowledgement'] = this.acknowledgement;
    data['AcknowledgementBody'] = this.acknowledgementBody;
    data['TypeName'] = this.typeName;
    data['CanDownload'] = this.canDownload;
    data['CreatedDate'] = this.createdDate;
    return data;
  }
}