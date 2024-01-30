import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/dashboard_enums.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/AttendanceListener/attendance_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/sliding_up_panel.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/AttendanceListener/attendance_logic_builder.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/UserLocation/get_user_location.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/DashBoardPage/DashBoardSubWidgets/check_in_out_button.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/DashBoardPage/DashBoardSubWidgets/circle_indicator.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Buttons/buttons.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/loader.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import '../../../BusinessLogicModel/Models/TeamModel/get_employee_leave_balance_mapper.dart';
import '../../../src/lottie_string.dart';
import '../../Reuse_Widgets/Headers/header_large.dart';
import 'DashBoardSubWidgets/bottom_card_widget.dart';

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
      // StreamController<bool> loadingStream = StreamController.broadcast();
      // ShowLoaderPopUp.showExtra(context,loadingStream);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInternetConnection>(
      builder: (context,internet,child) {
        if(internet.internetConnectionEnum == InternetConnectionEnum.available)
          {
            return CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(
                  child: TopWidget(),
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
                  child: BottomCardWidget(dashboardEnum: DashboardEnum.leaveBalanceCurrentEmployee,header: CallLanguageKeyWords.get(context, LanguageCodes.leaveBalance)??'',value: '${CallLanguageKeyWords.get(context, LanguageCodes.leaveBalanceValue1)??''} 1 . ${CallLanguageKeyWords.get(context, LanguageCodes.leaveBalanceValue2)??''}',animationIcon: 'assets/${LottieString.leavebalance}.json',iconColor: MyColor.colorA3,onTap: (){
                    Provider.of<PostAttendanceListener>(context,listen: false).goToLeaveBalancePage(context);
                    },),
                ),
              ],
            );
          }
        else
          {
            return NotAvailable(GetVariable.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PostAttendanceListener>(context,listen: false).getDashBoard(context);
    });
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
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(5.6)),
      child: Consumer<PostAttendanceListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done&&data.postAttendanceResultSet?.manualAttendance == true)
            {
             // PrintLogs.printLogs('lkklml ${data.postAttendanceResultSet?.totalMinutes}');
              return Column(
                children: [
                  SizedBox(height: ScreenSize(context).heightOnly(2),),
                  CircleSpinner(key: const Key('new'),progressController:progressController,spinnerSize:24,text:GetDateFormats().getDuration(Duration(minutes: data.postAttendanceResultSet?.totalMinutes??0)),percent:data.attendancePercent,color:MyColor.colorPrimary,icon:MdiIcons.accountOff,),
                  SizedBox(height: ScreenSize(context).heightOnly(4),),
                  SizedBox(
                    height: ScreenSize(context).heightOnly(20.5),
                    child: Row(
                      children: [
                        Expanded(
                            child: CheckInOutButton(checkInPressed,enabled: data.checkInOutBreakInStatus==CheckInOutBreakInStatus.checkIn?false:true,text:GetDateFormats().getFilterTime(data.postAttendanceResultSet?.firstCheckin)??'00:00',header: '${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardUser)}\n${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckIn)}',buttonText:'${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckIn)}',buttonColor:MyColor.colorPrimary,iconColor:MyColor.colorPrimary,icon:Icons.update,key: const Key('CheckInButton'),)
                        ),
                        SizedBox(width: ScreenSize(context).widthOnly( 4),),
                        Expanded(
                            child: CheckInOutButton(checkOutPressed,enabled: data.checkInOutBreakInStatus==CheckInOutBreakInStatus.checkOut?false:true,text:GetDateFormats().getFilterTime(data.postAttendanceResultSet?.firstCheckOut)??'00:00',header: '${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardUser)}\n${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckOut)}',buttonText:'${CallLanguageKeyWords.get(context, LanguageCodes.dashBoardCheckOut)}',buttonColor:MyColor.colorBlack,iconColor:MyColor.colorBlack,icon:Icons.lock_clock,key: const Key('CheckOutButton'),)
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
                  CircleSpinner(key: Key('old'),progressController:progressController,spinnerSize:24,text:'00 : 00',percent:1,color:MyColor.colorPrimary,icon:MdiIcons.accountOff,),
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

