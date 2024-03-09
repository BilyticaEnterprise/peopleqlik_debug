class GetRequestFormJson {
  bool? isSuccess;
  GetRequestFormResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetRequestFormJson({this.isSuccess, this.resultSet, this.filePath, this.message, this.errorMessage});

  GetRequestFormJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null ? new GetRequestFormResultSet.fromJson(json['ResultSet']) : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet?.toJson();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class GetRequestFormResultSet {
  ReqMaster? reqMaster;
  List<List<ReqDetail>>? reqDetail;

  GetRequestFormResultSet({this.reqMaster, this.reqDetail});

  GetRequestFormResultSet.fromJson(Map<String, dynamic> json) {
    reqMaster = json['ReqMaster'] != null ? new ReqMaster.fromJson(json['ReqMaster']) : null;
    if (json['ReqDetail'] != null) {
      reqDetail = List<List<ReqDetail>>.from(json["ReqDetail"].map((x) => List<ReqDetail>.from(x.map((x) => ReqDetail.fromJson(x)))));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reqMaster != null) {
      data['ReqMaster'] = this.reqMaster?.toJson();
    }
    if (this.reqDetail != null) {
      data['ReqDetail'] =  List<dynamic>.from(reqDetail!.map((x) => List<dynamic>.from(x.map((x) => x.toJson()))));
  }
    return data;
  }
}

class ReqMaster {
  int? iD;
  int? managerID;
  int? cultureID;
  String? requestTitle;
  String? stageCode;
  int? listingModuleID;
  int? listingSubModuleID;
  int? destModuleID;
  int? destScreenID;
  String? fileName;
  bool? active;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  bool? lineManagerApproval;
  String? userRoleCodes;
  // Null admApprovalStageMf;
  // Null admModule;
  // Null admModule1;
  List<AdmRequestManagerDt>? admRequestManagerDt;
  //List<Null> admRequestMf;
  int? trackingState;
  //Null modifiedProperties;

  ReqMaster({this.iD, this.managerID, this.cultureID, this.requestTitle, this.stageCode, this.listingModuleID, this.listingSubModuleID, this.destModuleID, this.destScreenID, this.fileName, this.active, this.createdBy, this.createdDate, this.modifiedBy, this.modifiedDate, this.lineManagerApproval, this.userRoleCodes,
  //  this.admApprovalStageMf, this.admModule, this.admModule1, this.admRequestManagerDt, this.admRequestMf,
    this.trackingState,
  //  this.modifiedProperties
  });

  ReqMaster.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    managerID = json['ManagerID'];
    cultureID = json['CultureID'];
    requestTitle = json['RequestTitle'];
    stageCode = json['StageCode'];
    listingModuleID = json['ListingModuleID'];
    listingSubModuleID = json['ListingSubModuleID'];
    destModuleID = json['DestModuleID'];
    destScreenID = json['DestScreenID'];
    fileName = json['FileName'];
    active = json['Active'];
    createdBy = json['CreatedBy'];
    createdDate = json['CreatedDate'];
    modifiedBy = json['ModifiedBy'];
    modifiedDate = json['ModifiedDate'];
    lineManagerApproval = json['LineManagerApproval'];
    userRoleCodes = json['UserRoleCodes'];
    // admApprovalStageMf = json['adm_approval_stage_mf'];
    // admModule = json['adm_module'];
    // admModule1 = json['adm_module1'];
    if (json['adm_request_manager_dt'] != null) {
      admRequestManagerDt = new List<AdmRequestManagerDt>.empty(growable: true);
      json['adm_request_manager_dt'].forEach((v) { admRequestManagerDt?.add(new AdmRequestManagerDt.fromJson(v)); });
    }
    // if (json['adm_request_mf'] != null) {
    //   admRequestMf = new List<Null>();
    //   json['adm_request_mf'].forEach((v) { admRequestMf.add(new Null.fromJson(v)); });
    // }
    trackingState = json['TrackingState'];
  //  modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ManagerID'] = this.managerID;
    data['CultureID'] = this.cultureID;
    data['RequestTitle'] = this.requestTitle;
    data['StageCode'] = this.stageCode;
    data['ListingModuleID'] = this.listingModuleID;
    data['ListingSubModuleID'] = this.listingSubModuleID;
    data['DestModuleID'] = this.destModuleID;
    data['DestScreenID'] = this.destScreenID;
    data['FileName'] = this.fileName;
    data['Active'] = this.active;
    data['CreatedBy'] = this.createdBy;
    data['CreatedDate'] = this.createdDate;
    data['ModifiedBy'] = this.modifiedBy;
    data['ModifiedDate'] = this.modifiedDate;
    data['LineManagerApproval'] = this.lineManagerApproval;
    data['UserRoleCodes'] = this.userRoleCodes;
    // data['adm_approval_stage_mf'] = this.admApprovalStageMf;
    // data['adm_module'] = this.admModule;
    // data['adm_module1'] = this.admModule1;
    if (this.admRequestManagerDt != null) {
      data['adm_request_manager_dt'] = this.admRequestManagerDt?.map((v) => v.toJson()).toList();
    }
    // if (this.admRequestMf != null) {
    //   data['adm_request_mf'] = this.admRequestMf.map((v) => v.toJson()).toList();
    // }
    data['TrackingState'] = this.trackingState;
   // data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}

class AdmRequestManagerDt {
  int? iD;
  int? managerID;
  int? cultureID;
  String? controlName;
  int? controlTypeID;
  dynamic defaultValue;
  //String? destFieldName;
  String? resultSet;
  bool? isDependent;
  String? dependentParameter;
  String? title;
  bool? isRequired;
  bool? isReadOnly;
  // Null admControlType;
  // List<Null> admRequestValue;
  int? trackingState;
//  Null modifiedProperties;

  AdmRequestManagerDt({this.iD, this.managerID, this.cultureID, this.controlName, this.controlTypeID, this.defaultValue, this.resultSet, this.isDependent, this.dependentParameter, this.isRequired,
  //  this.admControlType, this.admRequestValue,
    this.trackingState,
  //  this.modifiedProperties
  });

  AdmRequestManagerDt.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    managerID = json['ManagerID'];
    cultureID = json['CultureID'];
    controlName = json['ControlName'];
    controlTypeID = json['ControlTypeID'];
    defaultValue = json['DefaultValue'];
    //destFieldName = json['DestFieldName'];
    resultSet = json['ResultSet'];
    title = json['Title'];
    isDependent = json['isDependent'];
    dependentParameter = json['DependentParameter'];
    isRequired = json['isRequired'];
    isReadOnly = json['isReadOnly'];
    // admControlType = json['adm_control_type'];
    // if (json['adm_request_value'] != null) {
    //   admRequestValue = new List<Null>();
    //   json['adm_request_value'].forEach((v) { admRequestValue.add(new Null.fromJson(v)); });
    // }
    trackingState = json['TrackingState'];
  //  modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ManagerID'] = this.managerID;
    data['CultureID'] = this.cultureID;
    data['ControlName'] = this.controlName;
    data['ControlTypeID'] = this.controlTypeID;
    data['DefaultValue'] = this.defaultValue;
    //data['DestFieldName'] = this.destFieldName;
    data['ResultSet'] = this.resultSet;
    data['Title'] = this.title;
    data['isDependent'] = this.isDependent;
    data['DependentParameter'] = this.dependentParameter;
    data['isRequired'] = this.isRequired;
    data['isReadOnly'] = this.isReadOnly;
    // data['adm_control_type'] = this.admControlType;
    // if (this.admRequestValue != null) {
    //   data['adm_request_value'] = this.admRequestValue.map((v) => v.toJson()).toList();
    // }
    data['TrackingState'] = this.trackingState;
   // data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}

class ReqDetail {
  dynamic id;
  dynamic name;

  ReqDetail({
    this.id,
    this.name,
  });

  ReqDetail.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    name = json['Name'];
  }


  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['ID'] = this.id;
  data['Name'] = this.name;
  return data;
}
}