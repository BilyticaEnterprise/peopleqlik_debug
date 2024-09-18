import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TimeSheetListener/get_time_sheet_listener.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';

class EmployeeCalenderView extends StatefulWidget {
  List<ForUiDatesList>? datesList;
  DateTime callApiDate;
  BuildContext? context;
  EmployeeCalenderView(this.datesList,this.callApiDate,this.context,{Key? key}) : super(key: key);

  @override
  _EmployeeCalenderViewState createState() => _EmployeeCalenderViewState();
}

class _EmployeeCalenderViewState extends State<EmployeeCalenderView> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CalendarCollector>(context,listen: false).startCalender(widget.datesList,widget.callApiDate);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<CalendarCollector>(
      builder: (context,data,snapshot) {
        if(data.apiStatus == ApiStatus.done) {
          return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Material(
                      color: const Color(MyColor.colorTransparent),
                      child: InkWell(
                        splashColor: const Color(MyColor.colorGrey0),
                        onTap: (){
                          Provider.of<GetTimeSheetListener>(context,listen: false).previousMonthButton();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0)),
                          child: SvgPicture.string(
                            SvgPicturesData.arrowBack,
                            height: ScreenSize(context).heightOnly( 3.5),
                            width: ScreenSize(context).heightOnly( 3.5),
                            color: const Color(MyColor.colorBlack),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Text(
                      DateFormat.yMMM().format(widget.callApiDate),
                        style: GetFont.get(
                            context,
                          fontSize: 1.8,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                        ),
                        textAlign: TextAlign.center,
                      )
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                    child: Material(
                      color: const Color(MyColor.colorTransparent),
                      child: InkWell(
                        splashColor: const Color(MyColor.colorGrey0),
                        onTap: (){
                          Provider.of<GetTimeSheetListener>(context,listen: false).nextMonthButton();
                        },
                        child: Padding(
                          padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0)),
                          child: SvgPicture.string(
                            SvgPicturesData.arrowNext,
                            height: ScreenSize(context).heightOnly( 3.5),
                            width: ScreenSize(context).heightOnly( 3.5),
                            color: const Color(MyColor.colorBlack),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 2),),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 4.6)),
              child: CalendarCarousel<Event>(
                todayBorderColor: const Color(MyColor.colorSecondary),
                onDayPressed: (date, events) {
                  //setState(() => data._currentDate2 = date);
                  data._currentDate2 = date;
                  data.notifyviewModelData();
                  for (var event in events) {
                    Provider.of<ShowDataAgainstEachDay>(context,listen: false).updateIndex(event.id!);
                  }

                },
                markedDateIconBuilder: (event) {
                  return event.icon ?? const Icon(Icons.help_outline);
                },
                // leftButtonIcon: Icon(Icons.arrow_back_ios,color: const Color(MyColor.colorGrey3),size: ScreenSize(context).heightOnly( 2.4),),
                // rightButtonIcon: Icon(Icons.arrow_forward_ios_sharp,color: const Color(MyColor.colorGrey3),size: ScreenSize(context).heightOnly( 2.4),),
                showHeader: false,
                dayPadding: ScreenSize(context).heightOnly(0.40),
                markedDateShowIcon: true,
                showIconBehindDayText: true,
                daysHaveCircularBorder: true,
                showOnlyCurrentMonthDate: false,
                weekendTextStyle: GetFont.get(
                  context,
                  fontSize:1.6,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorRed,
                ),
                weekdayTextStyle: GetFont.get(
                  context,
                  fontSize:1.6,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack,

                ),
                thisMonthDayBorderColor: Colors.grey,
                weekFormat: false,
                height: ScreenSize(context).heightOnly(42),
                selectedDateTime: data._currentDate2,
                targetDateTime: data._targetDateTime,
                customGridViewPhysics: const NeverScrollableScrollPhysics(),
                markedDateCustomShapeBorder: const CircleBorder(side: BorderSide(color: Colors.black)),
                markedDateCustomTextStyle: TextStyle(
                  fontSize: ScreenSize(context).heightOnly( 1.8),
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                markedDatesMap: data._markedDateMap,
                pageScrollPhysics: const NeverScrollableScrollPhysics(),
                todayTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenSize(context).heightOnly( 1.8),
                  fontWeight: FontWeight.w600,
                ),
                markedDateMoreShowTotal: false,
                markedDateIconMaxShown: 1,
                todayButtonColor: Colors.lightGreen,
                selectedDayTextStyle: const TextStyle(
                  color: Colors.black,
                ),
                selectedDayButtonColor: const Color(MyColor.colorWhite),
                selectedDayBorderColor: const Color(MyColor.colorBlack),
                disableDayPressed: false,

                minSelectedDate: widget.callApiDate.subtract(const Duration(days: 1080)),
                maxSelectedDate: widget.callApiDate.add(const Duration(days: 1080)),
                prevDaysTextStyle: TextStyle(
                  fontSize: ScreenSize(context).heightOnly( 1.6),
                  color: Colors.grey,
                ),
                inactiveDaysTextStyle: TextStyle(
                  color: Colors.tealAccent,
                  fontSize: ScreenSize(context).heightOnly( 1.6),
                ),
                onCalendarChanged: (DateTime date) {
                  print('changedsadasdas');
                    data._targetDateTime = date;
                    //data.notifyviewModelData();
                },
                onDayLongPressed: (DateTime date) {
                  print('long pressed date $date');
                },
              ),
            ),
          ],
        );
        }
        else if(data.apiStatus == ApiStatus.started)
          {
            return const CircularIndicatorCustomized();
          }
        else
          {
             return Container();
          }
      }
    );
  }
}
class ForUiDatesList
{
  DateTime? dateTime;
  DateType? dateType;
  Color? color;
  ForUiDatesList(this.dateTime,this.dateType,this.color);
}
enum DateType
{
  absent,late,present,earlyOut,leave,weekend,publicHoliday,futureDay,missingIn,missingOut,multiple,unKnown
}
class CalendarCollector extends GetChangeNotifier
{
  EventList<Event>? _markedDateMap;
  late DateTime _currentDate2;
  late DateTime _targetDateTime;
  ApiStatus apiStatus = ApiStatus.nothing;

  void startCalender(List<ForUiDatesList>? datesList, DateTime callApiDate)
  {
    _markedDateMap = null;
    print('datalend ${datesList?.length}');
    apiStatus = ApiStatus.started;
    notifyListeners();
    final lastDayOfMonth = DateTime(callApiDate.year, callApiDate.month + 1, 0);
    _currentDate2 = DateTime.now();
    _targetDateTime = lastDayOfMonth;
    _markedDateMap = null;
    print('indexxxsadasd ${datesList![0].dateTime}');
    addData(datesList[0],0);
    for(int x=1;x<datesList.length;x++)
    {
      print('indexxxsadasyd ${datesList[x].dateTime}');
      addData(datesList[x],x);
    }
    apiStatus = ApiStatus.done;
    notifyListeners();
  }
  notifyviewModelData()
  {
    notifyListeners();
  }
  addData(ForUiDatesList datesList,int id)
  {
    if(id==0)
    {
      print('ifid $id');
      _markedDateMap ??= EventList(events: {
        datesList.dateTime!:[
          Event(
            id: id,
            date:  datesList.dateTime!,
            title: 'Event 1',
            //icon: _eventIcon,
            icon: Container(
              // margin: const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                  color: datesList.color?.withOpacity(0.3)??const Color(MyColor.colorGrey0).withOpacity(0.3),
                  shape: BoxShape.circle),
              // height: ScreenSize(context).heightOnly(widget.context!, 0.8),
              // width: ScreenSize(context).heightOnly(widget.context!, 0.8),
            ),
          )]
      }
      );
    }
    else
    {
      print('elseid $id');
      _markedDateMap?.add(datesList.dateTime!,Event(
        id: id,
        date:  datesList.dateTime!,
        title: 'Event 2',
        icon: Container(
          decoration: BoxDecoration(
              color: datesList.color?.withOpacity(0.3)??const Color(MyColor.colorGrey0).withOpacity(0.3),
              shape: BoxShape.circle),

        ),
      ),);
    }

  }
}