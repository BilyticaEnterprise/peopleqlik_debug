import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/Packages/CalendarWidget/Listeners/calendar_listener.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:provider/provider.dart';

import '../../../BusinessLogicModel/Enums/apistatus_enum.dart';
import '../../../UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import '../../../src/colors.dart';
import '../../../src/fonts.dart';
import '../../../src/icons.dart';
import '../../../src/screen_sizes.dart';

class CalendarWidget extends StatelessWidget {
  final Function(dynamic) onDayPressedDate;
  final Function(dynamic)? onDayPressedEvent;
  final Function() getPreviousMonth;
  final DateTime currentDate;
  final double? calendarHeight;
  final Function() getNextMonth;
  final bool? monthFormatWeek;
  final GlobalKey globalKey;
  final DateTime? minSelectedDate,maxSelectedDate;
  const CalendarWidget({required this.globalKey,required this.onDayPressedDate,this.minSelectedDate,this.maxSelectedDate,this.calendarHeight,this.monthFormatWeek = false,this.onDayPressedEvent,required this.getPreviousMonth,required this.getNextMonth,required this.currentDate,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _CalendarView(globalKey: globalKey,onDayPressedDate: onDayPressedDate,minSelectedDate: minSelectedDate,maxSelectedDate: maxSelectedDate,calendarHeight: calendarHeight,monthFormatWeek: monthFormatWeek,onDayPressedEvent: onDayPressedEvent,getNextMonth: getNextMonth,getPreviousMonth: getPreviousMonth,key: key,);

  }
}
class _CalendarView extends StatefulWidget {
  final Function(dynamic) onDayPressedDate;
  final Function(dynamic)? onDayPressedEvent;
  final Function() getPreviousMonth;
  final Function() getNextMonth;
  final double? calendarHeight;
  final DateTime? minSelectedDate,maxSelectedDate;
  final bool? monthFormatWeek;
  final GlobalKey globalKey;
  const _CalendarView({required this.globalKey,required this.onDayPressedDate,this.minSelectedDate,this.calendarHeight,this.maxSelectedDate,this.monthFormatWeek,this.onDayPressedEvent,required this.getPreviousMonth,required this.getNextMonth,Key? key}) : super(key: key);

  @override
  State<_CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<_CalendarView> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<CalendarCollector>(
        key: widget.globalKey,
        builder: (context,data,snapshot) {
          if(data.apiStatus == ApiStatus.done) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                if(widget.monthFormatWeek != true)...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(5.6)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                          child: Material(
                            color: const Color(MyColor.colorTransparent),
                            child: InkWell(
                              splashColor: const Color(MyColor.colorGrey0),
                              onTap: widget.getPreviousMonth,
                              child: Padding(
                                padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0)),
                                child: SvgPicture.string(
                                  SvgPicturesData.arrowBack,
                                  height: ScreenSize(context).heightOnly( 3.0),
                                  width: ScreenSize(context).heightOnly( 3.0),
                                  color: const Color(MyColor.colorBlack),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                            child: Text(
                              DateFormat.yMMM().format(data.currentDate),
                              style: GetFont.get(
                                  context,
                                  fontSize: 2.0,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorPrimary
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
                              onTap: widget.getNextMonth,
                              child: Padding(
                                padding: EdgeInsets.all(ScreenSize(context).heightOnly(0)),
                                child: SvgPicture.string(
                                  SvgPicturesData.arrowNext,
                                  height: ScreenSize(context).heightOnly(3.0),
                                  width: ScreenSize(context).heightOnly( 3.0),
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
                ],
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 3.0)),
                    child: CalendarCarousel<Event>(
                      todayBorderColor: const Color(MyColor.colorWhite),
                      onDayPressed: (date, events) {
                        data.currentDate = date;
                        data.notifyListenersData();
                        widget.onDayPressedDate(date);
                        if(events!=null&&widget.onDayPressedEvent!=null)
                          {
                            for (var event in events) {
                              widget.onDayPressedEvent!(event);
                            }
                          }

                      },
                      markedDateIconBuilder: (event) {
                        return event.icon ?? const Icon(Icons.help_outline);
                      },
                      leftButtonIcon: Icon(Icons.arrow_back_ios,color: const Color(MyColor.colorGrey3),size: ScreenSize(context).heightOnly( 2.4),),
                      rightButtonIcon: Icon(Icons.arrow_forward_ios_sharp,color: const Color(MyColor.colorGrey3),size: ScreenSize(context).heightOnly( 2.4),),
                      headerMargin: EdgeInsets.only(top: 0,bottom: ScreenSize(context).heightOnly(1.4)),
                      showHeader: true,
                      dayPadding: ScreenSize(context).heightOnly(0.50),
                      markedDateShowIcon: true,
                      showIconBehindDayText: true,
                      daysHaveCircularBorder: true,
                      markedDateCustomShapeBorder: const CircleBorder(side: BorderSide(color: Colors.white)),
                      showOnlyCurrentMonthDate: false,
                      weekendTextStyle: GetFont.get(
                        context,
                        fontSize:1.6,
                        fontWeight: FontWeight.w400,
                        color: MyColor.colorRed,
                      ),
                      headerTextStyle: GetFont.get(
                        context,
                        fontSize:2.2,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorPrimary,
                      ),
                      weekdayTextStyle: GetFont.get(
                        context,
                        fontSize:1.6,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorBlack,

                      ),
                      daysTextStyle: GetFont.get(
                        context,
                        fontSize:1.6,
                        fontWeight: FontWeight.w500,
                        color: MyColor.colorBlack,
                      ),
                      thisMonthDayBorderColor: Colors.white,
                      weekFormat: widget.monthFormatWeek??false,
                      height: ScreenSize(context).heightOnly(widget.calendarHeight??40),
                      selectedDateTime: data.currentDate,
                      targetDateTime: data.currentDate,
                      customGridViewPhysics: const NeverScrollableScrollPhysics(),
                      markedDateCustomTextStyle: TextStyle(
                        fontSize: ScreenSize(context).heightOnly( 1.8),
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      markedDatesMap: data.markedDateMap,
                      pageScrollPhysics: const NeverScrollableScrollPhysics(),
                      todayTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenSize(context).heightOnly( 1.8),
                        fontWeight: FontWeight.w600,
                      ),
                      markedDateMoreShowTotal: false,
                      markedDateIconMaxShown: 1,
                      todayButtonColor: Color(MyColor.colorA5),
                      selectedDayTextStyle: const TextStyle(
                        color: Colors.white,
                      ),
                      selectedDayButtonColor: const Color(MyColor.colorPrimary),
                      selectedDayBorderColor: const Color(MyColor.colorWhite),
                      disableDayPressed: false,
                      minSelectedDate: widget.minSelectedDate??DateTime.now().subtract(const Duration(days: 1080)),
                      maxSelectedDate: widget.maxSelectedDate??DateTime.now().add(const Duration(days: 1080)),
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
                        data.targetDateTime = date;
                        //data.notifyListenersData();
                      },
                      onDayLongPressed: (DateTime date) {
                        print('long pressed date $date');
                      },
                    ),
                  ),
                ),
              ],
            );
          }
          else
          {
            return Container();
          }
        }
    );
  }
}
