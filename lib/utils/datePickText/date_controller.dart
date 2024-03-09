import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateController
{
  Function(DateReturn) callBack;
  DateTime? defaultTime; /// It is the date in which if we want to set a default value of both date and time in the date field
  DateTime? initialTimeForController; /// It is the value which contain and initial date only to show on date area
  DateFormat? timeFormat;
  DateFormat? dateFormat;
  DateTime? receivedDate;
  bool? enabled;
  dynamic dateType;
  VoidCallback? update;

  DateController(this.dateType,this.callBack,{this.enabled = true,this.defaultTime,this.receivedDate,this.timeFormat,this.dateFormat,this.initialTimeForController});

  updateDateTime(DateTime dateTime)
  {
    receivedDate = dateTime;
  }
  refresh()
  {
    if(update!=null)
    {
      update!();
    }
  }
}
class DateReturn
{
  DateTime value;
  dynamic dateType;
  DateReturn(this.dateType,this.value);
}
enum DatePickerType
{
  date,time,dateTime
}