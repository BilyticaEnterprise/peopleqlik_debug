
import 'package:peopleqlik_debug/configs/prints_logs.dart';

class GetApprovalDetailJson {
  bool? isSuccess;
  GetApprovalDetailResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetApprovalDetailJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetApprovalDetailJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? GetApprovalDetailResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsSuccess'] = isSuccess;
    if (resultSet != null) {
      data['ResultSet'] = resultSet?.toJson();
    }
    data['FilePath'] = filePath;
    data['Message'] = message;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}

class GetApprovalDetailResultSet {
  List<LeaveDetail>? leaveDetail;
  // Null approvalRemarks;
  List<ApprovalHistory>? approvalHistory;

  GetApprovalDetailResultSet({
    this.leaveDetail,
    // this.approvalRemarks,
    this.approvalHistory});

  GetApprovalDetailResultSet.fromJson(Map<String, dynamic> json) {
    if (json['LeaveDetail'] != null) {
      leaveDetail = <LeaveDetail>[];
      if(json['LeaveDetail'] is List<dynamic>)
        {
          json['LeaveDetail'].forEach((v) {
            leaveDetail!.add(LeaveDetail.fromJson(v));
          });
        }
    }
    // approvalRemarks = json['ApprovalRemarks'];
    if (json['ApprovalHistory'] != null) {
      approvalHistory = List<ApprovalHistory>.empty(growable: true);
      json['ApprovalHistory'].forEach((v) {
        approvalHistory?.add(ApprovalHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (leaveDetail != null) {
      data['LeaveDetail'] = leaveDetail!.map((v) => v.toJson()).toList();
    }
    // data['ApprovalRemarks'] = approvalRemarks;
    if (approvalHistory != null) {
      data['ApprovalHistory'] =
          approvalHistory?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ApprovalHistory {
  String? documentNo;
  int? hierarchyID;
  String? userName;
  String? company;
  String? modifiedDate;
  String? statusName;
  String? approverName;
  String? approverCompany;
  String? remarks;

  ApprovalHistory(
      {this.documentNo,
        this.hierarchyID,
        this.userName,
        this.company,
        this.modifiedDate,
        this.statusName,
        this.approverName,
        this.approverCompany,
        this.remarks});

  ApprovalHistory.fromJson(Map<String, dynamic> json) {
    documentNo = json['DocumentNo'];
    hierarchyID = json['HierarchyID'];
    userName = json['UserName'];
    company = json['Company'];
    modifiedDate = json['ModifiedDate'];
    statusName = json['StatusName'];
    approverName = json['ApproverName'];
    approverCompany = json['ApproverCompany'];
    remarks = json['Remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['DocumentNo'] = documentNo;
    data['HierarchyID'] = hierarchyID;
    data['UserName'] = userName;
    data['Company'] = company;
    data['ModifiedDate'] = modifiedDate;
    data['StatusName'] = statusName;
    data['ApproverName'] = approverName;
    data['ApproverCompany'] = approverCompany;
    data['Remarks'] = remarks;
    return data;
  }
}
class LeaveDetail {
  String? applicationCode;
  dynamic companyCode;
  int? approvalStatusID;
  dynamic employeeCode;
  String? requestDate;
  String? leaveFrom;
  String? leaveTo;
  double? totalLeaves;
  String? typeTitle;
  String? reasonTitle;
  bool? supportDocRequired;
  bool? advancedSalary;
  bool? airTicket;
  String? eCIName;
  String? eCINumber;
  String? remarks;
  bool? dependentTraveling;
  String? employeeName;
  String? orignatorUserName;

  LeaveDetail(
      {this.applicationCode,
        this.companyCode,
        this.approvalStatusID,
        this.employeeCode,
        this.requestDate,
        this.leaveFrom,
        this.leaveTo,
        this.totalLeaves,
        this.typeTitle,
        this.reasonTitle,
        this.supportDocRequired,
        this.advancedSalary,
        this.airTicket,
        this.eCIName,
        this.eCINumber,
        this.remarks,
        this.dependentTraveling,
        this.employeeName,
        this.orignatorUserName});

  LeaveDetail.fromJson(Map<String, dynamic> json) {
    applicationCode = json['ApplicationCode'];
    companyCode = json['CompanyCode'];
    approvalStatusID = json['ApprovalStatusID'];
    employeeCode = json['EmployeeCode'];
    requestDate = json['RequestDate'];
    leaveFrom = json['LeaveFrom'];
    leaveTo = json['LeaveTo'];
    totalLeaves = json['TotalLeaves'];
    typeTitle = json['TypeTitle'];
    reasonTitle = json['ReasonTitle'];
    supportDocRequired = json['SupportDocRequired'];
    advancedSalary = json['AdvancedSalary'];
    airTicket = json['AirTicket'];
    eCIName = json['ECIName'];
    eCINumber = json['ECINumber'];
    remarks = json['Remarks'];
    dependentTraveling = json['DependentTraveling'];
    employeeName = json['EmployeeName'];
    orignatorUserName = json['OrignatorUserName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ApplicationCode'] = applicationCode;
    data['CompanyCode'] = companyCode;
    data['ApprovalStatusID'] = approvalStatusID;
    data['EmployeeCode'] = employeeCode;
    data['RequestDate'] = requestDate;
    data['LeaveFrom'] = leaveFrom;
    data['LeaveTo'] = leaveTo;
    data['TotalLeaves'] = totalLeaves;
    data['TypeTitle'] = typeTitle;
    data['ReasonTitle'] = reasonTitle;
    data['SupportDocRequired'] = supportDocRequired;
    data['AdvancedSalary'] = advancedSalary;
    data['AirTicket'] = airTicket;
    data['ECIName'] = eCIName;
    data['ECINumber'] = eCINumber;
    data['Remarks'] = remarks;
    data['DependentTraveling'] = dependentTraveling;
    data['EmployeeName'] = employeeName;
    data['OrignatorUserName'] = orignatorUserName;
    return data;
  }
}