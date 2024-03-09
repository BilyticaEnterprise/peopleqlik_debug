import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

import '../../../../../../../../../../Version1/Models/TeamModel/get_team_model.dart';

import '../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../../utils/map_indexed.dart';
import '../../../../../../../../../../utils/Reuse_LogicalWidgets/add_click.dart';
import '../../../../../../../../../../utils/Reuse_LogicalWidgets/custom_chips.dart';
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
                      CallLanguageKeyWords.get(context, LanguageCodes.selectEmployees)??'Select Employees',
                      style: GetFont.get(
                          context,
                          fontSize: 2.0,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                      ),
                    ),
                    SizedBox(width: ScreenSize(context).heightOnly( 1),),
                    Text(
                      '${employeeInfoMapperList?.length??0} ${CallLanguageKeyWords.get(context, LanguageCodes.employeesSelected)}',
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

