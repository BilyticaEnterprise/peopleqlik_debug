import 'package:peopleqlik_debug/Version1/Models/TimeRegulationModels/time_regulation_approval_detail_model.dart';

import '../ApprovalsModel/get_approvals_detail_model.dart';

class TimeRegulationDetailsModel {
  bool? isSuccess;
  ResultSet? resultSet;
  dynamic filePath;
  dynamic message;
  dynamic errorMessage;
  dynamic documentNo;

  TimeRegulationDetailsModel(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage,
        this.documentNo});

  TimeRegulationDetailsModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new ResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    documentNo = json['DocumentNo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    data['DocumentNo'] = this.documentNo;
    return data;
  }
}

class ResultSet {
  List<TimeRegulationLeaveDetail>? reuestDetail;
  List<ApprovalHistory>? approvalHistory;

  ResultSet({this.reuestDetail, this.approvalHistory});

  ResultSet.fromJson(Map<String, dynamic> json) {
    if (json['ReuestDetail'] != null) {
      reuestDetail = <TimeRegulationLeaveDetail>[];
      json['ReuestDetail'].forEach((v) {
        reuestDetail!.add(new TimeRegulationLeaveDetail.fromJson(v));
      });
    }
    if (json['ApprovalHistory'] != null) {
      approvalHistory = <ApprovalHistory>[];
      json['ApprovalHistory'].forEach((v) {
        approvalHistory!.add(new ApprovalHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.reuestDetail != null) {
      data['ReuestDetail'] = this.reuestDetail!.map((v) => v.toJson()).toList();
    }
    if (this.approvalHistory != null) {
      data['ApprovalHistory'] =
          this.approvalHistory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}