class GetAnnouncementListJson {
  bool? isSuccess;
  GetAnnouncementListResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetAnnouncementListJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetAnnouncementListJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new GetAnnouncementListResultSet.fromJson(json['ResultSet'])
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

class GetAnnouncementListResultSet {
  List<Announcements>? announcements;
  List<Anniversary>? anniversary;
  List<EmployeeOnLeave>? employeeOnLeave;

  GetAnnouncementListResultSet({this.announcements, this.anniversary, this.employeeOnLeave});

  GetAnnouncementListResultSet.fromJson(Map<String, dynamic> json) {
    if (json['Announcements'] != null) {
      announcements = <Announcements>[];
      json['Announcements'].forEach((v) {
        announcements!.add(new Announcements.fromJson(v));
      });
    }
    if (json['Anniversary'] != null) {
      anniversary = <Anniversary>[];
      json['Anniversary'].forEach((v) {
        anniversary!.add(new Anniversary.fromJson(v));
      });
    }
    if (json['EmployeeOnLeave'] != null) {
      employeeOnLeave = <EmployeeOnLeave>[];
      json['EmployeeOnLeave'].forEach((v) {
        employeeOnLeave!.add(new EmployeeOnLeave.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.announcements != null) {
      data['Announcements'] =
          this.announcements!.map((v) => v.toJson()).toList();
    }
    if (this.anniversary != null) {
      data['Anniversary'] = this.anniversary!.map((v) => v.toJson()).toList();
    }
    if (this.employeeOnLeave != null) {
      data['EmployeeOnLeave'] =
          this.employeeOnLeave!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class Announcements {
  String? announcementCode;
  String? announcementTitle;
  String? date;

  Announcements({this.announcementCode, this.announcementTitle, this.date});

  Announcements.fromJson(Map<String, dynamic> json) {
    announcementCode = json['AnnouncementCode'];
    announcementTitle = json['AnnouncementTitle'];
    date = json['Date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AnnouncementCode'] = this.announcementCode;
    data['AnnouncementTitle'] = this.announcementTitle;
    data['Date'] = this.date;
    return data;
  }
}

class Anniversary {
  String? employeeName;
  String? picture;
  String? date;
  String? event;

  Anniversary({this.employeeName, this.picture, this.date, this.event});

  Anniversary.fromJson(Map<String, dynamic> json) {
    employeeName = json['EmployeeName'];
    picture = json['Picture'];
    date = json['Date'];
    event = json['Event'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeName'] = this.employeeName;
    data['Picture'] = this.picture;
    data['Date'] = this.date;
    data['Event'] = this.event;
    return data;
  }
}

class EmployeeOnLeave {
  String? employeeName;
  String? picture;
  String? jobTitle;
  String? location;
  String? leaveDays;
  String? leaveDate;

  EmployeeOnLeave(
      {this.employeeName,
        this.picture,
        this.jobTitle,
        this.location,
        this.leaveDays,
        this.leaveDate});

  EmployeeOnLeave.fromJson(Map<String, dynamic> json) {
    employeeName = json['EmployeeName'];
    picture = json['Picture'];
    jobTitle = json['JobTitle'];
    location = json['Location'];
    leaveDays = json['LeaveDays'];
    leaveDate = json['LeaveDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeName'] = this.employeeName;
    data['Picture'] = this.picture;
    data['JobTitle'] = this.jobTitle;
    data['Location'] = this.location;
    data['LeaveDays'] = this.leaveDays;
    data['LeaveDate'] = this.leaveDate;
    return data;
  }
}