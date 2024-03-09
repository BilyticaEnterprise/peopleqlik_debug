import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/SubModules/AttendanceSummaryModule/presentation/ui/widgets/employee_attendance_summary_widget.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class AttendanceListPageWidget extends StatelessWidget {
  const AttendanceListPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
          key: key,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(6), ScreenSize(context).heightOnly(3), ScreenSize(context).widthOnly(6), ScreenSize(context).heightOnly(16)),
          itemBuilder: (context,index){
            return EmployeeAttendanceSummaryWidget(key: Key('${key.toString()}_$index'),);
          },
          separatorBuilder: (context,index){
            return const DividerByHeight(3);
          },
          itemCount: 6
    );
  }
}
