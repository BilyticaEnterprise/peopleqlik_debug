class GetTeamJson {
  bool? isSuccess;
  TeamResultSet? resultSet;
  String? errorMessage;
  String? message;

  GetTeamJson(
      {this.isSuccess,
        this.resultSet,
        this.message,
        this.errorMessage});

  GetTeamJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new TeamResultSet.fromJson(json['ResultSet'])
        : null;
    errorMessage = json['ErrorMessage'];
    message = json['Message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    data['ErrorMessage'] = this.errorMessage;
    data['Message'] = message;
    return data;
  }
}

class TeamResultSet {
  int? totalRecord;
  List<TeamDataList>? dataList;

  TeamResultSet({this.totalRecord, this.dataList});

  TeamResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = <TeamDataList>[];
      json['DataList'].forEach((v) {
        dataList!.add(new TeamDataList.fromJson(v));
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

class TeamDataList {
  dynamic employeeCode;
  dynamic oldEmployeeCode;
  dynamic companyCode;
  String? fullName;
  String? jobTitle;
  String? emailID;
  String? dOB;
  String? mobileNo;
  String? supervisorName;
  String? picture;

  TeamDataList(
      {this.employeeCode,
        this.companyCode,
        this.oldEmployeeCode,
        this.fullName,
        this.jobTitle,
        this.emailID,
        this.dOB,
        this.mobileNo,
        this.supervisorName,
        this.picture});

  TeamDataList.fromJson(Map<String, dynamic> json) {
    employeeCode = json['EmployeeCode'];
    oldEmployeeCode = json['OldEmployeeCode'];
    companyCode = json['CompanyCode'];
    fullName = json['FullName'];
    jobTitle = json['JobTitle'];
    emailID = json['EmailID'];
    dOB = json['DOB'];
    mobileNo = json['MobileNo'];
    supervisorName = json['SupervisorName'];
    picture = json['Picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeCode'] = this.employeeCode;
    data['CompanyCode'] = this.companyCode;
    data['OldEmployeeCode'] = this.oldEmployeeCode;
    data['FullName'] = this.fullName;
    data['JobTitle'] = this.jobTitle;
    data['EmailID'] = this.emailID;
    data['DOB'] = this.dOB;
    data['MobileNo'] = this.mobileNo;
    data['SupervisorName'] = this.supervisorName;
    data['Picture'] = this.picture;
    return data;
  }
}