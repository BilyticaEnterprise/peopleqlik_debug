import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/Version1/viewModel/TimeSheetListener/get_time_sheet_listener.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/utils/double_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';
import '../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../utils/Appbars/generic_app_bar.dart';
import '../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../utils/MonthPicker/DatePicker/month_picker_dialog_2.dart';
import '../../../../configs/icons.dart';
import '../GlobalEmployeeSearchUi/call_employee_search_ui.dart';
import 'calender_view.dart';

class TimeSheetPage extends StatelessWidget {

  TimeSheetPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   // final _controller = GlobalKey<AdvancedPageTurnState>();
    return
    //   Scaffold(
    //   body: AdvancedPageTurn(
    //     key: _controller,
    //     backgroundColor: Colors.white,
    //     showDragCutoff: false,
    //     duration: Duration(milliseconds: 200),
    //     lastPage: Container(child: Center(child: Text('Last Page!'))),
    //     children: <Widget>[
    //       for (var i = 0; i < 20; i++) PageView(page: i),
    //     ],
    //     initialIndex: 0,
    //     onPageChanged: (int currentPage){
    //       print("current page callback $currentPage");
    //     },
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     child: Icon(Icons.search),
    //     onPressed: () {
    //       _controller.currentState!.goToPage(2);
    //     },
    //   ),
    // );

      MultiProvider(
        providers: [
          ChangeNotifierProvider<ShowDataAgainstEachDay>(create: (_) => ShowDataAgainstEachDay()),
          ChangeNotifierProvider<CalendarCollector>(create: (_) => CalendarCollector())
        ],
        builder: (context, child){
          return GetPageStarterScaffoldStateLess(
            body: BodyData(),
            appBar: Consumer<GlobalSelectedEmployeeController>(
                builder: (context, employeeData, child) {
                  return EmployeeAppBarWidget(
                    CallLanguageKeyWords.get(context, LanguageCodes.timeSheetAppBar)??'',
                    selectEmployeeTap: () {
                      EmployeeSearchBottomSheet().show(
                          context,
                              (employeeInfoMapper)
                          {
                            Provider.of<GetTimeSheetListener>(context,listen: false).getCurrentMonth(DateTime.now());
                          }
                      );
                    },
                    removeEmployeeTap: () async {
                      await employeeData.resetEmployee();
                      Provider.of<GetTimeSheetListener>(context,listen: false).getCurrentMonth(DateTime.now());
                    },
                    hidePlusButton: true,
                    actionWidget: ClipRRect(
                      borderRadius:const BorderRadius.all(Radius.circular(5)),
                      child: Material(
                        color: const Color(MyColor.colorTransparent),
                        child: InkWell(
                          splashColor: const Color(MyColor.colorGrey0),
                          onTap:(){
                            GetTimeSheetListener data = Provider.of<GetTimeSheetListener>(context,listen: false);
                            if(data.calendarView == CalendarView.month)
                            {
                              showMonthPicker(
                                context: context,
                                firstDate: DateTime(DateTime.now().year - 1, 5),
                                lastDate: DateTime(DateTime.now().year + 1, 9),
                                initialDate: data.callApiDate ?? DateTime.now(),
                                locale: const Locale("en"),
                                selectedMonthTextColor: Color(MyColor.colorWhite),
                                selectedMonthBackgroundColor: Color(MyColor.colorPrimary),
                                headerTextColor: Color(MyColor.colorWhite),
                            ).then((date) {
                                if (date != null) {
                                  Provider.of<GetTimeSheetListener>(context,listen: false).getCurrentMonth(date);
                                }
                              });
                            }
                          },
                          child:  Padding(
                            padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.5)),
                            child: SvgPicture.string(Provider.of<GetTimeSheetListener>(context,listen: false).calendarView==CalendarView.month?SvgPicturesData.calendar:SvgPicturesData.back,width: ScreenSize(context).heightOnly( 3.0),height:ScreenSize(context).heightOnly( 3.0),color: Color(MyColor.colorBlack),),
                          ),
                        ),
                      ),
                    ),
                    employeeInfoMapper: employeeData.getEmployee(),
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
                            Provider.of<GetTimeSheetListener>(context,listen: false).getCurrentMonth(DateTime.now());
                          }
                      );
                    }
                );
              }
          );
        }


    //     Scaffold(
    //     backgroundColor: const Color(MyColor.colorWhite),
    //       appBar: AppBar(
    //         elevation: 0,
    //         backgroundColor: const Color(MyColor.colorWhite),
    //         toolbarHeight: 0,
    //       ),
    //     body: SlidingUpPanel(
    //       maxHeight: ScreenSize(context).heightOnly(90),
    //       minHeight: 0,
    //       isDraggable: false,
    //       panelSnapping: true,
    //       defaultPanelState: PanelState.CLOSED,
    //       controller: panelController,
    //       parallaxEnabled: true,
    //       backdropEnabled: true,
    //       backdropColor: const Color(MyColor.colorGreySecondary),
    //       header: TimeSheetPanelHeader(panelController),
    //       parallaxOffset: .5,
    //       panelBuilder: (sc) => const SearchEmployeeWidget(),
    //       borderRadius: const BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
    //       body: NestedScrollView(
    //           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
    //             return <Widget>[
    //               SliverAppBar(
    //                   automaticallyImplyLeading: false,
    //                   pinned: false,
    //                   floating: true,
    //                   backgroundColor: const Color(MyColor.colorWhite),
    //                   snap: true,
    //                   elevation: 2,
    //                   titleSpacing: 0,
    //                   title: AppBarTimeSheetWidget(panelController,'${CallSettingsKeyWords.get(context, LanguageCodes.timeSheetAppBar)}')
    //               ),
    //             ];
    //           },
    //           body: Consumer<CheckInternetConnection>(
    //               builder: (context, data, child) {
    //                 if (data.internetConnectionEnum ==
    //                     InternetConnectionEnum.available) {
    //                   return const BodyData();
    //                 }
    //                 else {
    //                   return NotAvailable(
    //                     GetAssets.internetAnim, '${CallSettingsKeyWords.get(context, LanguageCodes.stringsstr26)}',
    //                     '${CallSettingsKeyWords.get(context, LanguageCodes.stringsstr27)}', topMargin: 8,
    //                     width: 50,
    //                     height: 24,);
    //                 }
    //               }
    //           ),
    //         ),
    //     ),
    //
    // ),
      );
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
      Provider.of<GlobalSelectedEmployeeController>(context,listen: false).resetEmployee();
      Provider.of<GetTimeSheetListener>(context,listen: false).setContext(context);
      Provider.of<GetTimeSheetListener>(context,listen: false).getCurrentMonth(DateTime.now());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GetTimeSheetListener>(
      builder: (context, data, child) {
        if(data.apiStatus == ApiStatus.done) {
          return BodyWidget(data,key: Key('${data.callApiDate}opprt'),);
        }
        else if(data.apiStatus == ApiStatus.empty)
        {
          return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr52)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr53)}',topMargin: 8,width: 40,);
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
class BodyWidget extends StatefulWidget {
  final GetTimeSheetListener data;
  const BodyWidget(this.data, {Key? key}) : super(key: key);

  @override
  _BodyWidgetState createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: ScreenSize(context).heightOnly( 1.6),),
          EmployeeCalenderView(widget.data.forMiddleWidgetUiPerDayDatesList,widget.data.callApiDate!,context,key: Key('${widget.data.callApiDate}newkery'),),
          SizedBox(height: ScreenSize(context).heightOnly( 1.6),),
          Container(
            margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              color: const Color(MyColor.colorSecondary).withOpacity(0.05)
            ),
            child: Consumer<ShowDataAgainstEachDay>(
              builder: (context, updateSet, child) {
                if(widget.data.timeSheetResultSet!=null&&widget.data.timeSheetResultSet!.isNotEmpty&&widget.data.timeSheetResultSet?[updateSet.selectedIndex].statusID!=null&&updateSet.selectedIndex<widget.data.timeSheetResultSet!.length)
                  {
                    return Padding(
                      padding: EdgeInsets.all(ScreenSize(context).heightOnly(1.6)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            GetDateFormats().getFilterDateTimeFormat(widget.data.forMiddleWidgetUiPerDayDatesList?[updateSet.selectedIndex].dateTime)??'',
                            style: GetFont.get(
                                context,
                                fontSize: 2.2,
                                fontWeight: FontWeight.w600,
                                color: MyColor.colorBlack
                            ),
                          ),
                          SizedBox(height: ScreenSize(context).heightOnly( 3),),
                          FillWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceName)}', '${widget.data.timeSheetResultSet?[updateSet.selectedIndex].employeeName}'),
                          SizedBox(height: ScreenSize(context).heightOnly( 2),),
                          FillWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceCheckIn)}','${GetDateFormats().getFilterTime(widget.data.timeSheetResultSet?[updateSet.selectedIndex].timeIn)}'),
                          SizedBox(height: ScreenSize(context).heightOnly( 2),),
                          FillWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceCheckOut)}','${GetDateFormats().getFilterTime(widget.data.timeSheetResultSet?[updateSet.selectedIndex].timeOut)}'),
                          SizedBox(height: ScreenSize(context).heightOnly( 2),),
                          FillWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceStatus)}', '${widget.data.timeSheetResultSet?[updateSet.selectedIndex].statusName}')

                        ],
                      ),
                    );
                  }
                else
                  {
                    return Padding(
                      padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.6)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width:double.infinity,
                            child: Text(
                              GetDateFormats().getFilterDateTimeFormat(widget.data.forMiddleWidgetUiPerDayDatesList?[updateSet.selectedIndex].dateTime)??'',
                              style: GetFont.get(
                                  context,
                                  fontSize: 2.2,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorBlack
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(height: ScreenSize(context).heightOnly( 3),),
                          Text(
                            '${CallLanguageKeyWords.get(context, LanguageCodes.N1)}',
                            style: GetFont.get(
                                context,
                                fontSize: 1.6,
                                fontWeight: FontWeight.w400,
                                color: MyColor.colorBlack
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
              }
            ),
          ),
          if(widget.data.timeSheetResultSet!=null&&widget.data.timeSheetResultSet!.isNotEmpty)...[
            SizedBox(height: ScreenSize(context).heightOnly( 3),),
            Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  color: const Color(MyColor.colorSecondary).withOpacity(0.05)
              ),
              child: Padding(
                padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.6)),
                child: Column(
                  children: [
                    Text(
                      '${CallLanguageKeyWords.get(context, LanguageCodes.attendanceIn)} ${GetDateFormats().getMonthOnly(widget.data.callApiDate)}',
                      style: GetFont.get(
                          context,
                          fontSize: 2.2,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                      ),
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 3),),
                    FillWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceTotalPresent)}', '${DoubleFormat().format(widget.data.totalPresentPercent)} %'),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    FillWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceTotalAbsent)}','${DoubleFormat().format(widget.data.totalAbsentPercent)} %'),

                  ],
                ),
              ),
            ),
          ],
          SizedBox(height: ScreenSize(context).heightOnly( 3),),
          Container(
              margin: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 6.0),0,ScreenSize(context).widthOnly( 6.0),ScreenSize(context).heightOnly( 1.4)),
              decoration: BoxDecoration(
                  color: const Color(MyColor.colorSecondary).withOpacity(0.06),
                  borderRadius: const BorderRadius.all(Radius.circular(15))
              ),
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    CallLanguageKeyWords.get(context, LanguageCodes.attendanceAttendanceTypes)!.toUpperCase(),
                    style : GetFont.get(
                      context,
                      fontSize:1.8,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorBlack,
                    ),
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  Row(
                    children: [
                      Expanded(child: AttendanceTypeColorWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendancePresentInTime)}',MyColor.colorPrimary)),
                      SizedBox(width: ScreenSize(context).widthOnly( 2),),
                      Expanded(child: AttendanceTypeColorWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceLate)}',MyColor.colorClockOut)),
                      SizedBox(width: ScreenSize(context).widthOnly( 2),),
                      Expanded(child: AttendanceTypeColorWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceAbsent)}',MyColor.colorRed))
                    ],
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: AttendanceTypeColorWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceEarlyOut)}',MyColor.colorDarkBrown)),
                      SizedBox(width: ScreenSize(context).widthOnly( 2),),
                      Expanded(child: AttendanceTypeColorWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceMissingIn)}',MyColor.colorClockIn)),
                      SizedBox(width: ScreenSize(context).widthOnly( 2),),
                      Expanded(child: AttendanceTypeColorWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendancePublicHoliday)}',MyColor.colorSecondary))
                    ],
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(child: AttendanceTypeColorWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceWeekEnd)}',MyColor.colorWhite)),
                      SizedBox(width: ScreenSize(context).widthOnly( 2),),
                      Expanded(child: AttendanceTypeColorWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceMissingOut)}',MyColor.colorClockIn)),
                      SizedBox(width: ScreenSize(context).widthOnly( 2),),
                      Expanded(child: AttendanceTypeColorWidget('${CallLanguageKeyWords.get(context, LanguageCodes.attendanceLeave)}',MyColor.colorIndigo)),
                    ],
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(flex:1, child: AttendanceTypeColorWidget('${CallLanguageKeyWords.get(context, LanguageCodes.multiple)}',MyColor.colorBlack)),
                      SizedBox(width: ScreenSize(context).widthOnly( 2),),
                      Expanded(flex:2, child: Container()),
                    ],
                  )
                ],
              )
          ),
          SizedBox(height: ScreenSize(context).heightOnly(16),),
        ],
      ),
    );
  }
}
class FillWidget extends StatelessWidget {
  final String? header,value;
  const FillWidget(this.header,this.value,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            header??'',
            style: GetFont.get(
                context,
                fontSize: 1.8,
                fontWeight: FontWeight.w600,
                color: MyColor.colorGrey3
            ),
          ),
        ),
        Text(
          value??'',
          style: GetFont.get(
              context,
              fontSize: 1.8,
              fontWeight: FontWeight.w600,
              color: MyColor.colorBlack
          ),
        )
      ],
    );
  }
}

class AttendanceTypeColorWidget extends StatelessWidget {
  final int color;
  final String text;
  const AttendanceTypeColorWidget(this.text,this.color,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: ScreenSize(context).heightOnly( 3),
          width: ScreenSize(context).heightOnly( 0.8),
          decoration: BoxDecoration(
              color: Color(color).withOpacity(0.3),
              borderRadius: const BorderRadius.all(Radius.circular(5))
          ),
        ),
        SizedBox(width: ScreenSize(context).heightOnly( 1.2),),
        Flexible(
          child: Text(
            text,
            style : GetFont.get(
              context,
              fontSize:1.3,
              fontWeight: FontWeight.w600,
              color: MyColor.colorBlack,
            ),
          ),
        )
      ],
    );
  }
}


// class PageView extends StatelessWidget {
//   final int? page;
//
//   const PageView({Key? key, this.page}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTextStyle.merge(
//       style: TextStyle(fontSize: 16.0),
//       child: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Text(
//                   "CHAPTER $page",
//                   style: const TextStyle(
//                     fontSize: 32.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const Text(
//                   "Down the Rabbit-Hole",
//                   style:  TextStyle(
//                     fontSize: 24.0,
//                     fontWeight: FontWeight.w500,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 const SizedBox(height: 32.0),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Expanded(
//                       child: Text(
//                           "Alice was beginning to get very tired of sitting by her sister on the bank, and of"
//                               " having nothing to do: once or twice she had peeped into the book her sister was "
//                               "reading, but it had no pictures or conversations in it, `and what is the use of "
//                               "a book,' thought Alice `without pictures or conversation?'"),
//                     ),
//                     Container(
//                       margin: const EdgeInsets.only(left: 12.0),
//                       color: Colors.black26,
//                       width: 160.0,
//                       height: 220.0,
//                       child: Placeholder(),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16.0),
//                 Text(
//                   "So she was considering in her own mind (as well as she could, for the hot day made her "
//                       "feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be "
//                       "worth the trouble of getting up and picking the daisies, when suddenly a White "
//                       "Rabbit with pink eyes ran close by her.\n"
//                       "\n"
//                       "There was nothing so very remarkable in that; nor did Alice think it so very much out "
//                       "of the way to hear the Rabbit say to itself, `Oh dear! Oh dear! I shall be "
//                       "late!' (when she thought it over afterwards, it occurred to her that she ought to "
//                       "have wondered at this, but at the time it all seemed quite natural); but when the "
//                       "Rabbit actually took a watch out of its waistcoat-pocket, and looked at it, and then "
//                       "hurried on, Alice started to her feet, for it flashed across her mind that she had "
//                       "never before seen a rabbit with either a waistcoat-pocket, or a watch to take out "
//                       "of it, and burning with curiosity, she ran across the field after it, and fortunately "
//                       "was just in time to see it pop down a large rabbit-hole under the hedge.",
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
