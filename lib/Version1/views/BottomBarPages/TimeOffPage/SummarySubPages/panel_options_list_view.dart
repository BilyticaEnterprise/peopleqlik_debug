import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/SummaryListeners/get_summary_collector.dart';import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/SummaryListeners/leave_calender_model_listener.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

class SummaryOptionsList extends StatefulWidget {
  const SummaryOptionsList({Key? key}) : super(key: key);

  @override
  _SummaryOptionsListState createState() => _SummaryOptionsListState();
}

class _SummaryOptionsListState extends State<SummaryOptionsList> {
  @override
  Widget build(BuildContext context) {

    return Consumer<LeaveCalenderModelListener>(
      builder: (context, data,child) {
        return ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 4.6),ScreenSize(context).heightOnly(1),ScreenSize(context).widthOnly( 4.6),ScreenSize(context).heightOnly( 10)),
                itemBuilder: (context,index){
                  return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20),),
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20),),
                      child: Material(
                        color: const Color(MyColor.colorGrey6),
                        child: InkWell(
                          splashColor: const Color(MyColor.colorGreyPrimary),
                          onTap: (){
                            Provider.of<LeaveCalenderModelListener>(context,listen: false).updateSelected(index);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(ScreenSize(context).heightOnly( 2)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    data.leaveCalenderList[index].calendarCode??'',
                                    style: GetFont.get(
                                        context,
                                        fontSize:1.6,
                                        fontWeight: FontWeight.w400,
                                        color: MyColor.colorBlack
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: ScreenSize(context).heightOnly( 4.0),
                                    width: ScreenSize(context).heightOnly( 4.0),
                                    child: Icon(
                                      data.selectedIndex==index?MdiIcons.circle:
                                      MdiIcons.circleOutline
                                      ,color: Color(
                                        data.selectedIndex==index?MyColor.colorClockOut:
                                        MyColor.colorGrey3),size: ScreenSize(context).heightOnly( 2.6),)
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (context,index){
                  return SizedBox(height: ScreenSize(context).heightOnly( 2),);
                },
                itemCount: data.leaveCalenderList.length

        );
      }
    );
  }
}
