class GetSeparationEmployeeListJson {
  bool? isSuccess;
  GetSeparationEmployeeResultSet? resultSet;
  String? errorMessage;

  GetSeparationEmployeeListJson(
      {this.isSuccess,
        this.resultSet,
        this.errorMessage});

  GetSeparationEmployeeListJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new GetSeparationEmployeeResultSet.fromJson(json['ResultSet'])
        : null;
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet!.toJson();
    }
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class GetSeparationEmployeeResultSet {
  //List<Query>? query;
  SepartionDays? separtionDays;

  GetSeparationEmployeeResultSet({this.separtionDays});

  GetSeparationEmployeeResultSet.fromJson(Map<String, dynamic> json) {
    // if (json['Query'] != null) {
    //   query = <Query>[];
    //   json['Query'].forEach((v) {
    //     query!.add(new Query.fromJson(v));
    //   });
    // }
    separtionDays = json['SepartionDays'] != null
        ? new SepartionDays.fromJson(json['SepartionDays'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.query != null) {
    //   data['Query'] = this.query!.map((v) => v.toJson()).toList();
    // }
    if (this.separtionDays != null) {
      data['SepartionDays'] = this.separtionDays!.toJson();
    }
    return data;
  }
}

class Query {
  dynamic employeeCode;
  dynamic companyCode;
  String? fullName;
  String? jobTitle;
  String? jobCode;

  Query(
      {this.employeeCode,
        this.companyCode,
        this.fullName,
        this.jobTitle,
        this.jobCode});

  Query.fromJson(Map<String, dynamic> json) {
    employeeCode = json['EmployeeCode'];
    companyCode = json['CompanyCode'];
    fullName = json['FullName'];
    jobTitle = json['JobTitle'];
    jobCode = json['JobCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeCode'] = this.employeeCode;
    data['CompanyCode'] = this.companyCode;
    data['FullName'] = this.fullName;
    data['JobTitle'] = this.jobTitle;
    data['JobCode'] = this.jobCode;
    return data;
  }
}

class SepartionDays {
  bool? isMandatoryToServerNoticePeriod;
  double? noticePeriod;

  SepartionDays({this.isMandatoryToServerNoticePeriod, this.noticePeriod});

  SepartionDays.fromJson(Map<String, dynamic> json) {
    isMandatoryToServerNoticePeriod = json['IsMandatoryToServerNoticePeriod'];
    noticePeriod = json['NoticePeriod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsMandatoryToServerNoticePeriod'] =
        this.isMandatoryToServerNoticePeriod;
    data['NoticePeriod'] = this.noticePeriod;
    return data;
  }
}