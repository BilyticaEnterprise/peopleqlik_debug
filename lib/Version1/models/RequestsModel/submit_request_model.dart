class SubmitRequestJson {
  int? requestManagerID;
  dynamic requestCode;
  int? cultureID;
  String? requestDate;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  int? approvalStatusID;
  dynamic companyCode;
  dynamic employeeCode;
  List<AdmRequestValue>? admRequestValue;
  List<AdmRequestFile>? admRequestFile;

  SubmitRequestJson(
      {this.requestManagerID,
        this.requestCode,
        this.cultureID,
        this.requestDate,
        this.createdBy,
        this.createdDate,
        this.modifiedBy,
        this.modifiedDate,
        this.approvalStatusID,
        this.companyCode,
        this.employeeCode,
        this.admRequestValue,
        this.admRequestFile});

  SubmitRequestJson.fromJson(Map<String, dynamic> json) {
    requestManagerID = json['RequestManagerID'];
    requestCode = json['RequestCode'];
    cultureID = json['CultureID'];
    requestDate = json['RequestDate'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedBy = json['ModifiedBy'];
    modifiedDate = json['ModifiedDate'];
    approvalStatusID = json['ApprovalStatusID'];
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    if (json['adm_request_value'] != null) {
      admRequestValue = List<AdmRequestValue>.empty(growable: true);
      json['adm_request_value'].forEach((v) {
        admRequestValue?.add(AdmRequestValue.fromJson(v));
      });
    }
    if (json['adm_request_file'] != null) {
      admRequestFile = List<AdmRequestFile>.empty(growable: true);
      json['adm_request_file'].forEach((v) {
        admRequestFile?.add(AdmRequestFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['RequestManagerID'] = this.requestManagerID;
    data['RequestCode'] = this.requestCode;
    data['CultureID'] = this.cultureID;
    data['RequestDate'] = this.requestDate;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedDate'] = this.modifiedDate;
    data['ApprovalStatusID'] = this.approvalStatusID;
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    if (this.admRequestValue != null) {
      data['adm_request_value'] =
          this.admRequestValue?.map((v) => v.toJson()).toList();
    }
    if (this.admRequestFile != null) {
      data['adm_request_file'] =
          this.admRequestFile?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdmRequestValue {
  int? iD;
  int? requestManagerID;
  dynamic requestCode;
  int? cultureID;
  int? controlID;
  dynamic controlValue;

  AdmRequestValue(
      {this.iD,
        this.requestManagerID,
        this.requestCode,
        this.cultureID,
        this.controlID,
        this.controlValue});

  AdmRequestValue.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    requestManagerID = json['RequestManagerID'];
    requestCode = json['RequestCode'];
    cultureID = json['CultureID'];
    controlID = json['ControlID'];
    controlValue = json['ControlValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['RequestManagerID'] = this.requestManagerID;
    data['RequestCode'] = this.requestCode;
    data['CultureID'] = this.cultureID;
    data['ControlID'] = this.controlID;
    data['ControlValue'] = this.controlValue;
    return data;
  }
}

class AdmRequestFile {
  int? iD;
  int? requestManagerID;
  dynamic requestCode;
  int? cultureID;
  String? fileName;
  String? remarks;

  AdmRequestFile(
      {this.iD,
        this.requestManagerID,
        this.requestCode,
        this.cultureID,
        this.fileName,
        this.remarks});

  AdmRequestFile.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    requestManagerID = json['RequestManagerID'];
    requestCode = json['RequestCode'];
    cultureID = json['CultureID'];
    fileName = json['FileName'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['RequestManagerID'] = this.requestManagerID;
    data['RequestCode'] = this.requestCode;
    data['CultureID'] = this.cultureID;
    data['FileName'] = this.fileName;
    data['Remarks'] = this.remarks;
    return data;
  }
}