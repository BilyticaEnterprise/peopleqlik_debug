import 'package:peopleqlik_debug/BusinessLogicModel/Models/AttendanceModel/attendance_model.dart';

class GetDashBoardJson {
  bool? isSuccess;
  List<PostAttendanceResultSet>? resultSet;
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
    if (json['ResultSet'] != null) {
      resultSet = new List<PostAttendanceResultSet>.empty(growable: true);
      json['ResultSet'].forEach((v) {
        resultSet?.add(new PostAttendanceResultSet.fromJson(v));
      });
    }
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet?.map((v) => v.toJson()).toList();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

