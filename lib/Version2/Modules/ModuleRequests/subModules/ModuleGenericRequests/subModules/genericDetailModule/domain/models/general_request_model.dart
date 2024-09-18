import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/applied_for_employee.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';

class GeneralRequestModel {
  bool? isSuccess;
  dynamic message;
  dynamic errorMessage;
  ResultSet? resultSet;

  GeneralRequestModel(
      {this.isSuccess, this.message, this.errorMessage, this.resultSet});

  GeneralRequestModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    resultSet = json['ResultSet'] != null
        ? new ResultSet.fromJson(json['ResultSet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    return data;
  }
}

class ResultSet {
  ApprovalInfo? approvalInfo;
  Data? data;

  ResultSet({this.approvalInfo, this.data});

  ResultSet.fromJson(Map<String, dynamic> json) {
    approvalInfo = json['ApprovalInfo'] != null
        ? new ApprovalInfo.fromJson(json['ApprovalInfo'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.approvalInfo != null) {
      data['ApprovalInfo'] = this.approvalInfo!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ApprovalInfo {
  int? companyCode;
  String? documentNo;
  int? screenID;
  String? screenName;

  ApprovalInfo(
      {this.companyCode, this.documentNo, this.screenID, this.screenName});

  ApprovalInfo.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    documentNo = json['DocumentNo'];
    screenID = json['ScreenID'];
    screenName = json['ScreenName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyCode'] = this.companyCode;
    data['DocumentNo'] = this.documentNo;
    data['ScreenID'] = this.screenID;
    data['ScreenName'] = this.screenName;
    return data;
  }
}

class Data {
  int? statusID;
  GeneralRequestResult? result;
  List<ApprovalList>? approvalList;

  Data({this.statusID, this.result, this.approvalList});

  Data.fromJson(Map<String, dynamic> json) {
    statusID = json['StatusID'];
    result =
    json['Result'] != null ? new GeneralRequestResult.fromJson(json['Result']) : null;
    if (json['ApprovalList'] != null) {
      approvalList = <ApprovalList>[];
      json['ApprovalList'].forEach((v) {
        approvalList!.add(new ApprovalList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusID'] = this.statusID;
    if (this.result != null) {
      data['Result'] = this.result!.toJson();
    }
    if (this.approvalList != null) {
      data['ApprovalList'] = this.approvalList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GeneralRequestResult {
  GetGeneralRequestDetails? admRequestMf;
  String? oldEmployeeCode;
  AppliedForEmployee? appliedForEmployee;
  // List<AdmRequestValue>? admRequestValue;
  // List<AdmRequestFiles>? admRequestFiles;

  GeneralRequestResult(
      {this.admRequestMf,
        this.oldEmployeeCode,
        this.appliedForEmployee
        // this.admRequestValue,
        // this.admRequestFiles
      });

  GeneralRequestResult.fromJson(Map<String, dynamic> json) {
    admRequestMf = json['adm_request_mf'] != null
        ? new GetGeneralRequestDetails.fromJson(json['adm_request_mf'])
        : null;
    oldEmployeeCode = json['OldEmployeeCode'];
    appliedForEmployee = json['AppliedForEmployee'] != null
        ? new AppliedForEmployee.fromJson(json['AppliedForEmployee'])
        : null;

    // if (json['adm_request_value'] != null) {
    //   admRequestValue = <AdmRequestValue>[];
    //   json['adm_request_value'].forEach((v) {
    //     admRequestValue!.add(new AdmRequestValue.fromJson(v));
    //   });
    // }
    // if (json['adm_request_files'] != null) {
    //   admRequestFiles = <AdmRequestFiles>[];
    //   json['adm_request_files'].forEach((v) {
    //     admRequestFiles!.add(new AdmRequestFiles.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.admRequestMf != null) {
      data['adm_request_mf'] = this.admRequestMf!.toJson();
    }
    data['OldEmployeeCode'] = this.oldEmployeeCode;
    if (this.appliedForEmployee != null) {
      data['AppliedForEmployee'] = this.appliedForEmployee!.toJson();
    }
    // if (this.admRequestValue != null) {
    //   data['adm_request_value'] =
    //       this.admRequestValue!.map((v) => v.toJson()).toList();
    // }
    // if (this.admRequestFiles != null) {
    //   data['adm_request_files'] =
    //       this.admRequestFiles!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class GetGeneralRequestDetails {
  int? iD;
  int? requestManagerID;
  String? requestCode;
  int? cultureID;
  String? requestDate;
  int? createdBy;
  String? createdDate;
  int? modifiedBy;
  String? modifiedDate;
  int? approvalStatusID;
  dynamic companyCode;
  dynamic employeeCode;
  List<AdmRequestFile>? admRequestFile;
  dynamic admRequestManagerMf;
  List<AdmRequestValue>? admRequestValue;
  int? trackingState;
  dynamic modifiedProperties;

  GetGeneralRequestDetails(
      {this.iD,
        this.requestManagerID,
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
        this.admRequestFile,
        this.admRequestManagerMf,
        this.admRequestValue,
        this.trackingState,
        this.modifiedProperties});

  GetGeneralRequestDetails.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
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
    if (json['adm_request_file'] != null) {
      admRequestFile = <AdmRequestFile>[];
      json['adm_request_file'].forEach((v) {
        admRequestFile!.add(new AdmRequestFile.fromJson(v));
      });
    }
    admRequestManagerMf = json['adm_request_manager_mf'];
    if (json['adm_request_value'] != null) {
      admRequestValue = <AdmRequestValue>[];
      json['adm_request_value'].forEach((v) {
        admRequestValue!.add(new AdmRequestValue.fromJson(v));
      });
    }
    trackingState = json['TrackingState'];
    modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
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
    if (this.admRequestFile != null) {
      data['adm_request_file'] =
          this.admRequestFile!.map((v) => v.toJson()).toList();
    }
    data['adm_request_manager_mf'] = this.admRequestManagerMf;
    if (this.admRequestValue != null) {
      data['adm_request_value'] =
          this.admRequestValue!.map((v) => v.toJson()).toList();
    }
    data['TrackingState'] = this.trackingState;
    data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}

class AdmRequestFile {
  int? iD;
  int? requestManagerID;
  String? requestCode;
  int? cultureID;
  String? fileName;
  String? remarks;
  int? trackingState;
  dynamic modifiedProperties;

  AdmRequestFile(
      {this.iD,
        this.requestManagerID,
        this.requestCode,
        this.cultureID,
        this.fileName,
        this.remarks,
        this.trackingState,
        this.modifiedProperties});

  AdmRequestFile.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    requestManagerID = json['RequestManagerID'];
    requestCode = json['RequestCode'];
    cultureID = json['CultureID'];
    fileName = json['FileName'];
    remarks = json['Remarks'];
    trackingState = json['TrackingState'];
    modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['RequestManagerID'] = this.requestManagerID;
    data['RequestCode'] = this.requestCode;
    data['CultureID'] = this.cultureID;
    data['FileName'] = this.fileName;
    data['Remarks'] = this.remarks;
    data['TrackingState'] = this.trackingState;
    data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}

// class AdmRequestValue {
//   int? iD;
//   int? requestManagerID;
//   String? requestCode;
//   int? cultureID;
//   int? controlID;
//   String? controlValue;
//   List<AdmRequestValue>? admRequestManagerDt;
//   int? trackingState;
//   dynamic modifiedProperties;
//
//   AdmRequestValue(
//       {this.iD,
//         this.requestManagerID,
//         this.requestCode,
//         this.cultureID,
//         this.controlID,
//         this.controlValue,
//         this.admRequestManagerDt,
//         this.trackingState,
//         this.modifiedProperties});
//
//   AdmRequestValue.fromJson(Map<String, dynamic> json) {
//     iD = json['ID'];
//     requestManagerID = json['RequestManagerID'];
//     requestCode = json['RequestCode'];
//     cultureID = json['CultureID'];
//     controlID = json['ControlID'];
//     controlValue = json['ControlValue'];
//     admRequestManagerDt = json['adm_request_manager_dt'];
//     trackingState = json['TrackingState'];
//     modifiedProperties = json['ModifiedProperties'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ID'] = this.iD;
//     data['RequestManagerID'] = this.requestManagerID;
//     data['RequestCode'] = this.requestCode;
//     data['CultureID'] = this.cultureID;
//     data['ControlID'] = this.controlID;
//     data['ControlValue'] = this.controlValue;
//     data['adm_request_manager_dt'] = this.admRequestManagerDt;
//     data['TrackingState'] = this.trackingState;
//     data['ModifiedProperties'] = this.modifiedProperties;
//     return data;
//   }
// }
class AdmRequestValue {
  int? iD;
  int? requestManagerID;
  String? requestCode;
  int? cultureID;
  int? controlID;
  String? controlValue;
  AdmRequestManagerDt? admRequestManagerDt;
  int? trackingState;
  //dynamic? modifiedProperties;

  AdmRequestValue(
      {this.iD,
        this.requestManagerID,
        this.requestCode,
        this.cultureID,
        this.controlID,
        this.controlValue,
        this.admRequestManagerDt,
        this.trackingState,
        //  this.modifiedProperties
      });

  AdmRequestValue.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    requestManagerID = json['RequestManagerID'];
    requestCode = json['RequestCode'];
    cultureID = json['CultureID'];
    controlID = json['ControlID'];
    controlValue = json['ControlValue'];
    admRequestManagerDt = json['adm_request_manager_dt'] != null
        ? new AdmRequestManagerDt.fromJson(json['adm_request_manager_dt'])
        : null;
    trackingState = json['TrackingState'];
    //modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['RequestManagerID'] = this.requestManagerID;
    data['RequestCode'] = this.requestCode;
    data['CultureID'] = this.cultureID;
    data['ControlID'] = this.controlID;
    data['ControlValue'] = this.controlValue;
    // if (this.admRequestManagerDt != null) {
    //   data['adm_request_manager_dt'] = this.admRequestManagerDt!.toJson();
    // }
    data['TrackingState'] = this.trackingState;
    //data['ModifiedProperties'] = this.modifiedProperties;
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
  dynamic destFieldName;
  String? resultSet;
  bool? isDependent;
  dynamic dependentParameter;
  bool? isRequired;
  String? title;
  int? parameterOrder;
  bool? isReadOnly;
  dynamic admControlType;
  //List<dynamic>? admRequestValue;
  //dynamic? admRequestManagerMf;
  int? trackingState;
  //dynamic? modifiedProperties;

  AdmRequestManagerDt(
      {this.iD,
        this.managerID,
        this.cultureID,
        this.controlName,
        this.controlTypeID,
        this.title,
        this.defaultValue,
        this.destFieldName,
        this.resultSet,
        this.isDependent,
        this.dependentParameter,
        this.isRequired,
        this.parameterOrder,
        this.isReadOnly,
        this.admControlType,
        // this.admRequestValue,
        // this.admRequestManagerMf,
        this.trackingState,
        //  this.modifiedProperties
      });

  AdmRequestManagerDt.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    managerID = json['ManagerID'];
    cultureID = json['CultureID'];
    controlName = json['ControlName'];
    title = json['Title'];
    controlTypeID = json['ControlTypeID'];
    defaultValue = json['DefaultValue'];
    destFieldName = json['DestFieldName'];
    resultSet = json['ResultSet'];
    isDependent = json['isDependent'];
    dependentParameter = json['DependentParameter'];
    isRequired = json['isRequired'];
    parameterOrder = json['ParameterOrder'];
    isReadOnly = json['isReadOnly'];
    admControlType = json['adm_control_type'];
    // if (json['adm_request_value'] != null) {
    //   admRequestValue = <dynamic>[];
    //   json['adm_request_value'].forEach((v) {
    //     admRequestValue!.add(new dynamic.fromJson(v));
    //   });
    // }
    // admRequestManagerMf = json['adm_request_manager_mf'];
    trackingState = json['TrackingState'];
    // modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ManagerID'] = this.managerID;
    data['CultureID'] = this.cultureID;
    data['ControlName'] = this.controlName;
    data['ControlTypeID'] = this.controlTypeID;
    data['Title'] = title;
    data['DefaultValue'] = this.defaultValue;
    data['DestFieldName'] = this.destFieldName;
    data['ResultSet'] = this.resultSet;
    data['isDependent'] = this.isDependent;
    data['DependentParameter'] = this.dependentParameter;
    data['isRequired'] = this.isRequired;
    data['ParameterOrder'] = this.parameterOrder;
    data['isReadOnly'] = this.isReadOnly;
    data['adm_control_type'] = this.admControlType;
    // if (this.admRequestValue != null) {
    //   data['adm_request_value'] =
    //       this.admRequestValue!.map((v) => v.toJson()).toList();
    // }
    // data['adm_request_manager_mf'] = this.admRequestManagerMf;
    data['TrackingState'] = this.trackingState;
    // data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}