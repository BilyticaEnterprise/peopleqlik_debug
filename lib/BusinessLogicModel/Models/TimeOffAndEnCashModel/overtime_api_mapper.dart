class OvertimeApiMapper {
  List<int>? employeeCodes;
  String? fromDate;
  String? toDate;
  int? overtimeType;

  OvertimeApiMapper(
      {this.employeeCodes, this.fromDate, this.toDate, this.overtimeType});

  OvertimeApiMapper.fromJson(Map<String, dynamic> json) {
    employeeCodes = json['EmployeeCodes'].cast<int>();
    fromDate = json['FromDate'];
    toDate = json['ToDate'];
    overtimeType = json['OvertimeType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EmployeeCodes'] = this.employeeCodes;
    data['FromDate'] = this.fromDate;
    data['ToDate'] = this.toDate;
    data['OvertimeType'] = this.overtimeType;
    return data;
  }
}