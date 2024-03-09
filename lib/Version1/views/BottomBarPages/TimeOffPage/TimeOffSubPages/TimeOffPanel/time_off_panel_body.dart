import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/time_off_panel_controller.dart';
import 'package:peopleqlik_debug/Version1/viewModel/sliding_up_panel.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TimeOffPage/SummarySubPages/panel_options_list_view.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';


class TimeOffPanel extends StatelessWidget {
  final ScrollController? sc;
  final PanelController? panelController;
  const TimeOffPanel(this.sc, this.panelController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeOffSlidingPanelController>(
        builder: (context,data,child) {
          if(data.currentPage == SliderWidgetEnum.summary) {
            return const SummaryOptionsList();
          }
          // else if(data.currentPage == SliderWidgetEnum.employeeSearch) {
          //   return const SearchEmployeeWidget();
          // }
          else
          {
            return Container();
          }
        }
    );
  }
}
