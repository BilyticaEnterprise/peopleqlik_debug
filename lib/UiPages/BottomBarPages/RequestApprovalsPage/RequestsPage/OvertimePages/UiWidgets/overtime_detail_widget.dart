import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/divider.dart';

import '../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/OverTimeListeners/acceptance_rejection_approval_detail_api.dart';
import '../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/OverTimeListeners/overtime_detail_api_listener.dart';
import '../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../src/colors.dart';
import '../../../../../../src/date_formats.dart';
import '../../../../../../src/fonts.dart';
import '../../../../../../src/language_codes.dart';
import '../../../../../../src/screen_sizes.dart';
import '../../../../../Reuse_LogicalWidgets/approve_reject_pending_text_widget.dart';
import '../../../../../Reuse_Widgets/Containers/container_design_1.dart';
import '../../../../../Reuse_Widgets/dividers.dart';
import '../../../../../Reuse_Widgets/horizontal_vertical_line.dart';
import '../OverTimeDashBoardTeamRequest/UiWidgets/start_end_widget.dart';

class OverTimeDetailWidget extends StatelessWidget {
  final OvertimeViewModel? data;
  final int? index;
  const OverTimeDetailWidget(this.data,this.index, {Key? key}) : super(key: key);

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
                  '${CallLanguageKeyWords.get(context, LanguageCodes.employeeCode)}, ${data?.employeeData?.employeeCode}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorGrey3
                  ),
                ),
              ),
              ApproveRejectPendingTextWidget(id: data?.employeeData?.approvalStatusID??0,text: data?.employeeData?.status??'',),
            ],
          ),
          SizedBox(height: ScreenSize(context).heightOnly( 0.3),),
          Text(
            '${CallLanguageKeyWords.get(context, LanguageCodes.by)}, ${data?.employeeData?.name}',
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
                text: '${data?.employeeData?.overtimeType??''} ',
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
                    text: '${GetDateFormats().getTimeWithDuration(context,data?.totalMinutes??0)}',
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
          HorizontalLine(width: double.infinity,),
          ListView.separated(
            shrinkWrap: true,
              padding: EdgeInsets.all(0),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${CallLanguageKeyWords.get(context, LanguageCodes.onDate)}, ${GetDateFormats().getFilterDate(data?.datesList?[index].ovtDate)}',
                          style: GetFont.get(
                              context,
                              fontSize: 1.6,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                        ),
                      ),
                      Text(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.forr)}, ${GetDateFormats().getTimeWithDuration(context,(data?.datesList?[index].overtimeMinutes??0).toInt())}',
                        style: GetFont.get(
                            context,
                            fontSize: 1.8,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorPrimary
                        ),
                      ),
                    ],
                  ),
                  const DividerByHeight(1.2),
                  Row(
                    children: [
                      Text(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.shift)}:  ',
                        style: GetFont.get(
                            context,
                            fontWeight: FontWeight.w400,
                            fontSize: 1.4,
                            color: MyColor.colorBlack
                        ),
                      ),
                      Text(
                        '${GetDateFormats().getFilterTime2(data?.datesList?[index].shiftStartTime)}',
                        style: GetFont.get(
                            context,
                            fontWeight: FontWeight.w400,
                            fontSize: 1.4,
                            color: MyColor.colorBlack
                        ),
                      ),
                      const DividerHorizontal(2),
                      const StartEndWidget(width: 14,size: 0.9,),
                      const DividerHorizontal(2),
                      Text(
                        '${GetDateFormats().getFilterTime2(data?.datesList?[index].shiftEndTime)}',
                        style: GetFont.get(
                            context,
                            fontWeight: FontWeight.w400,
                            fontSize: 1.4,
                            color: MyColor.colorBlack
                        ),
                      ),
                    ],
                  ),
                ],
              );
              },
              separatorBuilder: (context,index){
              return DividerVertical(3.5);
              },
              itemCount: data?.datesList?.length??0
          )
        ],
      ),
    );
  }
}
