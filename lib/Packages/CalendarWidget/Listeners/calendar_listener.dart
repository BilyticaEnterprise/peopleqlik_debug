import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';

import '../../../utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import '../../../Version1/views/BottomBarPages/TimeSheet/calender_view.dart';
import '../../../configs/colors.dart';

class CalendarCollector extends GetChangeNotifier
{
  EventList<Event>? _markedDateMap;
  late DateTime _currentDate;
  late DateTime _targetDateTime;

  ApiStatus apiStatus = ApiStatus.nothing;

  CalendarCollector(DateTime currentDate)
  {
    this.currentDate = currentDate;
  }


  void startCalender({List<ForUiDatesList>? datesList})
  {
    _markedDateMap = null;
    apiStatus = ApiStatus.started;
    notifyListeners();
    _targetDateTime = getLastDayOfMonth(currentDate);

    if(datesList!=null&&datesList.isNotEmpty)
      {
        addData(datesList[0],0);
        for(int x=1;x<datesList.length;x++)
        {
          addData(datesList[x],x);
        }
      }
    apiStatus = ApiStatus.done;
    notifyListeners();
  }
  notifyListenersData()
  {
    notifyListeners();
  }

  addData(ForUiDatesList datesList,int id)
  {
    if(id==0)
    {
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

  DateTime get currentDate => _currentDate;

  DateTime get targetDateTime => _targetDateTime;

  EventList<Event>? get markedDateMap => _markedDateMap;

  set currentDate(DateTime value) {
    _currentDate = value;
  }

  set targetDateTime(DateTime value) {
    _targetDateTime = value;
  }

  getLastDayOfMonth(DateTime dateTime)
  {
    return DateTime(dateTime.year, dateTime.month + 1, 0);
  }
}