
class GetOrganizationModel {
  bool? isSuccess;
  dynamic message;
  dynamic errorMessage;
  GetOrganizationResultSet? resultSet;

  GetOrganizationModel(
      {this.isSuccess, this.message, this.errorMessage, this.resultSet});

  GetOrganizationModel.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
    resultSet = json['ResultSet'] != null
        ? new GetOrganizationResultSet.fromJson(json['ResultSet'])
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

class GetOrganizationResultSet {
  OrganizationTeamData? supervisor;
  OrganizationTeamData? employee;
  List<OrganizationTeamData>? team;

  GetOrganizationResultSet({this.supervisor, this.employee, this.team});

  GetOrganizationResultSet.fromJson(Map<String, dynamic> json) {
    supervisor = json['Supervisor'] != null
        ? new OrganizationTeamData.fromJson(json['Supervisor'])
        : null;
    employee = json['Employee'] != null
        ? new OrganizationTeamData.fromJson(json['Employee'])
        : null;
    if (json['Team'] != null) {
      team = <OrganizationTeamData>[];
      json['Team'].forEach((v) {
        team!.add(new OrganizationTeamData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.supervisor != null) {
      data['Supervisor'] = this.supervisor!.toJson();
    }
    if (this.employee != null) {
      data['Employee'] = this.employee!.toJson();
    }
    if (this.team != null) {
      data['Team'] = this.team!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class OrganizationTeamData {
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
  int? noOfReportingEmployee;
  int? noOfLeafLevelEmployee;

  OrganizationTeamData(
      {this.employeeCode,
        this.companyCode,
        this.oldEmployeeCode,
        this.fullName,
        this.jobTitle,
        this.emailID,
        this.dOB,
        this.mobileNo,
        this.supervisorName,
        this.picture,
        this.noOfReportingEmployee,
        this.noOfLeafLevelEmployee
      });

  OrganizationTeamData.fromJson(Map<String, dynamic> json) {
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
    noOfReportingEmployee = json['NoOfReportingEmployee'];
    noOfLeafLevelEmployee = json['NoOfLeafLevelEmployee'];
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
    data['NoOfReportingEmployee'] = noOfReportingEmployee;
    data['NoOfLeafLevelEmployee'] = noOfLeafLevelEmployee;
    return data;
  }
}