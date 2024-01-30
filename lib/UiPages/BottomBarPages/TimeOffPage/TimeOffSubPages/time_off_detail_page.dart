import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/post_time_off_cancel_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/TimeOffEnCashListners/time_off_detail_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/time_off_cancel_mapper.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/time_off_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/AcceptancePanels/approval_header_panel.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_rejection_page.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/TimeOffPage/TimeOffSubPages/TimeOffPanel/time_off_cancel_panel_body.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/TimeOffPage/TimeOffSubPages/TimeOffPanel/time_off_cancel_panel_header.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Buttons/buttons.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import '../../../Reuse_Widgets/BottomSheetUi/bottom_sheet_ui.dart';
import '../../RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/CommonWidgets/approval_list_widget.dart';

class TimeOffDetailPage extends StatelessWidget {
  LeavesDataList? leavesDataList;
  // PanelController panelController = PanelController();
  TimeOffDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    leavesDataList = ModalRoute.of(context)!.settings.arguments as LeavesDataList;
    return MultiProvider(
      providers: [
        Provider<TimeOffCancelCollector>(create: (_) => TimeOffCancelCollector(),),
        ChangeNotifierProvider<TimeOffDetailListener>(create: (_) => TimeOffDetailListener())
      ],
      child: Scaffold(
        backgroundColor: const Color(MyColor.colorWhite),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: false,
                    floating: true,
                    backgroundColor: const Color(MyColor.colorWhite),
                    snap: true,
                    elevation: 2,
                    titleSpacing: 0,
                    title: AppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffDetail)}')
                ),
              ];
            },
            body: BodyData(leavesDataList),
          )
      ),
    );
  }
}
class BodyData extends StatefulWidget {
  final LeavesDataList? leavesDataList;
  const BodyData(this.leavesDataList, {Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TimeOffDetailListener>(context,listen: false).start(context, widget.leavesDataList?.applicationCode, widget.leavesDataList?.companyCode, widget.leavesDataList?.employeeCode);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TimeOffDetailListener>(
      builder: (context, data, child) {
        if(data.apiStatus == ApiStatus.done)
          {
            return SizedBox(
              height: ScreenSize(context).heightOnly( 100),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                      padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Color(MyColor.colorGrey5)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.leavesDataList?.typeTitle??'',
                            style: GetFont.get(
                                context,
                                fontSize: 2.2,
                                fontWeight: FontWeight.w600,
                                color: getColorOfLeaveType(widget.leavesDataList?.approvalStatusID)
                            ),
                          ),
                          SizedBox(height: ScreenSize(context).heightOnly( 0.6),),
                          RichText(
                            text: TextSpan(
                                text: '${CallLanguageKeyWords.get(context, LanguageCodes.Hello)}, ',
                                style: GetFont.get(
                                    context,
                                    fontSize: 1.6,
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.colorGrey3
                                ),
                                children: [
                                  TextSpan(
                                    text: widget.leavesDataList?.employeeName??'',
                                    style: GetFont.get(
                                        context,
                                        fontSize: 1.6,
                                        fontWeight: FontWeight.w600,
                                        color: MyColor.colorGrey3
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' ${CallLanguageKeyWords.get(context, LanguageCodes.headerOne)}',
                                    style: GetFont.get(
                                        context,
                                        fontSize: 1.6,
                                        fontWeight: FontWeight.w400,
                                        color: MyColor.colorGrey3
                                    ),
                                  )
                                ]
                            ),
                          ),
                          SizedBox(height: ScreenSize(context).heightOnly( 2),),
                          TimeDetailInfoWidget(header: '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDate)}:    ',value: '${GetDateFormats().getFilterDate(widget.leavesDataList!.requestDate)}',),
                          SizedBox(height: ScreenSize(context).heightOnly( 1),),
                          TimeDetailInfoWidget(header: '${CallLanguageKeyWords.get(context, LanguageCodes.RequestApplicationCode)}:    ',value: '${widget.leavesDataList!.applicationCode}',),
                          SizedBox(height: ScreenSize(context).heightOnly( 1),),
                          TimeDetailInfoWidget(header: '${CallLanguageKeyWords.get(context, widget.leavesDataList?.unitID == GetVariable.isTime?LanguageCodes.TotalMinutes:LanguageCodes.TotalDays)}:    ',value: '${getTotalLeavesCount(widget.leavesDataList!.timeoffDetail)}',),
                          SizedBox(height: ScreenSize(context).heightOnly( 1),),
                          TimeDetailInfoWidget(header: '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffEmerContact3)}:    ',value: widget.leavesDataList!.eCIName,),
                          SizedBox(height: ScreenSize(context).heightOnly( 1),),
                          TimeDetailInfoWidget(header: '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffEmerContact1)}:    ',value: widget.leavesDataList!.eCINumber??'',),
                        ],
                      ),
                    ),
                    if(widget.leavesDataList?.remarks!=null&&widget.leavesDataList!.remarks!.isNotEmpty)...[
                      SizedBox(height: ScreenSize(context).heightOnly( 3),),
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                          padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              color: Color(MyColor.colorGrey5)
                          ),
                          //padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffAnyRemarks1)}',
                                style: GetFont.get(
                                    context,
                                    fontSize: 2.2,
                                    fontWeight: FontWeight.w600,
                                    color: MyColor.colorBlack
                                ),
                              ),
                              SizedBox(height: ScreenSize(context).heightOnly( 1),),
                              Text(
                                '${widget.leavesDataList?.remarks}.',
                                style: GetFont.get(
                                    context,
                                    fontSize: 1.8,
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.colorBlack
                                ),
                              ),
                            ],
                          )
                      ),
                    ],
                    SizedBox(height: ScreenSize(context).heightOnly( 3),),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${CallLanguageKeyWords.get(context, LanguageCodes.LeaveStatus)}',
                              style: GetFont.get(
                                  context,
                                  fontSize: 2.2,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorBlack
                              ),
                            ),
                          ),
                          Text(
                            '${widget.leavesDataList?.statusName}',
                            style: GetFont.get(
                                context,
                                fontSize: 2.2,
                                fontWeight: FontWeight.w600,
                                color: MyColor.colorBlack
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.all(0),
                          itemBuilder: (context,index){
                            return Container(
                              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 2)),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                                color: const Color(MyColor.colorWhite),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey.shade300,
                                      spreadRadius: 0.0,
                                      blurRadius: 14,
                                      offset: const Offset(3.0, 3.0)),
                                  BoxShadow(
                                      color: Colors.grey.shade400,
                                      spreadRadius: 0.0,
                                      blurRadius: 14 / 2.0,
                                      offset: const Offset(3.0, 3.0)),
                                  BoxShadow(
                                      color: Colors.grey.shade50,
                                      spreadRadius: 2.0,
                                      blurRadius: 14,
                                      offset: const Offset(0.0, -3.0)),
                                  BoxShadow(
                                      color: Colors.grey.shade50,
                                      spreadRadius: 2.0,
                                      blurRadius: 14 / 2,
                                      offset: const Offset(0.0, -3.0)),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${CallLanguageKeyWords.get(context, LanguageCodes.LeaveFrom)}',
                                          style: GetFont.get(
                                              context,
                                              fontSize: 1.8,
                                              fontWeight: FontWeight.w600,
                                              color: MyColor.colorBlack
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${GetDateFormats().getFilterDate(widget.leavesDataList?.timeoffDetail?[index].leaveFrom)} ${widget.leavesDataList?.unitID == GetVariable.isTime?GetDateFormats().getFilterTime(widget.leavesDataList?.timeoffDetail?[index].leaveFrom):""}',
                                        style: GetFont.get(
                                            context,
                                            fontSize: 1.8,
                                            fontWeight: FontWeight.w400,
                                            color: MyColor.colorBlack
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${CallLanguageKeyWords.get(context, LanguageCodes.LeaveTo)}',
                                          style: GetFont.get(
                                              context,
                                              fontSize: 1.8,
                                              fontWeight: FontWeight.w600,
                                              color: MyColor.colorBlack
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${GetDateFormats().getFilterDate(widget.leavesDataList?.timeoffDetail?[index].leaveTo)} ${widget.leavesDataList?.unitID == GetVariable.isTime? GetDateFormats().getFilterTime(widget.leavesDataList?.timeoffDetail?[index].leaveTo):""}',
                                        style: GetFont.get(
                                            context,
                                            fontSize: 1.8,
                                            fontWeight: FontWeight.w400,
                                            color: MyColor.colorBlack
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${CallLanguageKeyWords.get(context, widget.leavesDataList?.unitID == GetVariable.isTime?LanguageCodes.TotalMinutes:LanguageCodes.TotalDays)}',
                                          style: GetFont.get(
                                              context,
                                              fontSize: 1.8,
                                              fontWeight: FontWeight.w600,
                                              color: MyColor.colorBlack
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${widget.leavesDataList?.timeoffDetail?[index].totalLeaves}',
                                        style: GetFont.get(
                                            context,
                                            fontSize: 1.8,
                                            fontWeight: FontWeight.w400,
                                            color: MyColor.colorBlack
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context,index){
                            return SizedBox(height: ScreenSize(context).heightOnly( 2),);
                          },
                          itemCount: widget.leavesDataList?.timeoffDetail?.length??0
                      ),
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 1),),
                    if(data.timeOffDetailResultSet?.lObjApprovalHistory!=null&&data.timeOffDetailResultSet!.lObjApprovalHistory!.isNotEmpty)...
                    [
                      SizedBox(height: ScreenSize(context).heightOnly( 2),),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                        child: Text(
                          '${CallLanguageKeyWords.get(context, LanguageCodes.ApprovalHistory)}',
                          style: GetFont.get(
                              context,
                              fontWeight: FontWeight.w700,
                              fontSize: 2.2,
                              color: MyColor.colorBlack
                          ),
                        ),
                      ),
                      SizedBox(height: ScreenSize(context).heightOnly( 1.5),),
                      Flexible(
                        //fit: FlexFit.loose,
                          flex: 1,
                          child: ApprovalListWidget(data.approvalsList)

                      ),
                      SizedBox(height: ScreenSize(context).heightOnly(2),),
                    ],

                    if(widget.leavesDataList?.approvalStatusID == 1)...[
                      SizedBox(height:ScreenSize(context).heightOnly(6),),
                      Center(child: ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.timeOffDelete)}',buttonColor: MyColor.colorRed,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: cancelPressed,)),
                    ],
                    SizedBox(height:ScreenSize(context).heightOnly(16),),
                  ],
                ),
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
  cancelPressed() async
  {
    Future.delayed(const Duration(milliseconds: 50),(){
      ShowBottomSheet.show(
          context,
          height: 90,
          body: LeaveCancelBody(),
          appBar: CancelPanelHeaderHeader(),
          callBack: (filterValues){
            if(filterValues!=null&&filterValues is String)
              {
                Future.delayed(const Duration(milliseconds: 100),(){
                  TimeOffCancelCollector timeOffCancelCollector = Provider.of<TimeOffCancelCollector>(context,listen: false);
                  timeOffCancelCollector.cancelLeaveJson?.cancelLeaveRemarks = filterValues;
                  timeOffCancelCollector.fillData(context,widget.leavesDataList);
                });
              }
          }
      );
    });
  }
  //TimeOffCancelCollector
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

class TimeDetailInfoWidget extends StatelessWidget {
  final String? header,value;
  const TimeDetailInfoWidget({this.header,this.value,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          header??'',
          style: GetFont.get(
              context,
              fontSize: 1.6,
              fontWeight: FontWeight.w600,
              color: MyColor.colorBlack
          ),
        ),
        Text(
          value??'',
          style: GetFont.get(
              context,
              fontSize: 1.6,
              fontWeight: FontWeight.w600,
              color: MyColor.colorBlack
          ),
        )
      ],
    );
  }
}
