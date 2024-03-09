

import '../../utils/enums/attendance_type_enums.dart';

class AttendanceTypesModel
{
  String header;
  String icon;
  int? color;
  bool selected;
  AttendanceTypesEnum attendanceTypesEnum;
  AttendanceTypesModel(this.header,this.color,this.icon,this.selected,this.attendanceTypesEnum);
}
