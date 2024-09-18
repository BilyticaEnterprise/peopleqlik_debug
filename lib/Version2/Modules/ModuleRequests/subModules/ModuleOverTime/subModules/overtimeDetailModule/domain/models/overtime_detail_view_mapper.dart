import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeDetailModule/domain/models/overtime_detail_model.dart';

class OvertimeViewModel
{
  List<OvertimeDetailList>? datesList;
  OvertimeDetailList? employeeData;
  int totalMinutes;
  int? approvalStatusID;

  OvertimeViewModel(this.employeeData,this.datesList,this.totalMinutes,this.approvalStatusID);
}