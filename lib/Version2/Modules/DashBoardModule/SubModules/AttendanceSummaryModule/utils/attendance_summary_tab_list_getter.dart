import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';

import '../../../../../../utils/tabs/domain/model/tab_bar_data.dart';
import '../presentation/ui/widgets/list_page_widget.dart';
import 'attendance_summary_tab_enums.dart';

class AttendanceSummaryOptions
{
  static getOptionList(BuildContext context,List<int> count)
  {
    return [
      TabOptionData(title: '${CallLanguageKeyWords.get(context, AttendanceSummaryTabEnum.onTime.name)??''} (${count[0]})'),
      TabOptionData(title: '${CallLanguageKeyWords.get(context, AttendanceSummaryTabEnum.late.name)??''} (${count[1]})'),
      TabOptionData(title: '${CallLanguageKeyWords.get(context, AttendanceSummaryTabEnum.earlyOut.name)??''} (${count[2]})'),
      TabOptionData(title: '${CallLanguageKeyWords.get(context, AttendanceSummaryTabEnum.missed.name)??''} (${count[3]})'),
      TabOptionData(title: '${CallLanguageKeyWords.get(context, AttendanceSummaryTabEnum.present.name)??''} (${count[4]})'),
      TabOptionData(title: '${CallLanguageKeyWords.get(context, AttendanceSummaryTabEnum.leave.name)??''} (${count[5]})'),
    ];
  }
  static getProfileOptionPages()
  {
    return [
      AttendanceListPageWidget(key: Key('1'),),
      AttendanceListPageWidget(key: Key('2'),),
      AttendanceListPageWidget(key: Key('3'),),
      AttendanceListPageWidget(key: Key('4'),),
      AttendanceListPageWidget(key: Key('5'),),
      AttendanceListPageWidget(key: Key('6'),)
    ];
  }
}