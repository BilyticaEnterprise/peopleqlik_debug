import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/TimeRegulationListener/time_regulation_list_listener.dart';
import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';
import 'package:peopleqlik_debug/Version1/Models/TimeRegulationModels/time_regulation_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';

import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../../utils/date_formats.dart';
import '../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../utils/Reuse_LogicalWidgets/approve_reject_pending_text_widget.dart';
import '../../../../../../../utils/icon_view/next_icon.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../../utils/Reuse_LogicalWidgets/skeleton_list_widget.dart';


class AttendanceRegulationWidget extends StatelessWidget {
  final int? index;
  final int? type;
  final Function() onTap;
  final TimeRegulationDataList? dataList;
  const AttendanceRegulationWidget(this.index, this.dataList,{required this.onTap,this.type,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<TimeRegulationListListener>(context,listen: false).reachedEnd&&index==Provider.of<TimeRegulationListListener>(context,listen: false).dataList!.length-1?
    SkeletonListWidget(index!)
        :
    Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: const Color(MyColor.colorBackgroundDark),
            width: 1,
          )
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(13)),
        child: Material(
          color: const Color(MyColor.colorWhite),
          child: InkWell(
            onTap: onTap,
            child: Padding(
                padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '# ${dataList?.requestMID}',
                            style: GetFont.get(
                                context,
                                fontSize: 1.6,
                                fontWeight: FontWeight.w400,
                                color: MyColor.colorGrey3
                            ),
                          ),
                        ),
                        ApproveRejectPendingTextWidget(id: dataList?.approvalStatusID??0,text: dataList?.statusName??'',),
                      ],
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 0.3),),
                    Text(
                      '${CallLanguageKeyWords.get(context, LanguageCodes.appliedFor)}, ${GetDateFormats().getFilterDate(dataList?.requestDate)??''}',
                      style: GetFont.get(
                          context,
                          fontSize: 2.0,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                      ),
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 0.8),),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            dataList?.waiveOffStatus??'',
                            style: GetFont.get(
                                context,
                                fontSize: 1.6,
                                fontWeight: FontWeight.w600,
                                color: MyColor.colorPrimary
                            ),
                          ),
                        ),
                      ],
                    ),
                    DividerByHeight(1),
                    Row(
                      children: [
                        Expanded(
                          child: OldTimeLine(
                            header1: type==AppConstants.movementSlipTypeId?'${CallLanguageKeyWords.get(context, LanguageCodes.fromTime)}':'${CallLanguageKeyWords.get(context, LanguageCodes.oldTimeIn)}',
                            header2: type==AppConstants.movementSlipTypeId?'${CallLanguageKeyWords.get(context, LanguageCodes.toTime)}':'${CallLanguageKeyWords.get(context, LanguageCodes.oldTimeOut)}',
                            answer1: GetDateFormats().getFilterTime1((type==AppConstants.movementSlipTypeId)?dataList?.waiveOffTimeIn:dataList?.timeIn)??'',
                            answer2: GetDateFormats().getFilterTime1((type==AppConstants.movementSlipTypeId)?dataList?.waiveOffTimeOut:dataList?.timeOut)??'',
                            color: type==AppConstants.movementSlipTypeId?MyColor.colorPrimary:MyColor.colorGrey0,
                          ),
                        ),
                        if(type == AppConstants.movementSlipTypeId)...[
                          Expanded(child: Container()),
                        ],
                        if(type != AppConstants.movementSlipTypeId)...[
                          Expanded(
                            child: OldTimeLine(
                              header1: '${CallLanguageKeyWords.get(context, LanguageCodes.newTimeIn)}',
                              header2: '${CallLanguageKeyWords.get(context, LanguageCodes.newTimeOut)}',
                              answer1: GetDateFormats().getFilterTime1(dataList?.waiveOffTimeIn)??'',
                              answer2: GetDateFormats().getFilterTime1(dataList?.waiveOffTimeOut)??'',
                              color: MyColor.colorPrimary,
                            ),
                          ),
                        ],
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${CallLanguageKeyWords.get(context, LanguageCodes.appliedOn)} ${GetDateFormats().getFilterDate(dataList?.createdDate)}',
                            style: GetFont.get(
                                context,
                                fontSize: 1.4,
                                fontWeight: FontWeight.w400,
                                color: MyColor.colorBlack
                            ),
                          ),
                        ),
                        const NextIcon()
                      ],
                    )
                  ],
                ),
              ),
          ),
          ),
      ),
    );
  }
  // int? getColorOfLeaveType(int? timeOffType)
  // {
  //   switch(timeOffType)
  //   {
  //     case 1:
  //       return MyColor.colorT12;
  //     case 3:
  //       return MyColor.colorT56;
  //     case 2:
  //       return MyColor.colorT34;
  //     default:
  //       return MyColor.colorPrimary;
  //   }
  // }

// getTotalLeavesCount(List<TimeoffDetail>? timeOffDetail)
// {
//   if(timeOffDetail!=null&&timeOffDetail.isNotEmpty)
//   {
//     double count = 0;
//     for(int x=0;x<timeOffDetail.length;x++)
//     {
//       count = count + timeOffDetail[x].totalLeaves!;
//     }
//     return count;
//   }
//   return 0;
// }
}
class OldTimeLine extends StatelessWidget {
  final String? header1,header2;
  final String? answer1,answer2;
  final int? color,colorExtra;
  final bool? colorByIndex;
  final Axis? axis;
  const OldTimeLine({this.colorByIndex,this.colorExtra,this.color,this.axis,this.answer1,this.answer2,this.header1,this.header2,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      theme: TimelineThemeData(
        direction: axis,
        nodePosition: 0,
        connectorTheme: ConnectorThemeData(
          thickness: ScreenSize(context).heightOnly( 0.4),
          color: const Color(0xffd3d3d3),
        ),
        indicatorTheme: IndicatorThemeData(
          size: ScreenSize(context).heightOnly( 2),
        ),
      ),
      padding: const EdgeInsets.all(0),
      builder: TimelineTileBuilder.connected(
        contentsBuilder: (_, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 3)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                index==0?'$header1':'$header2',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w400,
                    fontSize: 1.2,
                    color: MyColor.colorBlack
                ),
              ),
              const DividerByHeight(0.4),
              Text(
                index==0?'$answer1':'$answer2',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w600,
                    fontSize: 1.5,
                    color: MyColor.colorBlack
                ),
              )
            ],
          ),
        ),
        connectorBuilder: (_, index, __) {
          return SolidLineConnector(color: Color(color??MyColor.colorPrimary,),direction: axis,);
        },
        indicatorBuilder: (_, index) {
          return DotIndicator(
            color: Color(colorByIndex==true?index==1?(color??MyColor.colorPrimary):(colorExtra??MyColor.colorPrimary):(color??MyColor.colorPrimary)),
            child: Icon(
              index==1?Icons.first_page:Icons.last_page,
              color: (color==MyColor.colorGrey0?Colors.black:Colors.white),
              size: ScreenSize(context).heightOnly( 1.4),
            ),
          );
        },
        itemExtentBuilder: (_, __) => ScreenSize(context).heightOnly( 6),
        itemCount: 2,
      ),
    );
  }
}