import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/ui/DashBoardSubWidgets/dummy_widgets/dashboard_dummy.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/ui/DashBoardSubWidgets/dummy_widgets/dummy_dashboard_widget.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/attendance_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/sliding_up_panel.dart';
import 'package:peopleqlik_debug/Version2/Modules/DashBoardModule/presentation/listeners/attendance_logic_builder.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/UserLocation/get_user_location.dart';
import 'package:peopleqlik_debug/utils/Enums/dashboard_enums.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/utils/headers/header_large.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/loader_utils/loader.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../configs/get_assets.dart';
import '../../../../../utils/lottie_anims_utils/lottie_string.dart';
import '../listeners/timer_update_listener.dart';
import 'DashBoardSubWidgets/widgets/bottom_card_widget.dart';
import 'DashBoardSubWidgets/widgets/check_in_check_out_widgets/check_in_out_button.dart';
import 'DashBoardSubWidgets/widgets/check_in_check_out_widgets/circle_indicator.dart';
import 'DashBoardSubWidgets/widgets/documents_widget/document_widget.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BodyData();
  }
}
class BodyData extends StatefulWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostAttendanceListener>(context,listen: false).getDashBoard(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInternetConnection>(
          builder: (context,internet,child) {
            if(internet.internetConnectionEnum == InternetConnectionEnum.available)
              {

                return Consumer<PostAttendanceListener>(
                    builder: (context,data,child) {
                      if(data.apiStatus == ApiStatus.nothing||data.apiStatus == ApiStatus.started)
                        {
                          return DashboardDummy();
                        }
                      else
                        {
                          return CustomScrollView(
                            slivers: [
                              const SliverToBoxAdapter(
                                child: TopWidget(),
                              ),
                              SliverToBoxAdapter(
                                  child: MainHeaderWidget(text: CallLanguageKeyWords.get(context, LanguageCodes.activity)??'')
                              ),
                              // SliverToBoxAdapter(
                              //   child: AttendanceSummary(onTap: (){
                              //     Navigator.pushNamed(context, CurrentPage.attendanceSummaryPage);
                              //   },),
                              // ),
                              // SliverToBoxAdapter(
                              //   child: TodoDashboardWidget(onTap: (){
                              //     Navigator.pushNamed(context, CurrentPage.todoMainPage);
                              //   },),
                              // ),
                              SliverToBoxAdapter(
                                child: DocumentDashboardWidget(
                                  isEmpty: data.apiStatus==ApiStatus.empty||data.apiStatus == ApiStatus.error,
                                  data: data.objDocumentList,
                                  onTap: (){
                                    Navigator.pushNamed(context, CurrentPage.documentMainPage).then((value){
                                      if(value !=null &&value is bool&&value == true)
                                        {
                                          Provider.of<PostAttendanceListener>(context,listen: false).getDashBoard(context);
                                        }
                                    });
                                  },
                                ),
                              ),
                              SliverToBoxAdapter(
                                  child: MainHeaderWidget(text: CallLanguageKeyWords.get(context, LanguageCodes.dashboardTitle1)??'')
                              ),
                              SliverToBoxAdapter(
                                child: BottomCardWidget(dashboardEnum: DashboardEnum.timesheet,header: CallLanguageKeyWords.get(context, LanguageCodes.dashBoardTimeSheet)??'',value: CallLanguageKeyWords.get(context, LanguageCodes.dashBoardTimeSheetDetail)??'',animationIcon: LottieString.timeSheet,iconColor: MyColor.colorA4,onTap: (){ Navigator.pushNamed(context, CurrentPage.TimeSheetPage);},),
                              ),
                              SliverToBoxAdapter(
                                child: BottomCardWidget(dashboardEnum: DashboardEnum.overtimeEmployee,header: CallLanguageKeyWords.get(context, LanguageCodes.dashBoardOverTimeHeader)??'',value: CallLanguageKeyWords.get(context, LanguageCodes.dashBoardOverTimeValue)??'',animationIcon: 'assets/${LottieString.overtime}.json',iconColor: MyColor.colorA5,onTap: (){Navigator.pushNamed(context, CurrentPage.OverTimeTeamRequestPage);},),
                              ),
                              SliverToBoxAdapter(
                                child: BottomCardWidget(dashboardEnum: DashboardEnum.leaveBalanceCurrentEmployee,header: CallLanguageKeyWords.get(context, LanguageCodes.leaveBalance)??'',value: '${CallLanguageKeyWords.get(context, LanguageCodes.leaveBalanceValue1)??''} ${data.getLeaveBalance()} . ${CallLanguageKeyWords.get(context, LanguageCodes.leaveBalanceValue2)??''}',animationIcon: 'assets/${LottieString.leavebalance}.json',iconColor: MyColor.colorA3,
                                  onTap: ()
                                  {
                                    Provider.of<PostAttendanceListener>(context,listen: false).goToLeaveBalancePage(context);
                                  },
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: BottomCardWidget(dashboardEnum: DashboardEnum.organizationChart,header: CallLanguageKeyWords.get(context, LanguageCodes.organizationChartHeader)??'',value: CallLanguageKeyWords.get(context, LanguageCodes.organizationChartValue)??'',animationIcon: 'assets/${LottieString.heirarchy}.json',iconColor: MyColor.colorA5,animSize: 8,paddingRight: 2,onTap: (){Navigator.pushNamed(context, CurrentPage.organizationChartPage);},),
                              ),
                            ],
                          );
                        }
                  }
                );
              }
            else
              {
                return NotAvailable(GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
              }
          }
        );

  }
}
class TopWidget extends StatefulWidget{
  const TopWidget({Key? key}) : super(key: key);

  @override
  _TopWidgetState createState() => _TopWidgetState();
}

class _TopWidgetState extends State<TopWidget> with WidgetsBindingObserver, TickerProviderStateMixin{
  AnimationController? progressController;

  @override
  void initState() {
    progressController = AnimationController(vsync: this,duration: const Duration(milliseconds: 1000));
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }
  @override
  void dispose() {
    if(progressController!=null)
    {
      progressController?.stop(canceled: true);
      progressController?.dispose();
    }
    WidgetsBinding.instance.removeObserver(this);
    Provider.of<TimerUpdateListener>(GetNavigatorStateContext.navigatorKey.currentState!.context,listen: false).closeTimer();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(5.6)),
      child: Consumer<PostAttendanceListener>(
        builder: (context,data,child) {
          PrintLogs.printLogs('apistast ${data.apiStatus} ${data.postAttendanceResultSet?.manualAttendance}');
          if(data.apiStatus == ApiStatus.done&&data.postAttendanceResultSet?.manualAttendance == true)
            {
             // PrintLogs.printLogs('lkklml ${data.postAttendanceResultSet?.totalMinutes}');
              return Column(
                children: [
                  SizedBox(height: ScreenSize(context).heightOnly(2),),
                  Consumer<TimerUpdateListener>(
                    builder: (context, data, child) {
                      return CircleSpinner(
                        key: const Key('new'),
                        progressController:progressController,
                        spinnerSize:24,
                        text: GetDateFormats().getDuration(Duration(minutes: data.totalMinutes??0)),
                        extraText: '${GetDateFormats().twoDigits(data.totalSeconds??0)} : ${GetDateFormats().threeDigits(data.totalMilliseconds??0)}',
                        percent: data.attendancePercent,
                        color:MyColor.colorPrimary,
                        icon:MdiIcons.accountOff,
                      );
                    }
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly(4),),
                  SizedBox(
                    height: ScreenSize(context).heightOnly(20.5),
                    child: Row(
                      children: [
                        Expanded(
                            child: CheckInOutButton(checkInPressed,enabled: data.checkInOutBreakInStatus==CheckInOutBreakInStatus.checkIn?true:false,text:GetDateFormats().getFilterTime(data.postAttendanceResultSet?.firstCheckin)??'00:00',header: '${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardUser)}\n${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckIn)}',buttonText:'${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckIn)}',buttonColor:MyColor.colorPrimary,iconColor:MyColor.colorPrimary,icon:Icons.update,key: const Key('CheckInButton'),)
                        ),
                        SizedBox(width: ScreenSize(context).widthOnly( 4),),
                        Expanded(
                            child: CheckInOutButton(checkOutPressed,enabled: data.checkInOutBreakInStatus==CheckInOutBreakInStatus.checkOut?true:false,text:GetDateFormats().getFilterTime(data.postAttendanceResultSet?.firstCheckOut)??'00:00',header: '${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardUser)}\n${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckOut)}',buttonText:'${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckOut)}',buttonColor:MyColor.colorBlack,iconColor:MyColor.colorBlack,icon:Icons.lock_clock,key: const Key('CheckOutButton'),)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly(1.2),),
                ],
              );
            }
          else
            {
              return Column(
                children: [
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  CircleSpinner(
                    key: const Key('old'),
                    progressController:progressController,
                    spinnerSize:24,text:'00 : 00',
                    extraText: '00 : 000',
                    percent:1,
                    color:MyColor.colorPrimary,
                    icon:MdiIcons.accountOff,
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 4),),
                  SizedBox(
                    height: ScreenSize(context).heightOnly(20.5),
                    child: Row(
                      children: [
                        Expanded(
                            child: CheckInOutButton(checkInPressed,enabled: false,text:'00:00 Pm',header: '${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardUser)}\n${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckIn)}',buttonText:'${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckIn)}',buttonColor:MyColor.colorPrimary,iconColor:MyColor.colorPrimary,icon:Icons.update,key: const Key('CheckInButton'),)
                        ),
                        SizedBox(width: ScreenSize(context).widthOnly( 4),),
                        Expanded(
                            child: CheckInOutButton(checkOutPressed,enabled: false,text:'00:00 Pm',header: '${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardUser)}\n${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckOut)}',buttonText:'${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckOut)}',buttonColor:MyColor.colorBlack,iconColor:MyColor.colorBlack,icon:Icons.lock_clock,key: const Key('CheckOutButton'),)
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly(1.2),),
                ],
              );
            }

        }
      ),
    );
  }
  void checkInPressed()
  {
    Provider.of<AttendanceLogicBuilder>(context,listen: false).sliderWidgetEnumIs = SliderWidgetEnum.checkInTypes;
    Provider.of<AttendanceLogicBuilder>(context,listen: false).start(context);
  }
  void checkOutPressed()
  {
    Provider.of<AttendanceLogicBuilder>(context,listen: false).sliderWidgetEnumIs = SliderWidgetEnum.checkInTypes;
    Provider.of<AttendanceLogicBuilder>(context,listen: false).start(context);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    if (state == AppLifecycleState.paused) {
      //PrintLogs.print('backgroundddd');
      // went to Background
      try{
        SlidingPanelData slidingPanelData = Provider.of<SlidingPanelData>(context,listen: false);
        if(slidingPanelData.panelController!=null&&slidingPanelData.panelController!.isPanelOpen) {
          slidingPanelData.panelController?.close();
        }
      }catch(e){}
    }
    if (state == AppLifecycleState.resumed) {
      // PrintLogs.print('resumeddddd');
      CheckUserLocation checkUserLocation = Provider.of<CheckUserLocation>(context,listen: false);
      //PrintLogs.print('aya backgroundddd ${checkUserLocation.locationEnum} ${checkUserLocation.checkAppBackground}');
      Future.delayed(const Duration(milliseconds: 500),() async {
        if((checkUserLocation.locationEnum == LocationEnum.goToSettings||checkUserLocation.locationEnum == LocationEnum.permission) &&checkUserLocation.checkAppBackground==true)
        {
          //  PrintLogs.print('andr backgroundddd');
          Provider.of<CheckUserLocation>(context,listen: false).checkAppBackground=false;
          AttendanceLogicBuilder checkInOutModelStarter = Provider.of<AttendanceLogicBuilder>(context,listen: false);
          checkInOutModelStarter.start(context);
        }
      });
      // came back to Foreground
    }
    super.didChangeAppLifecycleState(state);
  }
}

