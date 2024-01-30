class PostAttendanceJson {
  bool? isSuccess;
  List<PostAttendanceResultSet>? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  PostAttendanceJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  PostAttendanceJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    if (json['ResultSet'] != null) {
      resultSet = List<PostAttendanceResultSet>.empty(growable: true);
      json['ResultSet'].forEach((v) {
        resultSet?.add(PostAttendanceResultSet.fromJson(v));
      });
    }
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsSuccess'] = isSuccess;
    if (resultSet != null) {
      data['ResultSet'] = resultSet?.map((v) => v.toJson()).toList();
    }
    data['FilePath'] = filePath;
    data['Message'] = message;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}

class PostAttendanceResultSet {
  dynamic employeeCode;
  dynamic companyCode;
  String? companyName;
  String? attendanceDate;
  String? employeeName;
  bool? geoFence;
  String? lastAttendanceTime;
  int? checkStatus;
  String? firstCheckin;
  String? firstCheckOut;
  int? totalMinutes;
  bool? geoTagging;
  String? latitude;
  String? longitude;
  String? radius;
  bool? manualAttendance;
  bool? attendanceFromQR;
  bool? attendanceFromVoice;
  bool? attendanceFromVideo;
  bool? attendanceFromFace;

  PostAttendanceResultSet(
      {this.employeeCode,
        this.companyCode,
        this.companyName,
        this.attendanceDate,
        this.employeeName,
        this.geoFence,
        this.lastAttendanceTime,
        this.checkStatus,
        this.firstCheckin,
        this.firstCheckOut,
        this.totalMinutes,
        this.geoTagging,
        this.latitude,
        this.longitude,
        this.radius,
        this.manualAttendance,
        this.attendanceFromQR,
        this.attendanceFromVoice,
        this.attendanceFromVideo,
        this.attendanceFromFace});

  PostAttendanceResultSet.fromJson(Map<String, dynamic> json) {
    employeeCode = json['EmployeeCode'];
    companyCode = json['CompanyCode'];
    companyName = json['CompanyName'];
    attendanceDate = json['AttendanceDate'];
    employeeName = json['EmployeeName'];
    geoFence = json['GeoFence'];
    lastAttendanceTime = json['LastAttendanceTime'];
    checkStatus = json['CheckStatus'];
    firstCheckin = json['FirstCheckin'];
    firstCheckOut = json['FirstCheckOut'];
    totalMinutes = json['TotalMinutes'];
    geoTagging = json['GeoTagging'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    radius = json['Radius'];
    manualAttendance = json['ManualAttendance'];
    attendanceFromQR = json['AttendanceFromQR'];
    attendanceFromVoice = json['AttendanceFromVoice'];
    attendanceFromVideo = json['AttendanceFromVideo'];
    attendanceFromFace = json['AttendanceFromFace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmployeeCode'] = employeeCode;
    data['CompanyCode'] = companyCode;
    data['CompanyName'] = companyName;
    data['AttendanceDate'] = attendanceDate;
    data['EmployeeName'] = employeeName;
    data['GeoFence'] = geoFence;
    data['LastAttendanceTime'] = lastAttendanceTime;
    data['CheckStatus'] = checkStatus;
    data['FirstCheckin'] = firstCheckin;
    data['FirstCheckOut'] = firstCheckOut;
    data['TotalMinutes'] = totalMinutes;
    data['GeoTagging'] = geoTagging;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['Radius'] = radius;
    data['ManualAttendance'] = manualAttendance;
    data['AttendanceFromQR'] = attendanceFromQR;
    data['AttendanceFromVoice'] = attendanceFromVoice;
    data['AttendanceFromVideo'] = attendanceFromVideo;
    data['AttendanceFromFace'] = attendanceFromFace;
    return data;
  }
}