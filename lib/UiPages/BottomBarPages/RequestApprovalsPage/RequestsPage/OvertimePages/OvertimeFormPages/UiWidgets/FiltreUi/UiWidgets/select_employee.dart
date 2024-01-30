import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/icons.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';

import '../../../../../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../../../../../../BusinessLogicModel/Models/TeamModel/get_team_model.dart';
import '../../../../../../../../../src/divider.dart';
import '../../../../../../../../../src/fonts.dart';
import '../../../../../../../../../src/map_indexed.dart';
import '../../../../../../../../Reuse_LogicalWidgets/add_click.dart';
import '../../../../../../../../Reuse_LogicalWidgets/custom_chips.dart';
import '../../../../../../../GlobalEmployeeSearchUi/MultiEmployeeSelectPages/multi_employee_select_ui.dart';

class SelectEmployeeWidget extends StatelessWidget {
  final List<TeamDataList>? employeeInfoMapperList;
  final int typeId;
  final Function(List<TeamDataList>?) employeeListCallBack;
  const SelectEmployeeWidget({this.employeeInfoMapperList,required this.employeeListCallBack,required this.typeId,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Select Employees',
                      style: GetFont.get(
                          context,
                          fontSize: 2.0,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                      ),
                    ),
                    SizedBox(width: ScreenSize(context).heightOnly( 1),),
                    Text(
                      '${employeeInfoMapperList?.length??0} employees selected',
                      style: GetFont.get(
                          context,
                          fontSize: 1.6,
                          fontWeight: FontWeight.w400,
                          color: MyColor.colorGrey3
                      ),
                    ),
                  ],
                ),
              ),
              AddIconClick(onClick: (){
                /// Calling EmployeeSearch Bottom bar
                MultiEmployeeSearchBottomSheet().show(
                    context,
                        (list){
                      employeeListCallBack(list);
                    },
                    typeId: typeId,
                    previousSelectedList: employeeInfoMapperList);
              },
              ),
            ],
          ),
        ),
        SizedBox(height: ScreenSize(context).heightOnly(2),),
        if(employeeInfoMapperList!=null&&employeeInfoMapperList!.isNotEmpty)...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(4.8)),
            child: Wrap(
                children: mapIndexed(
                    employeeInfoMapperList!,
                        (index, data) => index>5?TextEmployeeChipWidget('${(employeeInfoMapperList?.length??0)-5}+',

                        ):TextEmployeeChipWidget(data.fullName,
                        removeCallBack: (){
                          employeeInfoMapperList?.removeAt(index);
                          employeeListCallBack(employeeInfoMapperList);
                        }
                    )
                ).toList()
            ),
          )
        ]
      ],
    );
  }
}

