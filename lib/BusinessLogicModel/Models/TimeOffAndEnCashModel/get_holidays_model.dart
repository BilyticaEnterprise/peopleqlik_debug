class GetHolidaysJson {
  bool? isSuccess;
  HolidaysResultSet? resultSet;
  String? errorMessage;
  String? message;

  GetHolidaysJson(
      {this.isSuccess,
        this.resultSet,
        this.errorMessage,
        this.message
      });

  GetHolidaysJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new HolidaysResultSet.fromJson(json['ResultSet'])
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

class HolidaysResultSet {
  int? totalRecord;
  List<HolidayDataList>? dataList;

  HolidaysResultSet({this.totalRecord, this.dataList});

  HolidaysResultSet.fromJson(Map<String, dynamic> json) {
    totalRecord = json['TotalRecord'];
    if (json['DataList'] != null) {
      dataList = <HolidayDataList>[];
      json['DataList'].forEach((v) {
        dataList!.add(new HolidayDataList.fromJson(v));
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

class HolidayDataList {
  String? calendarCode;
  String? calendarTitle;
  String? fromDate;
  String? holidayDate;
  String? holidayTitle;
  String? holidayType;

  HolidayDataList(
      {this.calendarCode,
        this.calendarTitle,
        this.fromDate,
        this.holidayDate,
        this.holidayTitle,
        this.holidayType});

  HolidayDataList.fromJson(Map<String, dynamic> json) {
    calendarCode = json['CalendarCode'];
    calendarTitle = json['CalendarTitle'];
    fromDate = json['FromDate'];
    holidayDate = json['HolidayDate'];
    holidayTitle = json['HolidayTitle'];
    holidayType = json['HolidayType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CalendarCode'] = this.calendarCode;
    data['CalendarTitle'] = this.calendarTitle;
    data['FromDate'] = this.fromDate;
    data['HolidayDate'] = this.holidayDate;
    data['HolidayTitle'] = this.holidayTitle;
    data['HolidayType'] = this.holidayType;
    return data;
  }
}