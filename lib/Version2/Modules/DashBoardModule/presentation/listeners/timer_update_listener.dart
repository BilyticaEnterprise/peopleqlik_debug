import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:provider/provider.dart';

import '../../../../../utils/date_formats.dart';
import '../../../ModuleSetting/domain/repoImpl/settings_listeners.dart';

class TimerUpdateListener extends GetChangeNotifier
{
  int? _shiftMinutes = 0;

  Timer? timer;
  int? totalMinutes = 0;
  int? totalSeconds = 0;
  int? totalMilliseconds = 0;
  double? attendancePercent = 1;

  void makeCircleSpinnerReady(BuildContext context, int? alreadyTotalMinutes,String startTime,String endTime) {

    _shiftMinutes = GetDateFormats().formatCalculateTimeOnly(startTime,endTime);
    attendancePercent = ((alreadyTotalMinutes??0)/(_shiftMinutes??100))*100;

    totalMinutes = alreadyTotalMinutes;

    if((attendancePercent??0) < 1.0)
    {
      attendancePercent = 1;
    }
    notifyListeners();
  }

  startTimer(String? firstCheckIn,{int? alreadyTotalMinutes})
  {
    DateTime? date = GetDateFormats().getMonthDay(firstCheckIn);
    if(date!=null)
      {
        Duration differenceDuration = DateTime.now().difference(date);
        totalMinutes = alreadyTotalMinutes??differenceDuration.inMinutes;
        int secondsAre = differenceDuration.inSeconds;
        int _mins = (secondsAre/60).toInt();
        totalSeconds = secondsAre - (_mins*60);

        PrintLogs.printLogs('totalMinutestotalMinutes $totalMinutes $totalSeconds');
      }

    int seconds = totalSeconds??0;
    int currentMinute = totalMinutes??0;
    int currentMilliseconds = totalMilliseconds??0;

    timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if(currentMilliseconds == 999)
        {
          currentMilliseconds = 0;
          seconds++;
          totalSeconds = seconds;
          if(seconds == 60)
            {
              seconds = 0;
              currentMinute++;
              totalMinutes = currentMinute;
            }
        }
      else
        {
          currentMilliseconds++;
        }
      totalMilliseconds = currentMilliseconds;

      notifyListeners();
    });
  }

  closeTimer()
  {
    timer?.cancel();
  }
}