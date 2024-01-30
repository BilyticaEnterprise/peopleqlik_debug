import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/overtime_team_model.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/OverTimeDashBoardTeamRequest/UiWidgets/start_end_widget.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:provider/provider.dart';

import '../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/OverTimeListeners/overtime_team_list_listener.dart';
import '../../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../../src/colors.dart';
import '../../../../../../../src/divider.dart';
import '../../../../../../../src/fonts.dart';
import '../../../../../../../src/language_codes.dart';
import '../../../../../../../src/screen_sizes.dart';
import '../../../../../../Reuse_LogicalWidgets/approve_reject_pending_text_widget.dart';
import '../../../../../../Reuse_LogicalWidgets/skeleton_list_widget.dart';
import '../../../../../../Reuse_Widgets/Containers/container_design_1.dart';
import '../../../../../../Reuse_Widgets/dividers.dart';

class OverTimeListWidget extends StatelessWidget {
  final int index;
  final OvertimeTeamListDataList? dataList;
  const OverTimeListWidget(this.index, this.dataList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerDesign1(
      key: Key('OverTimeList$index'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${CallLanguageKeyWords.get(context, LanguageCodes.employeeCode)}, ${dataList?.employeeCode}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorGrey3
                  ),
                ),
              ),
              ApproveRejectPendingTextWidget(id: dataList?.approvalStatusID??0,text: dataList?.status??'',),
            ],
          ),
          SizedBox(height: ScreenSize(context).heightOnly( 0.3),),
          Text(
            '${CallLanguageKeyWords.get(context, LanguageCodes.by)}, ${dataList?.name}',
            style: GetFont.get(
                context,
                fontSize: 2.0,
                fontWeight: FontWeight.w600,
                color: MyColor.colorBlack
            ),
          ),
          const DividerByHeight(0.6),
          RichText(
            text: TextSpan(
              text: '${dataList?.overtimeType??''} ',
              style: GetFont.get(
                  context,
                  fontSize: 1.8,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorPrimary
              ),
              children: [
                TextSpan(
                  text: '${CallLanguageKeyWords.get(context, LanguageCodes.overtimeFor)}, ',
                  style: GetFont.get(
                        context,
                        fontSize: 1.8,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorPrimary
                    ),
                ),
                TextSpan(
                  text: '${GetDateFormats().getTimeWithDuration(context,(dataList?.overtimeMinutes??0).toInt())}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.8,
                      fontWeight: FontWeight.w600,
                      color: MyColor.colorBlack
                  ),

                )
              ]
            ),
          ),
          const DividerByHeight(1.5),
          Row(
            children: [
              Text(
                '${CallLanguageKeyWords.get(context, LanguageCodes.shift)}:  ',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.5,
                    color: MyColor.colorBlack
                ),
              ),
              Text(
                '${GetDateFormats().getFilterTime2(dataList?.shiftStartTime)}',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.5,
                    color: MyColor.colorBlack
                ),
              ),
              const DividerHorizontal(2),
              const StartEndWidget(width: 20,size: 1.0,),
              const DividerHorizontal(2),
              Text(
                '${GetDateFormats().getFilterTime2(dataList?.shiftEndTime)}',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.5,
                    color: MyColor.colorBlack
                ),
              ),
            ],
          ),

          DividerVertical(2),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${CallLanguageKeyWords.get(context, LanguageCodes.appliedOn)} ${GetDateFormats().getFilterDate(dataList?.appliedDate)}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.4,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorBlack
                  ),
                ),
              ),
              // ClipRRect(
              //   borderRadius: const BorderRadius.all(Radius.circular(8)),
              //   child: Material(
              //     color: const Color(MyColor.colorGrey6),
              //     child: InkWell(
              //       splashColor: const Color(MyColor.colorGrey0),
              //       //onTap: (){},
              //       child: Padding(
              //           padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.75)),
              //           child: Icon(
              //             Icons.arrow_forward_ios,
              //             size: ScreenSize(context).heightOnly( 2.0),
              //             color: const Color(MyColor.colorGrey3),
              //           )
              //       ),
              //     ),
              //   ),
              // ),
            ],
          )
        ],
      ),
    );
  }
}
