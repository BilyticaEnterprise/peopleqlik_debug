import '../../../src/date_formats.dart';
import '../TeamModel/get_team_model.dart';
import 'overtime_time_range_model.dart';

class OvertimeHourWithEmployeeMapper {
  TeamDataList? teamDataList;
  List<EmployeeDateTimeList>? employeeDateTimeList;
  List<OvertimeTimeRangeResultSet>? apiResultSet;

  OvertimeHourWithEmployeeMapper({this.employeeDateTimeList,this.teamDataList,this.apiResultSet});

  OvertimeHourWithEmployeeMapper.fromJson(Map<String, dynamic> json) {

    teamDataList = json['TeamDataList'] != null
        ? new TeamDataList.fromJson(json['TeamDataList'])
        : null;

    if (json['EmployeeDateTimeList'] != null) {
      employeeDateTimeList = <EmployeeDateTimeList>[];
      json['EmployeeDateTimeList'].forEach((v) {
        employeeDateTimeList!.add(new EmployeeDateTimeList.fromJson(v));
      });
    }
    if (json['ResultSet'] != null) {
      apiResultSet = <OvertimeTimeRangeResultSet>[];
      json['ResultSet'].forEach((v) {
        apiResultSet!.add(OvertimeTimeRangeResultSet.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.employeeDateTimeList != null) {
      data['EmployeeDateTimeList'] =
          this.employeeDateTimeList!.map((v) => v.toJson()).toList();
    }
    if (this.teamDataList != null) {
      data['TeamDataList'] = this.teamDataList!.toJson();
    }
    if (this.apiResultSet != null) {
      data['ResultSet'] = this.apiResultSet!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EmployeeDateTimeList {
  DateTime? date;
  DateTime? selectedDateTime;

  EmployeeDateTimeList({this.date, this.selectedDateTime});

  EmployeeDateTimeList.fromJson(Map<String, dynamic> json) {
    if(json['date'] != null){
      date = GetDateFormats().getMonthDay(json['date']);
    }
    if(json['selectedDateTime'] != null){
      selectedDateTime = GetDateFormats().getMonthDay(json['selectedDateTime']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(date!=null)
    {
      data['date'] = GetDateFormats().getMonthDayIntoString(date);
    }
    if(selectedDateTime!=null)
    {
      data['selectedDateTime'] = GetDateFormats().getMonthDayIntoString(selectedDateTime);
    }
    return data;
  }
}