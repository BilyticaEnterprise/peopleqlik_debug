import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_get_form_mapper.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';

class GetDateFormats
{
  String? getFilterDate(String? date)
  {
    String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
      DateTime dateParsed = myFormat.parse(date!,true);
      filteredDate = DateFormat.yMMMd("en_US").format(dateParsed);
      return filteredDate;
    }catch(e){
      return '';
    }
  }
  String? getFilterDateTime(String? date)
  {
    String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
      DateTime dateParsed = myFormat.parse(date!,true);
      filteredDate = DateFormat.yMMMMEEEEd("en_US").add_jm().format(dateParsed);
      return filteredDate;
    }catch(e){
      return '';
    }
  }
  String? getDayName(DateTime? dateParsed)
  {
    String? filteredDate;
    try{
      filteredDate = DateFormat.EEEE("en_US").format(dateParsed!);
      return filteredDate;
    }catch(e){
      return '';
    }
  }
  String? getFilterDateTimeFormat(DateTime? dateParsed)
  {
    String? filteredDate;
    try{
      filteredDate = DateFormat.yMMMd("en_US").format(dateParsed!);
      return filteredDate;
    }catch(e){
      return '';
    }
  }
  String? getMonthOnly(DateTime? dateParsed)
  {
    String? filteredDate;
    try{
      filteredDate = DateFormat.yMMM("en_US").format(dateParsed!);
      return filteredDate;
    }catch(e){
      return '';
    }
  }
  String? getFilterMonth1(String? date)
  {
    //String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
      DateTime dateParsed = myFormat.parse(date!,true);
      DateFormat newFormat = DateFormat("MM/dd/yyyy");
      return newFormat.format(dateParsed);
    }catch(e){
      return null;
    }
  }
  String? getFilterTime(String? date)
  {
    String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
      DateTime dateParsed = myFormat.parse(date!,true);
      filteredDate = DateFormat.Hms("en_US").format(dateParsed);
      return filteredDate;
    }catch(e){
      return '';
    }
  }

  String? getFilterTime1(String? date)
  {
    String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
      DateTime dateParsed = myFormat.parse(date!,true);
      filteredDate = DateFormat("HH:mm").format(dateParsed);
      return filteredDate;
    }catch(e){
      return '';
    }
  }
  String? getFilterTime2(String? date)
  {
    String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("HH:mm");
      DateTime dateParsed = myFormat.parse(date!,true);
      filteredDate = DateFormat("HH:mm a").format(dateParsed);
      return filteredDate;
    }catch(e){
      return '';
    }
  }
  String? getFilterTime3(String? date)
  {
    String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("HH:mm");
      DateTime dateParsed = myFormat.parse(date!,true);
      filteredDate = DateFormat("HH:mm").format(dateParsed);
      return filteredDate;
    }catch(e){
      return '';
    }
  }
  String? getFilterTime4(String? date)
  {
    String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("HH:mm");
      DateTime dateParsed = myFormat.parse(date!,true);
      filteredDate = DateFormat("hh:mm a").format(dateParsed);
      return filteredDate;
    }catch(e){
      return '';
    }
  }
  String? getYMEDtoYYYYMMDD(String? date)
  {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    DateTime dateTime = dateFormat.parse(date!);
    DateFormat myFormat = DateFormat("yyyy-MM-dd");
    String dateParsed = myFormat.format(dateTime);
    return dateParsed;
  }
  DateTime? getMonthDay(String? date)
  {
    //String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
      DateTime dateParsed = myFormat.parse(date!);
      return dateParsed;
    }catch(e){
      return null;
    }
  }
  String? getMonthDayIntoString(DateTime? date)
  {
    //String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
      return myFormat.format(date!);
    }catch(e){
      return null;
    }
  }
  String? getMonthFormatDay(DateTime? date)
  {
    //String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("MM/dd/yyyy");
      String dateParsed = myFormat.format(date!);
      return dateParsed;
    }catch(e){
      return null;
    }
  }
  DateTime? getMonthFormatDateTime(String? date)
  {
    //String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("MM/dd/yyyy");
      return myFormat.parse(date!);
    }catch(e){
      return null;
    }
  }
  String? getSpecialDateInAhsanShakaFormat(String date)
  {
    try{
      DateFormat parser = DateFormat("yyyy-MM-ddTHH:mm");
      DateFormat myFormat = DateFormat("yyyy-MM-dd HH:mm");
      DateTime receivedTime = parser.parse(date);
      DateTime nowTime = DateTime.now();
      if(nowTime.subtract(const Duration(seconds: 30)).isAfter(receivedTime))
        {
          String dateParsed = myFormat.format(nowTime.add(const Duration(minutes: 10)));
          return dateParsed;
        }
      else
        {
          String dateParsed = myFormat.format(receivedTime.add(const Duration(minutes: 10)));
          return dateParsed;
        }
    }catch(e){
      return null;
    }
  }
  String? getMonthAndTimeFormat(DateTime? date)
  {
    //String? filteredDate;
    try{
      DateFormat myFormat = DateFormat("MM/dd/yyyy HH:mm");
      String dateParsed = myFormat.format(date!);
      return dateParsed;
    }catch(e){
      return null;
    }
  }

  String? getFormatDate(DateTime? date)
  {
    try{
      DateFormat myFormat = DateFormat("yyyy-MM-dd");
      String dateParsed = myFormat.format(date!);
      return dateParsed;
    }catch(e){
      return null;
    }

  }
  String? getSpecialFormatDate(DateTime? date)
  {
    try{
      DateFormat myFormat = DateFormat.yMMMEd();
      String dateParsed = myFormat.format(date!);
      return dateParsed;
    }catch(e){
      return null;
    }

  }
  int? formatCalculateTimeOnly(String start,String end)
  {
    try{
      DateFormat dateFormat = DateFormat("HH:mm");

      DateTime startParsed = dateFormat.parse(start);
      DateTime endParsed = dateFormat.parse(end);
      int minutes = endParsed.difference(startParsed).inMinutes;
      return minutes;
    }catch(e){
      return 0;
    }
  }
  int? formatCalculateTime(String start,String end)
  {

    try{
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

      DateTime startParsed = dateFormat.parse(start);
      DateTime endParsed = dateFormat.parse(end);
      int minutes = endParsed.difference(startParsed).inMinutes;

      PrintLogs.printLogs(minutes);
      return minutes;
    }catch(e){
      return 0;
    }
  }
  bool? dateIsAfter(String start,String end)
  {
    try{
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");

      DateTime startParsed = dateFormat.parse(start);
      DateTime endParsed = dateFormat.parse(end);

      if(endParsed.isBefore(startParsed))
        {
          return false;
        }
      else {
        return true;
      }
    }catch(e){
      return true;
    }
  }
  // int? calculateDate(String startDate,String endDate)
  // {
  //   try{
  //     DateFormat dateFormat = DateFormat("HH:mm");
  //     //DateFormat myLastFormat = DateFormat("HH:mm");
  //     DateTime startParsed = dateFormat.parse(startDate);
  //     int minutes = 0;
  //     if(endDate.isNotEmpty)
  //       {
  //         DateTime endParsed = dateFormat.parse(endDate);
  //         minutes = endParsed.difference(startParsed).inMinutes;
  //       }
  //    // PrintLogs.printLogs('ayaaa');
  //     if(minutes == 0)
  //       {
  //       //  PrintLogs.printLogs('vicHHh ayaaa');
  //         String endIs = dateFormat.format(DateTime.now());
  //         DateTime endParsed = dateFormat.parse(endIs);
  //         minutes = endParsed.difference(startParsed).inMinutes;
  //         return minutes;
  //       }
  //     else{
  //       return minutes;
  //     }
  //
  //   }catch(e){
  //     return 0;
  //   }
  // }
  int? calculateFormDate(String startDate,String endDate)
  {
    try{
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      //DateFormat myLastFormat = DateFormat("HH:mm");
      DateTime startParsed = dateFormat.parse(startDate);
      int days = 0;
        DateTime endParsed = dateFormat.parse(endDate);
        days = endParsed.difference(startParsed).inDays;

        return days;
    }catch(e){
     // PrintLogs.printLogs('carr ${e.toString()}');
      return 0;
    }
  }
  int? calculateTFormDate(String startDate,String endDate, List<ShiftInfo>? shiftInfo, bool? includeWeedEnd)
  {
    try{
      DateTime startParsed = DateTime.parse(startDate);
      DateTime endParsed = DateTime.parse(endDate);
      int count = getDaysListInBetween(DateTime(startParsed.year, startParsed.month, startParsed.day),DateTime(endParsed.year, endParsed.month, endParsed.day),shiftInfo,includeWeedEnd);
     // PrintLogs.printLogs('counttt $count');
      return count;
    }catch(e){
      return 0;
    }
  }
  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }
  int daysTotalDaysBetween(String startDate,String endDate)
  {
    int count = 0;
    DateTime startParsed = DateTime.parse(startDate);
    DateTime endParsed = DateTime.parse(endDate);
    DateTime from = DateTime(startParsed.year, startParsed.month, startParsed.day);
    DateTime to = DateTime(endParsed.year, endParsed.month, endParsed.day);
    for (int i = 0; i <= (to.difference(from).inHours / 24).round(); i++) {
      count++;
    }
    return count;
  }
  int getDaysListInBetween(DateTime startDate, DateTime endDate, List<ShiftInfo>? shiftInfo, bool? includeWeedEnd) {
    int count = 0;
    for (int i = 0; i <= (endDate.difference(startDate).inHours / 24).round(); i++) {
      DateTime dateTime = DateTime(
              startDate.year,
              startDate.month,
              // In Dart you can set more than. 30 days, DateTime will do the trick
              startDate.day + i);
      PrintLogs.printLogs('incluee $includeWeedEnd');
      if(includeWeedEnd==null||includeWeedEnd == true)
        {
          count ++;
        }
      else{
        if(DateFormat('EEEE').format(dateTime).toUpperCase() == 'MONDAY'&&shiftInfo?[0].offDay==false)
        {
          count++;
        }
        else if(DateFormat('EEEE').format(dateTime).toUpperCase() == 'TUESDAY'&&shiftInfo?[1].offDay==false)
        {
          count++;
        }
        else if(DateFormat('EEEE').format(dateTime).toUpperCase() == 'WEDNESDAY'&&shiftInfo?[2].offDay==false)
        {
          count++;
        }
        else if(DateFormat('EEEE').format(dateTime).toUpperCase() == 'THURSDAY'&&shiftInfo?[3].offDay==false)
        {
          count++;
        }
        else if(DateFormat('EEEE').format(dateTime).toUpperCase() == 'FRIDAY'&&shiftInfo?[4].offDay==false)
        {
          count++;
        }
        else if(DateFormat('EEEE').format(dateTime).toUpperCase() == 'SATURDAY'&&shiftInfo?[5].offDay==false)
        {
         // PrintLogs.printLogs('saturrrrr');
          count++;
        }
        else if(DateFormat('EEEE').format(dateTime).toUpperCase() == 'SUNDAY'&&shiftInfo?[6].offDay==false)
        {
          count++;
        }
      }

    }
    return count;
  }
  String? formatIntoYYYYMMDDDate(String date)
  {
    try{
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateFormat confirmedDateFormat = DateFormat("yyyy-MM-dd");
      //DateFormat myLastFormat = DateFormat("HH:mm");
      DateTime startParsed = dateFormat.parse(date);
      int days = 0;
      String endParsed = confirmedDateFormat.format(startParsed);

      return endParsed;
    }catch(e){
      return '';
    }
  }
  String? formatInto24HourTime(String time)
  {
    try{
      DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
      DateFormat confirmedDateFormat = DateFormat("HH:mm");
      //DateFormat myLastFormat = DateFormat("HH:mm");
      DateTime startParsed = dateFormat.parse(time);
      int days = 0;
      String endParsed = confirmedDateFormat.format(startParsed);

      return endParsed;
    }catch(e){
      return '';
    }
  }
  List<DateTime> getDaysInBetween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      DateTime d = startDate.add(Duration(days: i));
      days.add(DateTime(d.year,d.month,d.day));
    }
    return days;
  }
  getTimeWithDuration(BuildContext context,int minutes)
  {
    int hours = minutes ~/ 60; // Integer division to get the hours
    int remainingMinutes = minutes % 60; // Modulo operator to get the remaining minutes

    if(hours>0)
      {
        if(hours==1&&remainingMinutes==0)
          {
            return '${hours} ${CallLanguageKeyWords.get(context, LanguageCodes.hour)}';
          }
        else
          {

            return '${DateFormat('H:mm').format(DateTime(1996,1,1,hours,remainingMinutes))} ${CallLanguageKeyWords.get(context, LanguageCodes.hours)}';
          }
      }
    else
      {
        if(remainingMinutes==1)
          {
            return '${remainingMinutes} ${CallLanguageKeyWords.get(context, LanguageCodes.minute)}';
          }
        else
          {
            return '${remainingMinutes} ${CallLanguageKeyWords.get(context, LanguageCodes.minutes)}';
          }
      }
  }
  Duration getDurationObjectFromMinutes(int minutes) {
    // print('duration ${duration}');
    int hours = minutes ~/ 60; // Integer division to get the hours
    int remainingMinutes = minutes % 60; // Modulo operator to get the remaining minutes
    return Duration(hours: hours,minutes: remainingMinutes);
  }
  String? calculateDaysAgo(String date)
  {
    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    DateTime notificationParsed = dateFormat.parse(date);
    var totalDays = DateTime.now().difference(notificationParsed).inDays;
   // PrintLogs.printLogs('ttttt $totalDays');
    if(totalDays>0)
      {
        if(totalDays<3)
          {
            return '$totalDays day ago';
          }
        else {
          return '$totalDays days ago';
        }
      }
    else
      {
        var totalHours = DateTime.now().difference(notificationParsed).inHours;
        if(totalHours>0)
          {
            return '$totalHours hours ago';
          }
        else{
          var totalMinutes = DateTime.now().difference(notificationParsed).inMinutes;
          return '$totalMinutes minutes ago';
        }
      }

  }
  bool? calculateTokenExpiry(String date)
  {
    DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
    DateTime notificationParsed = dateFormat.parse(date);
    var totalMinutesLeft = notificationParsed.difference(DateTime.now()).inMinutes;
    if(totalMinutesLeft>1)
      {
        return true;
      }
    else{
      return false;
    }

  }

  String getDuration(Duration duration) {
   // print('duration ${duration}');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)} : $twoDigitMinutes";
  }
  int getDeductWeekendDays(int askedLeaveDays, int canDoHolidayInOneWeek) {
     double? remainder = askedLeaveDays.remainder(7);
     int totalWeeks = 0;
    // int leaveBalance = 0;
    // int totalDays = 0;
    //
     //PrintLogs.print('')
     if(remainder != 0)
      {

        double weeks  = (askedLeaveDays/7)+1;
        totalWeeks = weeks.toInt();
      }
    else
      {
        double weeks  = (askedLeaveDays/7);
        totalWeeks = weeks.toInt();

      }
    ///Lets say askedLeaveDays = 20 and canDoHolidayInOneWeek = 3
    // totalDays = totalWeeks.toInt()*7;
    // int totalCanDoInWeeks = canDoHolidayInOneWeek * totalWeeks;

     /// Line 1: Dividing total number of leaves with 7 (as One week equals 7)
     int ans = askedLeaveDays~/7;

     /// Line 2:
     /// answer one which will be added with bonusLeaves2 and here lets say user has asked for
     /// 20 day leave so in the above line we divide 20 by 7 and so answer is 2.something and then we multiple
     /// 2.something with User allowed holidays in one week now we have user 2 weeks leaves which is his right
     int bonusLeaves1 = ans * canDoHolidayInOneWeek;

     /// Line 3:
     /// now we have 'ans' is 2.something which we get from Line 1 and multiplied by 7 now we have 14 answer
     int leavesCalculated = ans * 7;
     /// Line 4: the answer we get line Line 3 is 14 and we Minus this 14 value with total number leaves
     /// user has applied for 'askedLeaveDays' and answer is 6
     int lastWeekDays = askedLeaveDays - leavesCalculated;

     /// so we get 6 left holidays to calculate and first we will minus 7 with user allowed leaves in one week which was 3
     /// so we get 4 as answer
     int l1 = 7 - canDoHolidayInOneWeek;
     /// Then we minus 6 with 4 so we get 3 as answer
     int bonusLeaves2 = lastWeekDays - l1;
     ///Now we know that user can do 3 holidays in one week so if he applied for 20 days then he can do
     /// 9 holidays as total of Three weeks as in above all scenarios we calculated two weeks data already
     /// and answer was 14 in Line 3 now we know if 6 left from 7 days of week to calculate then user is
     /// allowed to do 2 days of leave because only 6 days were left to calculate and
     /// user was allowed of 3 holidays in a week
     int totalOffBonusLeaves = 0;
     if(bonusLeaves2>0)
       {
         totalOffBonusLeaves = bonusLeaves1+bonusLeaves2;
       }
     else
       {
         totalOffBonusLeaves = bonusLeaves1;
       }

    //PrintLogs.print('dsf totalweekDays $totalOffBonusLeaves askedLeaveDaysasked = $askedLeaveDays totalCanDoInWeeks = $totalCanDoInWeeks \n canDoHolidayInOneWeek $canDoHolidayInOneWeek ');
     return totalOffBonusLeaves;
  }
  String? getDateSeparation(String date,{dynamic daysTotalToAdd})
  {
    DateFormat dateFormat = DateFormat("MM/dd/yyyy");
    DateTime dateTime = dateFormat.parse(date);
    DateTime addedDateTime = dateTime.add(Duration(days: daysTotalToAdd??0));
    return dateFormat.format(addedDateTime);
 }
  String getDateTimeInDMMMY(DateTime? date) {
    try{
      DateFormat myFormat = DateFormat("MMM dd,yyyy");
      String dateParsed = myFormat.format(date!);
      return dateParsed;
    }catch(e){
      return '';
    }
  }

  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String threeDigits(int n) => n.toString().padLeft(3, "0");

}