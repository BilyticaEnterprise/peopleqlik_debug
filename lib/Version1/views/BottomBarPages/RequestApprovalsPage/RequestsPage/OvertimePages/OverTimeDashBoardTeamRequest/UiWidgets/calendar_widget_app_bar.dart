import 'package:flutter/material.dart';

import '../../../../../../../../Packages/CalendarWidget/UI/calendar_widget.dart';

class AppBarCalendarWidget extends StatelessWidget {
  final GlobalKey globalKey;
  final Function(dynamic) onDateChange;
  const AppBarCalendarWidget(this.globalKey,{required this.onDateChange,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CalendarWidget(globalKey: globalKey,calendarHeight: 19,onDayPressedDate: onDateChange, getPreviousMonth: () {  }, getNextMonth: () {  }, currentDate: DateTime.now(),monthFormatWeek: true,);
  }
}
