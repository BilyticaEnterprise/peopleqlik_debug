class AppliedForEmployee {
  String? oldEmployeeCode;
  String? fullName;
  String? picture;

  AppliedForEmployee({this.oldEmployeeCode, this.fullName, this.picture});

  AppliedForEmployee.fromJson(Map<String, dynamic> json) {
    oldEmployeeCode = json['OldEmployeeCode'];
    fullName = json['FullName'];
    picture = json['Picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['OldEmployeeCode'] = this.oldEmployeeCode;
    data['FullName'] = this.fullName;
    data['Picture'] = this.picture;
    return data;
  }
}