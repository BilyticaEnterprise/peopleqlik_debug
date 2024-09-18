
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/data/model/document_model.dart';

import 'attendance_model.dart';

class GetDashBoardJson {
  bool? isSuccess;
  ResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetDashBoardJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetDashBoardJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new ResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
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
    return data;
  }
}

class ResultSet {
  List<PostAttendanceResultSet>? objAttendance;
  List<ObjLeaveBalance>? objLeaveBalance;
  List<ObjDocument>? objDocument;

  ResultSet({this.objAttendance, this.objLeaveBalance,this.objDocument});

  ResultSet.fromJson(Map<String, dynamic> json) {
    if (json['ObjAttendance'] != null) {
      objAttendance = <PostAttendanceResultSet>[];
      json['ObjAttendance'].forEach((v) {
        objAttendance!.add(new PostAttendanceResultSet.fromJson(v));
      });
    }
    if (json['ObjLeaveBalance'] != null) {
      objLeaveBalance = <ObjLeaveBalance>[];
      json['ObjLeaveBalance'].forEach((v) {
        objLeaveBalance!.add(new ObjLeaveBalance.fromJson(v));
      });
    }
    if (json['ObjDocument'] != null) {
      objDocument = <ObjDocument>[];
      json['ObjDocument'].forEach((v) {
        objDocument!.add(new ObjDocument.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.objAttendance != null) {
      data['ObjAttendance'] =
          this.objAttendance!.map((v) => v.toJson()).toList();
    }
    if (this.objLeaveBalance != null) {
      data['ObjLeaveBalance'] =
          this.objLeaveBalance!.map((v) => v.toJson()).toList();
    }
    if (this.objDocument != null) {
      data['ObjDocument'] = this.objDocument!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class ObjLeaveBalance {
  String? leaveName;
  double? totalBalance;
  double? nETbalance;
  double? availedBalance;
  double? carryOverBalance;
  double? encashedBalance;
  double? policyDeduction;

  ObjLeaveBalance(
      {this.leaveName,
        this.totalBalance,
        this.nETbalance,
        this.availedBalance,
        this.carryOverBalance,
        this.encashedBalance,
        this.policyDeduction});

  ObjLeaveBalance.fromJson(Map<String, dynamic> json) {
    leaveName = json['LeaveName'];
    totalBalance = json['TotalBalance'];
    nETbalance = json['NETbalance'];
    availedBalance = json['AvailedBalance'];
    carryOverBalance = json['CarryOverBalance'];
    encashedBalance = json['EncashedBalance'];
    policyDeduction = json['PolicyDeduction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeaveName'] = this.leaveName;
    data['TotalBalance'] = this.totalBalance;
    data['NETbalance'] = this.nETbalance;
    data['AvailedBalance'] = this.availedBalance;
    data['CarryOverBalance'] = this.carryOverBalance;
    data['EncashedBalance'] = this.encashedBalance;
    data['PolicyDeduction'] = this.policyDeduction;
    return data;
  }
}

