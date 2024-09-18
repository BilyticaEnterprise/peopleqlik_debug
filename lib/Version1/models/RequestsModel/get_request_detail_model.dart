// import 'package:peopleqlik_debug/Version1/models/ApprovalsModel/get_approvals_detail_model.dart';
// import 'package:peopleqlik_debug/configs/prints_logs.dart';
//
// class GetRequestDetailsJson {
//   bool? isSuccess;
//   ResultSet? resultSet;
//   String? filePath;
//   String? message;
//   String? errorMessage;
//
//   GetRequestDetailsJson(
//       {this.isSuccess,
//         this.resultSet,
//         this.filePath,
//         this.message,
//         this.errorMessage});
//
//   GetRequestDetailsJson.fromJson(Map<String, dynamic> json) {
//     isSuccess = json['IsSuccess'];
//     resultSet = json['ResultSet'] != null
//         ? new ResultSet.fromJson(json['ResultSet'])
//         : null;
//     filePath = json['FilePath'];
//     message = json['Message'];
//     errorMessage = json['ErrorMessage'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['IsSuccess'] = this.isSuccess;
//     if (this.resultSet != null) {
//       data['ResultSet'] = this.resultSet!.toJson();
//     }
//     data['FilePath'] = this.filePath;
//     data['Message'] = this.message;
//     data['ErrorMessage'] = this.errorMessage;
//     return data;
//   }
// }
// class ResultSet {
//   List<GetRequestDetailsResultSet>? lObjRequestResult;
//   List<ApprovalHistory>? lObjApprovalHistory;
//
//   ResultSet({this.lObjRequestResult, this.lObjApprovalHistory});
//
//   ResultSet.fromJson(Map<String, dynamic> json) {
//     if (json['_ObjRequestResult'] != null) {
//       lObjRequestResult = <GetRequestDetailsResultSet>[];
//       json['_ObjRequestResult'].forEach((v) {
//         lObjRequestResult!.add(new GetRequestDetailsResultSet.fromJson(v));
//       });
//     }
//     if (json['_objApprovalHistory'] != null) {
//       lObjApprovalHistory = <ApprovalHistory>[];
//       json['_objApprovalHistory'].forEach((v) {
//         lObjApprovalHistory!.add(new ApprovalHistory.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.lObjRequestResult != null) {
//       data['_ObjRequestResult'] =
//           this.lObjRequestResult!.map((v) => v.toJson()).toList();
//     }
//     if (this.lObjApprovalHistory != null) {
//       data['_objApprovalHistory'] =
//           this.lObjApprovalHistory!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class GetRequestDetailsResultSet {
//   int? iD;
//   int? requestManagerID;
//   String? requestCode;
//   int? cultureID;
//   String? requestDate;
//   int? createdBy;
//   String? createdDate;
//   int? modifiedBy;
//   String? modifiedDate;
//   int? approvalStatusID;
//   dynamic companyCode;
//   dynamic employeeCode;
//   List<AdmRequestFile>? admRequestFile;
//   dynamic admRequestManagerMf;
//   List<AdmRequestValue>? admRequestValue;
//   int? trackingState;
//   dynamic modifiedProperties;
//
//   GetRequestDetailsResultSet(
//       {this.iD,
//         this.requestManagerID,
//         this.requestCode,
//         this.cultureID,
//         this.requestDate,
//         this.createdBy,
//         this.createdDate,
//         this.modifiedBy,
//         this.modifiedDate,
//         this.approvalStatusID,
//         this.companyCode,
//         this.employeeCode,
//         this.admRequestFile,
//         this.admRequestManagerMf,
//         this.admRequestValue,
//         this.trackingState,
//         this.modifiedProperties});
//
//   GetRequestDetailsResultSet.fromJson(Map<String, dynamic> json) {
//     iD = json['ID'];
//     requestManagerID = json['RequestManagerID'];
//     requestCode = json['RequestCode'];
//     cultureID = json['CultureID'];
//     requestDate = json['RequestDate'];
//     createdBy = json['CreatedBy'];
//     createdDate = json['CreatedDate'];
//     modifiedBy = json['ModifiedBy'];
//     modifiedDate = json['ModifiedDate'];
//     approvalStatusID = json['ApprovalStatusID'];
//     companyCode = json['CompanyCode'];
//     employeeCode = json['EmployeeCode'];
//     if (json['adm_request_file'] != null) {
//       admRequestFile = <AdmRequestFile>[];
//       json['adm_request_file'].forEach((v) {
//         admRequestFile!.add(new AdmRequestFile.fromJson(v));
//       });
//     }
//     admRequestManagerMf = json['adm_request_manager_mf'];
//     if (json['adm_request_value'] != null) {
//       admRequestValue = <AdmRequestValue>[];
//       json['adm_request_value'].forEach((v) {
//         admRequestValue!.add(new AdmRequestValue.fromJson(v));
//       });
//     }
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
//     data['RequestDate'] = this.requestDate;
//     data['CreatedBy'] = this.createdBy;
//     data['CreatedDate'] = this.createdDate;
//     data['ModifiedBy'] = this.modifiedBy;
//     data['ModifiedDate'] = this.modifiedDate;
//     data['ApprovalStatusID'] = this.approvalStatusID;
//     data['CompanyCode'] = this.companyCode;
//     data['EmployeeCode'] = this.employeeCode;
//     if (this.admRequestFile != null) {
//       data['adm_request_file'] =
//           this.admRequestFile!.map((v) => v.toJson()).toList();
//     }
//     data['adm_request_manager_mf'] = this.admRequestManagerMf;
//     if (this.admRequestValue != null) {
//       data['adm_request_value'] =
//           this.admRequestValue!.map((v) => v.toJson()).toList();
//     }
//     data['TrackingState'] = this.trackingState;
//     data['ModifiedProperties'] = this.modifiedProperties;
//     return data;
//   }
// }
//
// class AdmRequestFile {
//   int? iD;
//   int? requestManagerID;
//   String? requestCode;
//   int? cultureID;
//   String? fileName;
//   String? remarks;
//   int? trackingState;
//   dynamic modifiedProperties;
//
//   AdmRequestFile(
//       {this.iD,
//         this.requestManagerID,
//         this.requestCode,
//         this.cultureID,
//         this.fileName,
//         this.remarks,
//         this.trackingState,
//         this.modifiedProperties});
//
//   AdmRequestFile.fromJson(Map<String, dynamic> json) {
//     iD = json['ID'];
//     requestManagerID = json['RequestManagerID'];
//     requestCode = json['RequestCode'];
//     cultureID = json['CultureID'];
//     fileName = json['FileName'];
//     remarks = json['Remarks'];
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
//     data['FileName'] = this.fileName;
//     data['Remarks'] = this.remarks;
//     data['TrackingState'] = this.trackingState;
//     data['ModifiedProperties'] = this.modifiedProperties;
//     return data;
//   }
// }
//
// // class AdmRequestValue {
// //   int? iD;
// //   int? requestManagerID;
// //   String? requestCode;
// //   int? cultureID;
// //   int? controlID;
// //   String? controlValue;
// //   List<AdmRequestValue>? admRequestManagerDt;
// //   int? trackingState;
// //   dynamic modifiedProperties;
// //
// //   AdmRequestValue(
// //       {this.iD,
// //         this.requestManagerID,
// //         this.requestCode,
// //         this.cultureID,
// //         this.controlID,
// //         this.controlValue,
// //         this.admRequestManagerDt,
// //         this.trackingState,
// //         this.modifiedProperties});
// //
// //   AdmRequestValue.fromJson(Map<String, dynamic> json) {
// //     iD = json['ID'];
// //     requestManagerID = json['RequestManagerID'];
// //     requestCode = json['RequestCode'];
// //     cultureID = json['CultureID'];
// //     controlID = json['ControlID'];
// //     controlValue = json['ControlValue'];
// //     admRequestManagerDt = json['adm_request_manager_dt'];
// //     trackingState = json['TrackingState'];
// //     modifiedProperties = json['ModifiedProperties'];
// //   }
// //
// //   Map<String, dynamic> toJson() {
// //     final Map<String, dynamic> data = new Map<String, dynamic>();
// //     data['ID'] = this.iD;
// //     data['RequestManagerID'] = this.requestManagerID;
// //     data['RequestCode'] = this.requestCode;
// //     data['CultureID'] = this.cultureID;
// //     data['ControlID'] = this.controlID;
// //     data['ControlValue'] = this.controlValue;
// //     data['adm_request_manager_dt'] = this.admRequestManagerDt;
// //     data['TrackingState'] = this.trackingState;
// //     data['ModifiedProperties'] = this.modifiedProperties;
// //     return data;
// //   }
// // }
// class AdmRequestValue {
//   int? iD;
//   int? requestManagerID;
//   String? requestCode;
//   int? cultureID;
//   int? controlID;
//   String? controlValue;
//   AdmRequestManagerDt? admRequestManagerDt;
//   int? trackingState;
//   //dynamic? modifiedProperties;
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
//       //  this.modifiedProperties
//       });
//
//   AdmRequestValue.fromJson(Map<String, dynamic> json) {
//     PrintLogs.printLogs('lodgsgsdsd $json');
//     iD = json['ID'];
//     requestManagerID = json['RequestManagerID'];
//     requestCode = json['RequestCode'];
//     cultureID = json['CultureID'];
//     controlID = json['ControlID'];
//     controlValue = json['ControlValue'];
//     admRequestManagerDt = json['adm_request_manager_dt'] != null
//         ? new AdmRequestManagerDt.fromJson(json['adm_request_manager_dt'])
//         : null;
//     trackingState = json['TrackingState'];
//     //modifiedProperties = json['ModifiedProperties'];
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
//     // if (this.admRequestManagerDt != null) {
//     //   data['adm_request_manager_dt'] = this.admRequestManagerDt!.toJson();
//     // }
//     data['TrackingState'] = this.trackingState;
//     //data['ModifiedProperties'] = this.modifiedProperties;
//     return data;
//   }
// }
//
// class AdmRequestManagerDt {
//   int? iD;
//   int? managerID;
//   int? cultureID;
//   String? controlName;
//   int? controlTypeID;
//   dynamic defaultValue;
//   dynamic destFieldName;
//   String? resultSet;
//   bool? isDependent;
//   dynamic dependentParameter;
//   bool? isRequired;
//   String? title;
//   int? parameterOrder;
//   bool? isReadOnly;
//   dynamic admControlType;
//   //List<dynamic>? admRequestValue;
//   //dynamic? admRequestManagerMf;
//   int? trackingState;
//   //dynamic? modifiedProperties;
//
//   AdmRequestManagerDt(
//       {this.iD,
//         this.managerID,
//         this.cultureID,
//         this.controlName,
//         this.controlTypeID,
//         this.title,
//         this.defaultValue,
//         this.destFieldName,
//         this.resultSet,
//         this.isDependent,
//         this.dependentParameter,
//         this.isRequired,
//         this.parameterOrder,
//         this.isReadOnly,
//         this.admControlType,
//         // this.admRequestValue,
//         // this.admRequestManagerMf,
//         this.trackingState,
//       //  this.modifiedProperties
//       });
//
//   AdmRequestManagerDt.fromJson(Map<String, dynamic> json) {
//     iD = json['ID'];
//     managerID = json['ManagerID'];
//     cultureID = json['CultureID'];
//     controlName = json['ControlName'];
//     title = json['Title'];
//     controlTypeID = json['ControlTypeID'];
//     defaultValue = json['DefaultValue'];
//     destFieldName = json['DestFieldName'];
//     resultSet = json['ResultSet'];
//     isDependent = json['isDependent'];
//     dependentParameter = json['DependentParameter'];
//     isRequired = json['isRequired'];
//     parameterOrder = json['ParameterOrder'];
//     isReadOnly = json['isReadOnly'];
//     admControlType = json['adm_control_type'];
//     // if (json['adm_request_value'] != null) {
//     //   admRequestValue = <dynamic>[];
//     //   json['adm_request_value'].forEach((v) {
//     //     admRequestValue!.add(new dynamic.fromJson(v));
//     //   });
//     // }
//    // admRequestManagerMf = json['adm_request_manager_mf'];
//     trackingState = json['TrackingState'];
//    // modifiedProperties = json['ModifiedProperties'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['ID'] = this.iD;
//     data['ManagerID'] = this.managerID;
//     data['CultureID'] = this.cultureID;
//     data['ControlName'] = this.controlName;
//     data['ControlTypeID'] = this.controlTypeID;
//     data['Title'] = title;
//     data['DefaultValue'] = this.defaultValue;
//     data['DestFieldName'] = this.destFieldName;
//     data['ResultSet'] = this.resultSet;
//     data['isDependent'] = this.isDependent;
//     data['DependentParameter'] = this.dependentParameter;
//     data['isRequired'] = this.isRequired;
//     data['ParameterOrder'] = this.parameterOrder;
//     data['isReadOnly'] = this.isReadOnly;
//     data['adm_control_type'] = this.admControlType;
//     // if (this.admRequestValue != null) {
//     //   data['adm_request_value'] =
//     //       this.admRequestValue!.map((v) => v.toJson()).toList();
//     // }
//    // data['adm_request_manager_mf'] = this.admRequestManagerMf;
//     data['TrackingState'] = this.trackingState;
//    // data['ModifiedProperties'] = this.modifiedProperties;
//     return data;
//   }
// }