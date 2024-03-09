class EmployeeInfoMapper
{
  dynamic companyCode;
  dynamic employeeCode;
  dynamic cultureId;
  dynamic picture;
  String? name;
  String? jobTitle;
  bool? localEmployee;

  EmployeeInfoMapper({this.cultureId,this.companyCode,this.employeeCode,this.picture,this.localEmployee = true,this.name,this.jobTitle});

  EmployeeInfoMapper.fromJson(Map<String, dynamic> json) {
    companyCode = json['companyCode'];
    localEmployee = json['localEmployee'];
    cultureId = json['cultureId'];
    name = json['name'];
    jobTitle = json['jobTitle'];
    employeeCode = json['employeeCode'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyCode'] = companyCode;
    data['jobTitle'] = jobTitle;
    data['name'] = name;
    data['cultureId'] = cultureId;
    data['localEmployee'] = localEmployee;
    data['employeeCode'] = employeeCode;
    data['picture'] = picture;
    return data;
  }

}
