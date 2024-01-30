import 'package:peopleqlik_debug/src/date_formats.dart';

import '../../Listeners/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../TeamModel/get_team_model.dart';

class OvertimeFilterMapper
{
  List<TeamDataList>? employeeList;
  DateTime? startDate;
  int? typeId;
  DateTime? endDate;

  OvertimeFilterMapper({this.employeeList,this.startDate,this.endDate,this.typeId});

  OvertimeFilterMapper.fromJson(Map<String, dynamic> json) {
    if (json['employeeMapList'] != null) {
      employeeList = List<TeamDataList>.empty(growable: true);
      json['employeeMapList'].forEach((v) {
        employeeList?.add(TeamDataList.fromJson(v));
      });
    }
    if(json['startDate'] != null){
      startDate = GetDateFormats().getMonthDay(json['startDate']);
    }
    if(json['endDate'] != null){
      endDate = GetDateFormats().getMonthDay(json['endDate']);
    }
    typeId = json['typeId'];

  }

  Map<String,dynamic> toJson(){
    final Map<String, dynamic> data = <String, dynamic>{};
    if (employeeList != null) {
      data['employeeMapList'] = employeeList?.map((v) => v.toJson()).toList();
    }
    if(startDate!=null)
      {
        data['startDate'] = GetDateFormats().getMonthDayIntoString(startDate);
      }
    if(endDate!=null)
    {
      data['endDate'] = GetDateFormats().getMonthDayIntoString(endDate);
    }
    data['typeId'] = typeId;
    return data;
  }
}