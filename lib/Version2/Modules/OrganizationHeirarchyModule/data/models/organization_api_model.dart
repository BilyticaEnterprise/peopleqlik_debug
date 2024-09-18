class OrganizationApiModel {
  int? companyCode;
  int? employeeCode;
  int? departmentCode;

  OrganizationApiModel(
      {this.companyCode, this.employeeCode, this.departmentCode});

  OrganizationApiModel.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    departmentCode = json['DepartmentCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    data['DepartmentCode'] = this.departmentCode;
    return data;
  }
}