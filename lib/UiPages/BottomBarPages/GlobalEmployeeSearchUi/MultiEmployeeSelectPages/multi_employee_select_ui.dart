import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../BusinessLogicModel/Enums/employee_search_type.dart';
import '../../../../BusinessLogicModel/Listeners/EmployeeSearchController/employee_search_bottom_sheet_listener.dart';
import '../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/OverTimeListeners/overtime_employee_listener.dart';
import '../../../../BusinessLogicModel/Models/TeamModel/get_team_model.dart';
import '../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../src/colors.dart';
import '../../../../src/language_codes.dart';
import '../../../../src/screen_sizes.dart';
import '../../../../src/snackbar_design.dart';
import '../../../Reuse_Widgets/BottomSheetUi/bottom_sheet_ui.dart';
import '../employee_search_header.dart';
import 'multi_employee_search_body.dart';

class MultiEmployeeSearchBottomSheet
{
  show(BuildContext context,Function(List<TeamDataList>) onChanged,{required int typeId,List<TeamDataList>? previousSelectedList})
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
                      ChangeNotifierProvider<EmployeeOverTimeSearchBottomSheetListener>(create: (_) => EmployeeOverTimeSearchBottomSheetListener(typeId,previousSelectedList: previousSelectedList))
                    ],
                    builder: (context, snapshot) {
                      return Scaffold(
                        primary: false,
                        extendBody: false,
                        resizeToAvoidBottomInset: false,
                        extendBodyBehindAppBar: false,
                        backgroundColor: const Color(MyColor.colorWhite),
                        appBar: AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: const Color(MyColor.colorWhite),
                          elevation: 0,
                          titleSpacing: 0,
                          toolbarHeight: ScreenSize(context).heightOnly(9),
                          title: HeaderEmployeeSearchBottomSheet(onDoneTap: (){
                            EmployeeOverTimeSearchBottomSheetListener employee = Provider.of<EmployeeOverTimeSearchBottomSheetListener>(context,listen: false);
                            if(employee.multiEmployee!=null&&employee.multiEmployee!.isNotEmpty)
                            {
                              Navigator.pop(context,employee.getMultiEmployee());
                            }
                            else
                            {
                              SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.searchMustSelect)}');
                            }
                          },),
                        ),
                        body: MultiEmployeeSearchBody(),
                      );
                    }
                ),
              ),
            ),
          ),
        ),
        callBack: (value){
          if(value!=null&& value is Map<dynamic,dynamic>)
          {
            Map<dynamic,dynamic> map = value;
            List<TeamDataList> list = List.empty(growable: true);
            for (var element in map.values) {
              list.add(TeamDataList.fromJson(element));
            }
            onChanged(list);
          }
        }
    );
  }
}