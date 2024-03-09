import 'package:peopleqlik_debug/Version1/Models/AuthModels/login_model.dart';

class GetSettingsJson {
  bool? isSuccess;
  SettingsResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetSettingsJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetSettingsJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? SettingsResultSet.fromJson(json['ResultSet'])
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

class SettingsResultSet {
  bool? isAdmin;
  HeaderInfo? headerInfo;
  MyProfile? myProfile;
  CompanyInfo? companyInfo;
  LocationInfo? locationInfo;
  List<Languages>? languages;
  List<ApprovalScreen>? approvalScreen;
  List<Keywords>? keywords;
  List<LeaveCalendar>? leaveCalendar;
  PeopleQlik? peopleQlik;
  List<LeaveCalendar>? selectedCompanyLeaveCalendar;
  List<ShiftWorkingHours>? shiftWorkingHours;
  List<OfficePermTypes>? officePermTypes;
  PreviousHoursLimit? previousHoursLimit;
  List<MissingAttScreens>? missingAttScreens;
  List<AllStatus>? allStatus;
  List<CompanyList>? companyList;
  List<ObjOvertimeTypes>? objOvertimeTypes;
  List<WeekDayList>? weekDayList;
  List<RegularShiftlist>? regularShiftlist;
  List<RegularShiftlist>? ramadanShiftlist;
  DeviceRestricModel? deviceRestricModel;
  String? cuttofDate;
  List<AllApprovalTypes>? allApprovalTypesList;


  SettingsResultSet(
      {
        this.isAdmin,
        this.headerInfo,
        this.myProfile,
        this.keywords,
        this.missingAttScreens,
        this.allStatus,
        this.shiftWorkingHours,
        this.selectedCompanyLeaveCalendar,
        this.objOvertimeTypes,
        this.companyList,
        this.officePermTypes,
        this.leaveCalendar,
        this.deviceRestricModel
      });

  SettingsResultSet.fromJson(Map<String, dynamic> json) {
    isAdmin = json['IsAdmin'];
    headerInfo = json['HeaderInfo'] != null
        ? HeaderInfo.fromJson(json['HeaderInfo'])
        : null;
    myProfile = json['MyProfile'] != null
        ? MyProfile.fromJson(json['MyProfile'])
        : null;
    companyInfo = json['CompanyInfo'] != null
        ? CompanyInfo.fromJson(json['CompanyInfo'])
        : null;
    locationInfo = json['LocationInfo'] != null
        ? LocationInfo.fromJson(json['LocationInfo'])
        : null;
    if (json['Languages'] != null) {
      languages = List<Languages>.empty(growable: true);
      json['Languages'].forEach((v) {
        languages?.add(Languages.fromJson(v));
      });
    }
    if (json['ShiftWorkingHours'] != null) {
      shiftWorkingHours = <ShiftWorkingHours>[];
      json['ShiftWorkingHours'].forEach((v) {
        shiftWorkingHours!.add(new ShiftWorkingHours.fromJson(v));
      });
    }
    if (json['SelectedCompanyLeaveCalendar'] != null) {
      selectedCompanyLeaveCalendar = <LeaveCalendar>[];
      json['SelectedCompanyLeaveCalendar'].forEach((v) {
        selectedCompanyLeaveCalendar!
            .add(new LeaveCalendar.fromJson(v));
      });
    }
    if (json['ApprovalScreen'] != null) {
      approvalScreen = List<ApprovalScreen>.empty(growable: true);
      json['ApprovalScreen'].forEach((v) {
        approvalScreen?.add(ApprovalScreen.fromJson(v));
      });
    }
    if (json['Keywords'] != null) {
      keywords = List<Keywords>.empty(growable: true);
      json['Keywords'].forEach((v) {
        keywords?.add(Keywords.fromJson(v));
      });
    }
    if (json['LeaveCalendar'] != null) {
      leaveCalendar = List<LeaveCalendar>.empty(growable: true);
      json['LeaveCalendar'].forEach((v) {
        leaveCalendar?.add(LeaveCalendar.fromJson(v));
      });
    }
    peopleQlik = json['PeopleQlik'] != null
        ? new PeopleQlik.fromJson(json['PeopleQlik'])
        : null;
    previousHoursLimit = json['PreviousHoursLimit'] != null
        ? new PreviousHoursLimit.fromJson(json['PreviousHoursLimit'])
        : null;
    if (json['MissingAttScreens'] != null) {
      missingAttScreens = <MissingAttScreens>[];
      json['MissingAttScreens'].forEach((v) {
        missingAttScreens!.add(new MissingAttScreens.fromJson(v));
      });
    }
    if (json['AllStatus'] != null) {
      allStatus = <AllStatus>[];
      json['AllStatus'].forEach((v) {
        allStatus!.add(new AllStatus.fromJson(v));
      });
    }
    if (json['CompanyList'] != null) {
      companyList = <CompanyList>[];
      json['CompanyList'].forEach((v) {
        companyList!.add(new CompanyList.fromJson(v));
      });
    }
    if (json['ObjOvertimeTypes'] != null) {
      objOvertimeTypes = <ObjOvertimeTypes>[];
      json['ObjOvertimeTypes'].forEach((v) {
        objOvertimeTypes!.add(new ObjOvertimeTypes.fromJson(v));
      });
    }
    cuttofDate = json['CuttofDate'];
    if (json['OfficePermTypes'] != null) {
      officePermTypes = <OfficePermTypes>[];
      json['OfficePermTypes'].forEach((v) {
        officePermTypes!.add(new OfficePermTypes.fromJson(v));
      });
    }
    if (json['RegularShiftlist'] != null) {
      regularShiftlist = <RegularShiftlist>[];
      json['RegularShiftlist'].forEach((v) {
        regularShiftlist!.add(new RegularShiftlist.fromJson(v));
      });
    }
    if (json['WeekDayList'] != null) {
      weekDayList = <WeekDayList>[];
      json['WeekDayList'].forEach((v) {
        weekDayList!.add(new WeekDayList.fromJson(v));
      });
    }
    if (json['RamadanShiftlist'] != null) {
      ramadanShiftlist = <RegularShiftlist>[];
      json['RamadanShiftlist'].forEach((v) {
        ramadanShiftlist!.add(new RegularShiftlist.fromJson(v));
      });
    }
    deviceRestricModel = json['DeviceRestricModel'] != null
        ? new DeviceRestricModel.fromJson(json['DeviceRestricModel'])
        : null;
    if (json['adm_notifications'] != null) {
      allApprovalTypesList = <AllApprovalTypes>[];
      json['adm_notifications'].forEach((v) { allApprovalTypesList!.add(new AllApprovalTypes.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['IsAdmin'] = isAdmin;
    if (headerInfo != null) {
      data['HeaderInfo'] = headerInfo?.toJson();
    }
    if (languages != null) {
      data['Languages'] = languages?.map((v) => v.toJson()).toList();
    }
    if (myProfile != null) {
      data['MyProfile'] = myProfile?.toJson();
    }
    if (this.selectedCompanyLeaveCalendar != null) {
      data['SelectedCompanyLeaveCalendar'] =
          this.selectedCompanyLeaveCalendar!.map((v) => v.toJson()).toList();
    }
    if (companyInfo != null) {
      data['CompanyInfo'] = companyInfo?.toJson();
    }
    if (this.shiftWorkingHours != null) {
      data['ShiftWorkingHours'] =
          this.shiftWorkingHours!.map((v) => v.toJson()).toList();
    }
    if (locationInfo != null) {
      data['LocationInfo'] = locationInfo?.toJson();
    }
    if (approvalScreen != null) {
      data['ApprovalScreen'] =
          approvalScreen?.map((v) => v.toJson()).toList();
    }
    if (keywords != null) {
      data['Keywords'] = keywords?.map((v) => v.toJson()).toList();
    }
    if (leaveCalendar != null) {
      data['LeaveCalendar'] =
          leaveCalendar?.map((v) => v.toJson()).toList();
    }
    if (peopleQlik != null) {
      data['PeopleQlik'] = peopleQlik?.toJson();
    }
    if (this.previousHoursLimit != null) {
      data['PreviousHoursLimit'] = this.previousHoursLimit!.toJson();
    }
    if (this.allStatus != null) {
      data['AllStatus'] = this.allStatus!.map((v) => v.toJson()).toList();
    }
    if (this.missingAttScreens != null) {
      data['MissingAttScreens'] =
          this.missingAttScreens!.map((v) => v.toJson()).toList();
    }
    if (this.companyList != null) {
      data['CompanyList'] = this.companyList!.map((v) => v.toJson()).toList();
    }
    data['CuttofDate'] = this.cuttofDate;
    if (officePermTypes != null) {
      data['OfficePermTypes'] =
          officePermTypes!.map((v) => v.toJson()).toList();
    }
    if (this.objOvertimeTypes != null) {
      data['ObjOvertimeTypes'] =
          this.objOvertimeTypes!.map((v) => v.toJson()).toList();
    }
    if (this.regularShiftlist != null) {
      data['RegularShiftlist'] =
          this.regularShiftlist!.map((v) => v.toJson()).toList();
    }
    if (this.weekDayList != null) {
      data['WeekDayList'] = this.weekDayList!.map((v) => v.toJson()).toList();
    }
    if (this.ramadanShiftlist != null) {
      data['RamadanShiftlist'] =
          this.ramadanShiftlist!.map((v) => v.toJson()).toList();
    }
    if (this.deviceRestricModel != null) {
      data['DeviceRestricModel'] = this.deviceRestricModel!.toJson();
    }
    if (this.allApprovalTypesList != null) {
      data['adm_notifications'] = this.allApprovalTypesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveCalendar {
  dynamic companyCode;
  String? calendarCode;
  String? calendarTitle;
  String? calendarDesc;
  String? effectiveDate;

  LeaveCalendar(
      {this.companyCode,
        this.calendarCode,
        this.calendarTitle,
        this.calendarDesc,
        this.effectiveDate});

  LeaveCalendar.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    calendarCode = json['CalendarCode'];
    calendarTitle = json['CalendarTitle'];
    calendarDesc = json['CalendarDesc'];
    effectiveDate = json['EffectiveDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CompanyCode'] = companyCode;
    data['CalendarCode'] = calendarCode;
    data['CalendarTitle'] = calendarTitle;
    data['CalendarDesc'] = calendarDesc;
    data['EffectiveDate'] = effectiveDate;
    return data;
  }
}

class CompanyInfo {
  dynamic companyCode;
  String? legalName;
  String? displayName;
  String? logo;
  String? address;
  String? website;

  CompanyInfo(
      {this.companyCode,
        this.legalName,
        this.displayName,
        this.logo,
        this.address,
        this.website});

  CompanyInfo.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    legalName = json['LegalName'];
    displayName = json['DisplayName'];
    logo = json['Logo'];
    address = json['Address'];
    website = json['Website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CompanyCode'] = companyCode;
    data['LegalName'] = legalName;
    data['DisplayName'] = displayName;
    data['Logo'] = logo;
    data['Address'] = address;
    data['Website'] = website;
    return data;
  }
}

class LocationInfo {
  int? iD;
  String? location;
  String? address;
  bool? geoTagging;
  bool? geoFence;
  String? latitude;
  String? longitude;
  String? radius;
  bool? manualAttendance;
  bool? attendanceFromQR;
  bool? attendanceFromVoice;
  bool? attendanceFromVideo;
  bool? attendanceFromFace;

  LocationInfo(
      {this.iD,
        this.location,
        this.address,
        this.geoTagging,
        this.geoFence,
        this.latitude,
        this.longitude,
        this.radius,
        this.manualAttendance,
        this.attendanceFromQR,
        this.attendanceFromVoice,
        this.attendanceFromVideo,
        this.attendanceFromFace});

  LocationInfo.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    location = json['Location'];
    address = json['Address'];
    geoTagging = json['GeoTagging'];
    geoFence = json['GeoFence'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    radius = json['Radius'];
    manualAttendance = json['ManualAttendance'];
    attendanceFromQR = json['AttendanceFromQR'];
    attendanceFromVoice = json['AttendanceFromVoice'];
    attendanceFromVideo = json['AttendanceFromVideo'];
    attendanceFromFace = json['AttendanceFromFace'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Location'] = location;
    data['Address'] = address;
    data['GeoTagging'] = geoTagging;
    data['GeoFence'] = geoFence;
    data['Latitude'] = latitude;
    data['Longitude'] = longitude;
    data['Radius'] = radius;
    data['ManualAttendance'] = manualAttendance;
    data['AttendanceFromQR'] = attendanceFromQR;
    data['AttendanceFromVoice'] = attendanceFromVoice;
    data['AttendanceFromVideo'] = attendanceFromVideo;
    data['AttendanceFromFace'] = attendanceFromFace;
    return data;
  }
}
class Languages {
  int? cultureID;
  String? displayName;

  Languages({this.cultureID, this.displayName});

  Languages.fromJson(Map<String, dynamic> json) {
    cultureID = json['CultureID'];
    displayName = json['DisplayName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['CultureID'] = cultureID;
    data['DisplayName'] = displayName;
    return data;
  }
}
class ApprovalScreen {
  int? screenID;
  String? screenName;

  ApprovalScreen({this.screenID, this.screenName});

  ApprovalScreen.fromJson(Map<String, dynamic> json) {
    screenID = json['ScreenID'];
    screenName = json['ScreenName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ScreenID'] = screenID;
    data['ScreenName'] = screenName;
    return data;
  }
}
class Keywords {
  int? screenID;
  String? resourceName;
  String? resourceValue;

  Keywords({this.screenID, this.resourceName, this.resourceValue});

  Keywords.fromJson(Map<String, dynamic> json) {
    screenID = json['ScreenID'];
    resourceName = json['ResourceName'];
    resourceValue = json['ResourceValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ScreenID'] = screenID;
    data['ResourceName'] = resourceName;
    data['ResourceValue'] = resourceValue;
    return data;
  }
}
class PeopleQlik {
  String? question;
  String? answer;

  PeopleQlik({this.question, this.answer});

  PeopleQlik.fromJson(Map<String, dynamic> json) {
    question = json['Question'];
    answer = json['Answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Question'] = question;
    data['Answer'] = answer;
    return data;
  }
}

class OfficePermTypes {
  String? typeName;
  int? typeID;

  OfficePermTypes({this.typeName, this.typeID});

  OfficePermTypes.fromJson(Map<String, dynamic> json) {
    typeName = json['TypeName'];
    typeID = json['TypeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TypeName'] = this.typeName;
    data['TypeID'] = this.typeID;
    return data;
  }
}
class PreviousHoursLimit {
  String? settingIdOrName;
  String? settingIdOrNameValue;

  PreviousHoursLimit({this.settingIdOrName, this.settingIdOrNameValue});

  PreviousHoursLimit.fromJson(Map<String, dynamic> json) {
    settingIdOrName = json['SettingIdOrName'];
    settingIdOrNameValue = json['SettingIdOrNameValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SettingIdOrName'] = this.settingIdOrName;
    data['SettingIdOrNameValue'] = this.settingIdOrNameValue;
    return data;
  }
}

class MissingAttScreens {
  int? screenID;
  int? iD;
  String? screenName;

  MissingAttScreens({this.screenID, this.iD, this.screenName});

  MissingAttScreens.fromJson(Map<String, dynamic> json) {
    screenID = json['ScreenID'];
    iD = json['ID'];
    screenName = json['ScreenName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ScreenID'] = this.screenID;
    data['ID'] = this.iD;
    data['ScreenName'] = this.screenName;
    return data;
  }
}

class AllStatus {
  int? statusID;
  String? statusName;
  String? prefix;

  AllStatus({this.statusID, this.statusName});

  AllStatus.fromJson(Map<String, dynamic> json) {
    statusID = json['StatusID'];
    statusName = json['StatusName'];
    prefix = json['Prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusID'] = this.statusID;
    data['StatusName'] = this.statusName;
    data['Prefix'] = prefix;
    return data;
  }
}
class CompanyList {
  int? companyCode;
  String? displayName;
  String? legalName;

  CompanyList({this.companyCode, this.displayName, this.legalName});

  CompanyList.fromJson(Map<String, dynamic> json) {
    companyCode = json['CompanyCode'];
    displayName = json['DisplayName'];
    legalName = json['LegalName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CompanyCode'] = this.companyCode;
    data['DisplayName'] = this.displayName;
    data['LegalName'] = this.legalName;
    return data;
  }
}
class ObjOvertimeTypes {
  String? typeName;
  int? typeID;

  ObjOvertimeTypes({this.typeName, this.typeID});

  ObjOvertimeTypes.fromJson(Map<String, dynamic> json) {
    typeName = json['TypeName'];
    typeID = json['TypeID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TypeName'] = this.typeName;
    data['TypeID'] = this.typeID;
    return data;
  }
}
class ShiftWorkingHours {
  String? shiftStartTime;
  String? shiftEndTime;
  bool? isOffDay;
  int? totalShiftHours;

  ShiftWorkingHours(
      {this.shiftStartTime,
        this.shiftEndTime,
        this.isOffDay,
        this.totalShiftHours});

  ShiftWorkingHours.fromJson(Map<String, dynamic> json) {
    shiftStartTime = json['ShiftStartTime'];
    shiftEndTime = json['ShiftEndTime'];
    isOffDay = json['IsOffDay'];
    totalShiftHours = json['TotalShiftHours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ShiftStartTime'] = this.shiftStartTime;
    data['ShiftEndTime'] = this.shiftEndTime;
    data['IsOffDay'] = this.isOffDay;
    data['TotalShiftHours'] = this.totalShiftHours;
    return data;
  }
}
class WeekDayList {
  int? iD;
  int? weekDayID;
  int? cultureID;
  String? dayName;

  WeekDayList(
      {this.iD,
        this.weekDayID,
        this.cultureID,
        this.dayName
        });

  WeekDayList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    weekDayID = json['WeekDayID'];
    cultureID = json['CultureID'];
    dayName = json['DayName'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['WeekDayID'] = this.weekDayID;
    data['CultureID'] = this.cultureID;
    data['DayName'] = this.dayName;

    return data;
  }
}

class RegularShiftlist {
  int? shiftID;
  String? shiftCode;
  String? shiftTitle;
  String? shiftDesc;


  RegularShiftlist(
      {this.shiftID,
        this.shiftCode,
        this.shiftTitle,
        this.shiftDesc,
        });

  RegularShiftlist.fromJson(Map<String, dynamic> json) {
    shiftID = json['ShiftID'];
    shiftCode = json['ShiftCode'];
    shiftTitle = json['ShiftTitle'];
    shiftDesc = json['ShiftDesc'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ShiftID'] = this.shiftID;
    data['ShiftCode'] = this.shiftCode;
    data['ShiftTitle'] = this.shiftTitle;
    data['ShiftDesc'] = this.shiftDesc;

    return data;
  }
}

class DeviceRestricModel {
  bool? deviceRestrict;
  int? autoApproval;
  int? noOfDevice;
  List<DeviceList>? deviceList;

  DeviceRestricModel(
      {this.deviceRestrict,
        this.autoApproval,
        this.noOfDevice,
        this.deviceList});

  DeviceRestricModel.fromJson(Map<String, dynamic> json) {
    deviceRestrict = json['DeviceRestrict'];
    autoApproval = json['AutoApproval'];
    noOfDevice = json['NoOfDevice'];
    if (json['DeviceList'] != null) {
      deviceList = <DeviceList>[];
      json['DeviceList'].forEach((v) {
        deviceList!.add(new DeviceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DeviceRestrict'] = this.deviceRestrict;
    data['AutoApproval'] = this.autoApproval;
    data['NoOfDevice'] = this.noOfDevice;
    if (this.deviceList != null) {
      data['DeviceList'] = this.deviceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeviceList {
  int? iD;
  String? deviceID;
  String? name;
  String? deviceType;
  String? systemVersion;
  String? version;
  String? sysName;
  String? brand;
  int? approvalStatusID;
  bool? active;

  DeviceList(
      {this.iD,
        this.deviceID,
        this.name,
        this.deviceType,
        this.systemVersion,
        this.version,
        this.sysName,
        this.approvalStatusID,
        this.active,
        this.brand
      });

  DeviceList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    deviceID = json['DeviceID'];
    name = json['Name'];
    deviceType = json['DeviceType'];
    systemVersion = json['SystemVersion'];
    version = json['Version'];
    sysName = json['SysName'];
    approvalStatusID = json['ApprovalStatusID'];
    active = json['Active'];
    brand = json['Brand'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = iD;
    data['DeviceID'] = deviceID;
    data['Name'] = name;
    data['DeviceType'] = deviceType;
    data['SystemVersion'] = systemVersion;
    data['Version'] = version;
    data['SysName'] = sysName;
    data['ApprovalStatusID'] = approvalStatusID;
    data['Active'] = active;
    data['Brand'] = brand;
    return data;
  }
}


class AllApprovalTypes {
  int? statusID;
  String? statusName;

  AllApprovalTypes({this.statusID, this.statusName});

  AllApprovalTypes.fromJson(Map<String, dynamic> json) {
    statusID = json['StatusID'];
    statusName = json['StatusName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['StatusID'] = this.statusID;
    data['StatusName'] = this.statusName;
    return data;
  }
}