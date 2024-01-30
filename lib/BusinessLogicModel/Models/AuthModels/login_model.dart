class LoginJson {
  bool? isSuccess;
  LoginResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  LoginJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  LoginJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new LoginResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsSuccess'] = isSuccess;
    if (resultSet != null) {
      data['ResultSet'] = resultSet?.toJson();
    }
    data['FilePath'] = filePath;
    data['Message'] = message;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}

class LoginResultSet {
  bool? isAdmin;
  HeaderInfo? headerInfo;
  MyProfile? myProfile;

  LoginResultSet({this.isAdmin, this.headerInfo, this.myProfile});

  LoginResultSet.fromJson(Map<String, dynamic> json) {
    isAdmin = json['IsAdmin'];
    headerInfo = json['HeaderInfo'] != null
        ? HeaderInfo.fromJson(json['HeaderInfo'])
        : null;
    myProfile = json['MyProfile'] != null
        ? MyProfile.fromJson(json['MyProfile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsAdmin'] = isAdmin;
    if (headerInfo != null) {
      data['HeaderInfo'] = headerInfo?.toJson();
    }
    if (myProfile != null) {
      data['MyProfile'] = myProfile?.toJson();
    }
    return data;
  }
}

class HeaderInfo {
  int? isVerified;
  String? authtokenKey;
  String? userName;
  String? expiryDate;
  int? userID;
  int? cultureID;
  int? userCultureID;
  dynamic companyCode;
  String? logo;

  dynamic employeeCode;
  String? defaultCalendar;
  String? picture;
  String? userTheme;
  String? defaultTheme;
  String? defaultDateFormat;
  String? employeeName;
  String? supervisorName;
  String? departmentTitle;
  String? dateOfJoining;
  bool? newPasswordAfterLogin;
  int? typeID;
  String? googleToken;
  String? googleEmailID;
  String? attendanceCode;
  int? sessionOutTime;

  HeaderInfo(
      {this.isVerified,
        this.authtokenKey,
        this.userName,
        this.expiryDate,
        this.userID,
        this.cultureID,
        this.userCultureID,
        this.companyCode,
        this.logo,
        this.attendanceCode,
        this.employeeCode,
        this.defaultCalendar,
        this.picture,
        this.userTheme,
        this.defaultTheme,
        this.defaultDateFormat,
        this.employeeName,
        this.supervisorName,
        this.departmentTitle,
        this.dateOfJoining,
        this.newPasswordAfterLogin,
        this.typeID,
        this.googleToken,
        this.googleEmailID,
        this.sessionOutTime});

  HeaderInfo.fromJson(Map<String, dynamic> json) {
    isVerified = json['IsVerified'];
    authtokenKey = json['authtokenKey'];
    userName = json['UserName'];
    expiryDate = json['expiryDate'];
    userID = json['UserID'];
    cultureID = json['CultureID'];
    userCultureID = json['UserCultureID'];
    companyCode = json['CompanyCode'];
    logo = json['Logo'];
    attendanceCode = json['AttendanceCode'];
    employeeCode = json['EmployeeCode'];
    defaultCalendar = json['DefaultCalendar'];
    picture = json['Picture'];
    userTheme = json['UserTheme'];
    defaultTheme = json['DefaultTheme'];
    defaultDateFormat = json['DefaultDateFormat'];
    employeeName = json['EmployeeName'];
    supervisorName = json['SupervisorName'];
    departmentTitle = json['DepartmentTitle'];
    dateOfJoining = json['DateOfJoining'];
    newPasswordAfterLogin = json['NewPasswordAfterLogin'];
    typeID = json['TypeID'];
    googleToken = json['GoogleToken'];
    googleEmailID = json['GoogleEmailID'];
    sessionOutTime = json['SessionOutTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsVerified'] = isVerified;
    data['authtokenKey'] = authtokenKey;
    data['UserName'] = userName;
    data['expiryDate'] = expiryDate;
    data['UserID'] = userID;
    data['CultureID'] = cultureID;
    data['UserCultureID'] = userCultureID;
    data['CompanyCode'] = companyCode;
    data['Logo'] = logo;
    data['AttendanceCode'] = attendanceCode;
    data['EmployeeCode'] = employeeCode;
    data['DefaultCalendar'] = defaultCalendar;
    data['Picture'] = picture;
    data['UserTheme'] = userTheme;
    data['DefaultTheme'] = defaultTheme;
    data['DefaultDateFormat'] = defaultDateFormat;
    data['EmployeeName'] = employeeName;
    data['SupervisorName'] = supervisorName;
    data['DepartmentTitle'] = departmentTitle;
    data['DateOfJoining'] = dateOfJoining;
    data['NewPasswordAfterLogin'] = newPasswordAfterLogin;
    data['TypeID'] = typeID;
    data['GoogleToken'] = googleToken;
    data['GoogleEmailID'] = googleEmailID;
    data['SessionOutTime'] = sessionOutTime;
    return data;
  }
}

class MyProfile {
  String? employeeName;
  String? picture;
  String? jobTitle;
  String? location;
  String? positions;
  String? educations;
  String? mobile;
  String? phoneNo;
  String? email;
  String? dOB;
  String? dateOfJoining;
  String? policy;
  String? shiftTime;
  String? weekOff;

  MyProfile(
      {this.employeeName,
        this.picture,
        this.jobTitle,
        this.location,
        this.positions,
        this.educations,
        this.mobile,
        this.phoneNo,
        this.email,
        this.dOB,
        this.dateOfJoining,
        this.policy,
        this.shiftTime,
        this.weekOff});

  MyProfile.fromJson(Map<String, dynamic> json) {
    employeeName = json['EmployeeName'];
    picture = json['Picture'];
    jobTitle = json['JobTitle'];
    location = json['Location'];
    positions = json['Positions'];
    educations = json['Educations'];
    mobile = json['Mobile'];
    phoneNo = json['PhoneNo'];
    email = json['Email'];
    dOB = json['DOB'];
    dateOfJoining = json['DateOfJoining'];
    policy = json['Policy'];
    shiftTime = json['ShiftTime'];
    weekOff = json['WeekOff'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EmployeeName'] = employeeName;
    data['Picture'] = picture;
    data['JobTitle'] = jobTitle;
    data['Location'] = location;
    data['Positions'] = positions;
    data['Educations'] = educations;
    data['Mobile'] = mobile;
    data['PhoneNo'] = phoneNo;
    data['Email'] = email;
    data['DOB'] = dOB;
    data['DateOfJoining'] = dateOfJoining;
    data['Policy'] = policy;
    data['ShiftTime'] = shiftTime;
    data['WeekOff'] = weekOff;
    return data;
  }
}