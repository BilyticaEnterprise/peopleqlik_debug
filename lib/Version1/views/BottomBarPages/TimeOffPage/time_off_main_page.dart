import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/SummaryListeners/get_summary_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/SummaryListeners/leave_calender_model_listener.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/HolidaysListener/get_holiday_list_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveListModule/presentation/listener/time_off_list_collector.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/time_off_panel_controller.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeOffEnCashListners/ui_time_off_clicks.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TimeOffPage/HolidayPages/holiday_widget.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TimeOffPage/TimeOffSubPages/TimeOffPanel/time_off_panel_body.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveListModule/presentation/ui/time_off_list_main.dart';
import 'package:peopleqlik_debug/utils/tabs/presentation/ui/custom_tabs_header.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TimeOffPage/SummarySubPages/summary_widget.dart';
import 'package:peopleqlik_debug/utils/BottomSheetUi/bottom_sheet_ui.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';

import '../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../configs/get_assets.dart';
import '../../../../configs/routing/pages_name.dart';
import '../../../../utils/Appbars/generic_app_bar.dart';
import '../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../GlobalEmployeeSearchUi/call_employee_search_ui.dart';
import 'SummarySubPages/panel_options_list_view.dart';

class TimeOffPage extends StatefulWidget {
  TimeOffPage({Key? key}) : super(key: key);

  @override
  State<TimeOffPage> createState() => _TimeOffPageState();
}

class _TimeOffPageState extends State<TimeOffPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GlobalSelectedEmployeeController>(context,listen: false).resetEmployee();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ///WhenEver timeoff section start we are setting timeoff page as default for employee serach
    return WillPopScope(
      onWillPop: () async{
        //Provider.of<EmployeeSearchController>(context,listen: false).clearEmployeeData();
        return true;
      },
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider<HolidaysModelListener>(create: (_) => HolidaysModelListener()),
            ChangeNotifierProvider<TimeOffSlidingPanelController>(create: (_) => TimeOffSlidingPanelController()),
          ],
          builder: (context,child){
            return GetPageStarterScaffoldStateLess(
              body: TimeOffMainPage(),
              appBar: Consumer<GlobalSelectedEmployeeController>(
                  builder: (context, employeeData, child) {
                    PrintLogs.printLogs('apiasdas ${employeeData.apiStatus}');
                    return Consumer<TimeOffCurrentPage>(
                        builder: (context, timeOffCurrentPage, child) {
                          return EmployeeAppBarWidget(
                            CallLanguageKeyWords.get(context, LanguageCodes.TimeOff)??'',
                            showDownIcon: timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.summary?true:false,
                            hideEmployeeSearch: timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.holiday?true:false,
                            hidePlusButton: (employeeData.apiStatus==ApiStatus.done)?(timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.summary||timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.holiday?true:false):true,
                            downArrowClick: (){
                              ShowBottomSheet.show(
                                  context,
                                  height: 90,
                                  body: SummaryOptionsList(),
                                  onDoneTap: (){
                                    LeaveCalenderModelListener leaveCalenderModelListener = Provider.of<LeaveCalenderModelListener>(context,listen: false);
                                    if(leaveCalenderModelListener.selectedIndex!=-1)
                                      {
                                        Navigator.pop(GetNavigatorStateContext.navigatorKey.currentState!.context);
                                        Provider.of<LeaveSummaryModelListener>(context,listen: false).start(context, leaveCalenderModelListener.getIndexedCalender(leaveCalenderModelListener.selectedIndex)?.calendarCode);
                                      }
                                    else
                                      {
                                        SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.calenderError2));
                                      }
                                  }
                              );
                            },
                            selectEmployeeTap: () {
                              EmployeeSearchBottomSheet().show(
                                  context,
                                      (employeeInfoMapper)
                                  {
                                    if(timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.timeOff)
                                    {
                                      Provider.of<TimeOffCurrentPage>(context,listen: false).updatePage(context,TimeOffPageEnum.timeOff);
                                    }
                                    else if(timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.summary)
                                    {
                                      Provider.of<TimeOffCurrentPage>(context,listen: false).updatePage(context,TimeOffPageEnum.summary);
                                    }
                                  }
                              );
                            },
                            removeEmployeeTap: () async {
                              await employeeData.resetEmployee();
                              if(timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.timeOff)
                              {
                                Provider.of<TimeOffCurrentPage>(context,listen: false).updatePage(context,TimeOffPageEnum.timeOff);
                              }
                              else if(timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.summary)
                              {
                                Provider.of<TimeOffCurrentPage>(context,listen: false).updatePage(context,TimeOffPageEnum.summary);
                              }
                            },
                            addFormClick: () {
                              Navigator.pushNamed(context, CurrentPage.TimeOffAddEdit).then((value){
                                if(value!=null&&value is bool && value == true)
                                {
                                  if(timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.timeOff)
                                  {
                                    Provider.of<TimeOffCurrentPage>(context,listen: false).updatePage(context,TimeOffPageEnum.timeOff);
                                  }
                                  else if(timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.summary)
                                  {
                                    Provider.of<TimeOffCurrentPage>(context,listen: false).updatePage(context,TimeOffPageEnum.summary);
                                  }
                                }
                              });
                            },
                            employeeInfoMapper: employeeData.getEmployee(),
                          );
                        }
                    );
                  }
              ),
                checkEmployeeIfExistInCurrentCompany: Provider.of<GlobalSelectedEmployeeController>(context,listen: false).checkIfCurrentUserCompanyMatches(),
                employeeChangeCurrentCompanyTap: (){
                  EmployeeSearchBottomSheet().show(
                      context,
                          (employeeInfoMapper)
                      {
                        EmployeeSearchBottomSheet().show(
                            context,
                                (employeeInfoMapper)
                            {
                              TimeOffCurrentPage timeOffCurrentPage = Provider.of<TimeOffCurrentPage>(context,listen: false);
                              if(timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.timeOff)
                              {
                                Provider.of<TimeOffCurrentPage>(context,listen: false).updatePage(context,TimeOffPageEnum.timeOff);
                              }
                              else if(timeOffCurrentPage.timeOffPageEnum == TimeOffPageEnum.summary)
                              {
                                Provider.of<TimeOffCurrentPage>(context,listen: false).updatePage(context,TimeOffPageEnum.summary);
                              }
                            }
                        );
                      }
                  );
                }
            );
          }


        // Scaffold(
        //   backgroundColor: const Color(MyColor.colorWhite),
        //   appBar: AppBar(
        //     elevation: 0,
        //     backgroundColor: const Color(MyColor.colorWhite),
        //     toolbarHeight: 0,
        //   ),
        //   body: SlidingUpPanel(
        //       maxHeight: ScreenSize(context).heightOnly(90),
        //       minHeight: 0,
        //       isDraggable: false,
        //       panelSnapping: true,
        //       defaultPanelState: PanelState.CLOSED,
        //       controller: panelController,
        //       parallaxEnabled: true,
        //       backdropEnabled: true,
        //       backdropColor: const Color(MyColor.colorGreySecondary),
        //       header: TimeOffPanelHeader(),
        //       parallaxOffset: .5,
        //       panelBuilder: (sc) => TimeOffPanel(sc,panelController),
        //       borderRadius: const BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        //       body: NestedScrollView(
        //         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        //           return <Widget>[
        //             SliverAppBar(
        //                 automaticallyImplyLeading: false,
        //                 pinned: false,
        //                 floating: true,
        //                 backgroundColor: const Color(MyColor.colorWhite),
        //                 snap: true,
        //                 elevation: 2,
        //                 titleSpacing: 0,
        //                 title: AppBarWidgetTimeOff('${CallSettingsKeyWords.get(context, LanguageCodes.TimeOff)}')
        //             ),
        //           ];
        //         },
        //         body: Consumer<CheckInternetConnection>(
        //             builder: (context,data,child) {
        //               if(data.internetConnectionEnum == InternetConnectionEnum.available)
        //               {
        //                 return TimeOffMainPage();
        //               }
        //               else
        //               {
        //                 return NotAvailable(GetAssets.internetAnim, '${CallSettingsKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallSettingsKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
        //               }
        //             }
        //         ),
        //       )
        //   ),
        // ),
      ),
    );
  }
}


class TimeOffMainPage extends StatefulWidget {
  TimeOffMainPage({Key? key}) : super(key: key);

  @override
  State<TimeOffMainPage> createState() => _TimeOffMainPageState();
}

class _TimeOffMainPageState extends State<TimeOffMainPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<TimeOffModelListener>(context,listen: false).start(context,ApiStatus.started);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInternetConnection>(
        builder: (context,data,child) {
          if(data.internetConnectionEnum == InternetConnectionEnum.available)
          {
            return Column(
              children: [
                HeaderWidget(),
                SizedBox(height: ScreenSize(context).heightOnly( 2),),
                const Expanded(child: ListWidget())
              ],
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
class HeaderWidget extends StatelessWidget {
  late BuildContext mContext;
  HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return Container(
      height: ScreenSize(context).heightOnly( 6.5),
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      width: double.maxFinite,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(MyColor.colorGrey6)
      ),
      child: Consumer<TimeOffCurrentPage>(
          builder: (context, data, child) {
            return Row(
              children: [
                Expanded(
                    child: CustomTabsHeaderCircleElevated(data.timeOffPageEnum == TimeOffPageEnum.timeOff?true:false,'${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffMainpageHeader1)}',timeOffClick)
                ),
                Expanded(
                    child: CustomTabsHeaderCircleElevated(data.timeOffPageEnum == TimeOffPageEnum.summary?true:false,'${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffMainpageHeader2)}',summaryClick)
                ),
                Expanded(
                    child: CustomTabsHeaderCircleElevated(data.timeOffPageEnum == TimeOffPageEnum.holiday?true:false,'${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffMainpageHeader3)}',holidayClick)
                )
              ],
            );
          }
      ),
    );
  }
  void timeOffClick()
  {
    //Provider.of<EmployeeSearchController>(mContext,listen: false).justUpdatePage(EmployeeCalledForPage.timeOff);
    Provider.of<TimeOffCurrentPage>(mContext,listen: false).updatePage(mContext,TimeOffPageEnum.timeOff);
  }
  void summaryClick()
  {
    // Provider.of<EmployeeSearchController>(mContext,listen: false).justUpdatePage(EmployeeCalledForPage.summary);
    Provider.of<TimeOffCurrentPage>(mContext,listen: false).updatePage(mContext,TimeOffPageEnum.summary);
  }
  void holidayClick()
  {
    // Provider.of<EmployeeSearchController>(mContext,listen: false).justUpdatePage(EmployeeCalledForPage.holidays);
    Provider.of<TimeOffCurrentPage>(mContext,listen: false).updatePage(mContext,TimeOffPageEnum.holiday);
  }
}
class ListWidget extends StatelessWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeOffCurrentPage>(
        builder: (context,data,child) {
          if(data.timeOffPageEnum == TimeOffPageEnum.timeOff) {
            return TimeOffListWidget(data.timeOffPageEnum);
          }
          else if(data.timeOffPageEnum == TimeOffPageEnum.holiday) {
            return HolidayPage(data.timeOffPageEnum);
          }
          else
          {
            return SummaryWidget(data.timeOffPageEnum);
          }
        }
    );
  }
}

