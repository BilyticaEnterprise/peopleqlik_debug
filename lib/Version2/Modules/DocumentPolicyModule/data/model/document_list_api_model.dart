import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/data/model/document_model.dart';

class DocumentPolicyListModel {
  bool? isSuccess;
  dynamic message;
  dynamic errorMessage;
  DocumentListResultSet? resultSet;

  DocumentPolicyListModel(
      {this.isSuccess, this.message, this.errorMessage, this.resultSet});

  DocumentPolicyListModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    resultSet = json['ResultSet'] != null
        ? new DocumentListResultSet.fromJson(json['ResultSet'])
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

class DocumentListResultSet {
  int? totalRecord;
  List<ObjDocument>? dataList;

  DocumentListResultSet({this.totalRecord, this.dataList});

  DocumentListResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = <ObjDocument>[];
      json['DataList'].forEach((v) {
        dataList!.add(new ObjDocument.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalRecord'] = this.totalRecord;
    if (this.dataList != null) {
      data['DataList'] = this.dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

