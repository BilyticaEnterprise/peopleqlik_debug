import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/GlobalEmployeeSearchUi/employee_search_header.dart';
import 'package:provider/provider.dart';

import '../../../../Version1/viewModel/EmployeeSearchController/employee_search_bottom_sheet_listener.dart';
import '../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../configs/colors.dart';
import '../../../../utils/hide_keyboard.dart';
import '../../../../utils/screen_sizes.dart';
import '../../../../utils/snackbar_design.dart';
import 'package:peopleqlik_debug/utils/BottomSheetUi/bottom_sheet_ui.dart';
import 'employee_search_body.dart';

class EmployeeSearchBottomSheet
{
  show(BuildContext context,Function(EmployeeInfoMapper) onChanged)
  {
    ShowBottomSheet.show(
        context,
        builder: SizedBox(
          height: ScreenSize(context).heightOnly(90),
          child: SafeArea(
            top: false,
            bottom: false,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child:MultiProvider(
                  providers: [
                    ChangeNotifierProvider<EmployeeSearchBottomSheetListener>(create: (_) => EmployeeSearchBottomSheetListener())
                  ],
                  builder: (context, snapshot) {
                    return Scaffold(
                      primary: false,
                      extendBody: false,
                      resizeToAvoidBottomInset: false,
                      extendBodyBehindAppBar: false,
                      backgroundColor: Color(MyColor.colorWhite),
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Color(MyColor.colorWhite),
                        elevation: 0,
                        titleSpacing: 0,
                        toolbarHeight: ScreenSize(context).heightOnly(9),
                        title: HeaderEmployeeSearchBottomSheet(),
                      ),
                      body: EmployeeSearchBody(),
                    );
                  }
                ),
              ),
            ),
          ),
        ),
        callBack: (value){
          if(value!=null&& value is Map<String,dynamic>)
            {
              Provider.of<GlobalSelectedEmployeeController>(context,listen: false).updateSelectedEmployee(value);
              onChanged(Provider.of<GlobalSelectedEmployeeController>(context,listen: false).getEmployee());
            }
        }
    );
  }
}