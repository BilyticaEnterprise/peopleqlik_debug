import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/sliding_up_panel.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TimeOffPage/SummarySubPages/panel_options_list_view.dart';
import 'package:peopleqlik_debug/utils/UserLocation/user_location_missing.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/ui/DashBoardSubWidgets/widgets/check_in_check_out_widgets/checkin_checkout_panel.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';



class DashBoardPanel extends StatelessWidget {
  final ScrollController? sc;
  final PanelController? panelController;
  const DashBoardPanel(this.sc, this.panelController, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SlidingPanelData>(
      builder: (context,data,child) {
        if(data.currentPage == SliderWidgetEnum.summary) {
          return const SummaryOptionsList();
        }
        else if(data.currentPage == SliderWidgetEnum.permission)
        {
          return UserLocationPermissionMissing();
        }
        else if(data.currentPage == SliderWidgetEnum.checkInTypes
        //    || data.currentPage == SliderWidgetEnum.breakInType
        )
        {
          return const CheckInCheckOutTypes();
        }
        else if(data.currentPage == SliderWidgetEnum.mockLocation)
        {
          return UserMockLocationFailed();
        }
        else
          {
            return Container();
          }
      }
    );
  }
}
