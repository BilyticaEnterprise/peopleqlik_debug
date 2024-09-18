import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveListModule/presentation/listener/time_off_list_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/ui_time_off_clicks.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_model.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/time_off_detail_mapper.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/approve_reject_pending_text_widget.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import 'package:peopleqlik_debug/utils/SkeletetonAnimation/skeleton_text.dart';

class TimeOffListWidget extends StatefulWidget {
  final TimeOffPageEnum? timeOffPageEnum;
  const TimeOffListWidget(this.timeOffPageEnum, {Key? key}) : super(key: key);

  @override
  State<TimeOffListWidget> createState() => _TimeOffListWidgetState();
}

class _TimeOffListWidgetState extends State<TimeOffListWidget> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TimeOffModelListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done|| data.apiStatus == ApiStatus.pagination)
          {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification){
                TimeOffModelListener timeOffModelListener = Provider.of<TimeOffModelListener>(context,listen: false);
                 //PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                {
                  //PrintLogs.print('true');
                  timeOffModelListener.updateStep(true, context);
                  return true;
                }
                else
                {
                  timeOffModelListener.updateStep(false, context);
                  return false;
                }
              },
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 2), ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 10)),
                  itemBuilder: (context,index)
                  {
                    return ListWidget(data.leavesDataList![index],index);
                  },
                  separatorBuilder: (context,index)
                  {
                    return SizedBox(height: ScreenSize(context).heightOnly( 2.5),);
                  },
                  itemCount: data.leavesDataList?.length??0
              ),
            );
          }
          else if(data.apiStatus == ApiStatus.empty)
            {
              return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr11)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr12)}',topMargin: 8,width: 40,);
            }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }

}
class ListWidget extends StatelessWidget {
  final int? index;
  final LeavesDataList? data;
  const ListWidget(this.data,this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<TimeOffModelListener>(context,listen: false).reachedEnd&&index==Provider.of<TimeOffModelListener>(context,listen: false).leavesDataList!.length-1?
      Container(
        height: ScreenSize(context).heightOnly( 14),
        width: double.maxFinite,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            border: Border.all(
              color: const Color(MyColor.colorBackgroundDark),
              width: 1,
            )
        ),
        child: SkeletonAnimation(
            key: Key('timeOffShimmer$index'),
            shimmerColor:Colors.white70,
            gradientColor:const Color(MyColor.colorGreyPrimary).withOpacity(0.2),
            curve:Curves.fastOutSlowIn, child: Container()),
      ):Container(
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
            splashColor: const Color(MyColor.colorBackgroundDark),
            onTap: (){
              Navigator.pushNamed(context, CurrentPage.TimeOffDetailPage,
                  arguments: AllRequestDetailMapper(documentNumber: data?.documentNo.toString(),companyCode: data?.companyCode.toString(),screenID: data?.screenID.toString(),isApprovalScreen: false)
              ).then((value){
                if(value != null && value is bool&& value ==true)
                  {
                    Provider.of<TimeOffModelListener>(context,listen: false).start(context,ApiStatus.started);
                  }
              });
            },
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${getTotalLeavesCount(data?.timeoffDetail)} ${CallLanguageKeyWords.get(context, LanguageCodes.daysApplications)}',
                          style: GetFont.get(
                              context,
                              fontSize: 1.6,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorGrey3
                          ),
                        ),
                      ),
                      ApproveRejectPendingTextWidget(id: data?.approvalStatusID??0,text: data?.statusName??'',),
                    ],
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 0.3),),
                  Text(
                    '${GetDateFormats().getFilterDate(data?.timeoffDetail?[0].leaveFrom)} - ${GetDateFormats().getFilterDate(data?.timeoffDetail?[0].leaveTo)}',
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
                          data?.typeTitle??'',
                          style: GetFont.get(
                              context,
                              fontSize: 1.6,
                              fontWeight: FontWeight.w600,
                              color: getColorOfLeaveType(data?.approvalStatusID)
                          ),
                        ),
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: Material(
                          color: const Color(MyColor.colorGrey6),
                          child: InkWell(
                            splashColor: const Color(MyColor.colorGrey0),
                            //onTap: (){},
                            child: Padding(
                                padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.75)),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: ScreenSize(context).heightOnly( 2.0),
                                  color: const Color(MyColor.colorGrey3),
                                )
                            ),
                          ),
                        ),
                      )
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
  int? getColorOfLeaveType(int? timeOffType)
  {
    switch(timeOffType)
    {
      case 1:
        return MyColor.colorT12;
      case 3:
        return MyColor.colorT56;
      case 2:
        return MyColor.colorT34;
      default:
        return MyColor.colorPrimary;
    }
  }
  int? getColorOfLeaveStatusType(int? timeOffType)
  {
    switch(timeOffType)
    {
      case 1:
        return MyColor.colorT1;
      case 3:
        return MyColor.colorT5;
      case 2:
        return MyColor.colorT3;
      default:
        return MyColor.colorRed1;
    }
  }
  int? getColorOfLeaveStatusText(int? timeOffType)
  {
    switch(timeOffType)
    {
      case 1:
        return MyColor.colorT2;
      case 3:
        return MyColor.colorT6;
      case 2:
        return MyColor.colorT4;
      default:
        return MyColor.colorWhite;
    }
  }
  getTotalLeavesCount(List<TimeoffDetail>? timeOffDetail)
  {
    if(timeOffDetail!=null&&timeOffDetail.isNotEmpty)
    {
      double count = 0;
      for(int x=0;x<timeOffDetail.length;x++)
      {
        count = count + timeOffDetail[x].totalLeaves!;
      }
      return count;
    }
    return 0;
  }
}

