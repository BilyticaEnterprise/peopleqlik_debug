import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Approvals/approvals_collector.dart';
import 'package:peopleqlik_debug/src/strings.dart';

import '../../AppConstants/app_constants.dart';

class GetApprovalJson {
  bool? isSuccess;
  ResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetApprovalJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetApprovalJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? ResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsSuccess'] = isSuccess;
    if (resultSet != null) {
      data['ResultSet'] = resultSet!.toJson();
    }
    data['FilePath'] = filePath;
    data['Message'] = message;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}
class ResultSet {
  int? totalRecord;
  List<ApprovalResultSet>? dataList;

  ResultSet({this.totalRecord, this.dataList});

  ResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = List<ApprovalResultSet>.empty(growable: true);
      json['DataList'].forEach((v) {
        ApprovalResultSet ap = ApprovalResultSet.fromJson(v);
        if(ap.screenID == GetVariable.requestScreenId ||ap.screenID == GetVariable.leaveScreenId||ap.screenID == AppConstants.requestEnCashmentScreenID||ap.screenID == AppConstants.requestSeparationScreenID||ap.screenID == AppConstants.requestTimeRegulationScreenID||ap.screenID == AppConstants.requestShiftScreenID||ap.screenID == AppConstants.requestOverTimeScreenID) {
          dataList?.add(ap);
        }
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['TotalRecord'] = totalRecord;
    if (dataList != null) {
      data['DataList'] = dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ApprovalResultSet {
  int? iD;
  int? userID;
  int? hierarchyID;
  int? cultureID;
  dynamic companyCode;
  String? documentNo;
  String? referenceNumber;
  String? documentDate;
  int? screenID;
  String? screenName;
  String? userName;
  int? statusID;
  String? statusName;
  String? orignatorUserName;
  int? rowNumber;

  ApprovalResultSet(
      {this.iD,
        this.userID,
        this.hierarchyID,
        this.cultureID,
        this.companyCode,
        this.documentNo,
        this.referenceNumber,
        this.documentDate,
        this.screenID,
        this.screenName,
        this.userName,
        this.statusID,
        this.statusName,
        this.orignatorUserName,
        this.rowNumber});

  ApprovalResultSet.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userID = json['UserID'];
    hierarchyID = json['HierarchyID'];
    cultureID = json['CultureID'];
    companyCode = json['CompanyCode'];
    documentNo = json['DocumentNo'];
    referenceNumber = json['ReferenceNumber'];
    documentDate = json['DocumentDate'];
    screenID = json['ScreenID'];
    screenName = json['ScreenName'];
    userName = json['UserName'];
    statusID = json['StatusID'];
    statusName = json['StatusName'];
    orignatorUserName = json['OrignatorUserName'];
    rowNumber = json['RowNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['UserID'] = userID;
    data['HierarchyID'] = hierarchyID;
    data['CultureID'] = cultureID;
    data['CompanyCode'] = companyCode;
    data['DocumentNo'] = documentNo;
    data['ReferenceNumber'] = referenceNumber;
    data['DocumentDate'] = documentDate;
    data['ScreenID'] = screenID;
    data['ScreenName'] = screenName;
    data['UserName'] = userName;
    data['StatusID'] = statusID;
    data['StatusName'] = statusName;
    data['OrignatorUserName'] = orignatorUserName;
    data['RowNumber'] = rowNumber;
    return data;
  }
}