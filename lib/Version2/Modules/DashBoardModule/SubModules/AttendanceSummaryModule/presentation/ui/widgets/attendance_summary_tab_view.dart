import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../../../utils/tabs/presentation/ui/simple_tab_view.dart';
import '../../../../../../../../utils/tabs/presentation/ui/tab_bar.dart';
import '../../listener/attendance_summary_tab_listener.dart';

class AttendanceSummaryTabView extends StatefulWidget {
  final Function(int) tabIndexTapped;
  const AttendanceSummaryTabView({required this.tabIndexTapped,super.key});

  @override
  State<AttendanceSummaryTabView> createState() => _AttendanceSummaryTabViewState();
}

class _AttendanceSummaryTabViewState extends State<AttendanceSummaryTabView> with SingleTickerProviderStateMixin{
  @override
  Widget build(BuildContext context) {
    AttendanceSummaryTabListener attendanceSummaryTabListener = BlocProvider.of<AttendanceSummaryTabListener>(context,listen: false);
    attendanceSummaryTabListener.tabController ??= TabController(length: attendanceSummaryTabListener.getProfileOptionList().length, vsync: this);
    return SimpleTabView(
      tabController: attendanceSummaryTabListener.tabController!,
      list: attendanceSummaryTabListener.getProfileOptionList(),
      onTap: widget.tabIndexTapped,
    );
  }
}
