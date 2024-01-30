class PostAttendanceMapper {
  dynamic companyCode;
  dynamic employeeCode;
  String? cultureID;
  String? attendanceTime;
  String? remarks;
  bool? isTransfered;
  int? modifiedBy;
  int? createdBy;
  String? iPAddress;
  String? latitude,longitude;
  int? attendanceMode;
  bool? isTransferedEBS;

  PostAttendanceMapper(
      {this.companyCode,
        this.employeeCode,
        this.cultureID,
        this.attendanceTime,
        this.remarks,
        this.isTransfered,
        this.modifiedBy,
        this.createdBy,
        this.iPAddress,
        this.attendanceMode,
        this.isTransferedEBS});

  PostAttendanceMapper.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    employeeCode = json['EmployeeCode'];
    cultureID = json['CultureID'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    attendanceTime = json['AttendanceTime'];
    remarks = json['Remarks'];
    isTransfered = json['isTransfered'];
    modifiedBy = json['ModifiedBy'];
    createdBy = json['CreatedBy'];
    iPAddress = json['IPAddress'];
    attendanceMode = json['AttendanceMode'];
    isTransferedEBS = json['IsTransferedEBS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyCode'] = this.companyCode;
    data['EmployeeCode'] = this.employeeCode;
    data['CultureID'] = this.cultureID;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['AttendanceTime'] = this.attendanceTime;
    data['Remarks'] = this.remarks;
    data['isTransfered'] = this.isTransfered;
    data['ModifiedBy'] = this.modifiedBy;
    data['CreatedBy'] = this.createdBy;
    data['IPAddress'] = this.iPAddress;
    data['AttendanceMode'] = this.attendanceMode;
    data['IsTransferedEBS'] = this.isTransferedEBS;
    return data;
  }
}