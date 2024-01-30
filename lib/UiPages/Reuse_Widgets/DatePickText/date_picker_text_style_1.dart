import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AbstractClasses/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/src/snackbar_design.dart';
import 'package:provider/provider.dart';

import '../../../BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import '../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../src/colors.dart';
import '../../../src/fonts.dart';
import '../../../src/icons.dart';
import '../../../src/language_codes.dart';
import '../../../src/prints_logs.dart';
import '../../../src/screen_sizes.dart';

class DatePickerTextStyle1 extends StatelessWidget {
  String textFieldHeader;
  DateTime? currentTime;
  double? margin;
  int? borderColor;
  bool? isCompulsory;
  DatePickerType? datePickerType;
  Key? key;
  String? hintText;
  double? stroke;
  double? padding,height;
  IconData? icon;
  bool? isEnabled,showCalender;
  DateTime? minDate,maxDate;
  bool? noHeader;
  Function()? onTap;
  DateController dateController;
  DatePickerTextStyle1(this.key,this.hintText,{required this.dateController,this.currentTime,this.borderColor,this.datePickerType = DatePickerType.date,this.noHeader,this.maxDate,this.onTap,this.margin,required this.textFieldHeader,this.isCompulsory,this.height,this.stroke,this.padding,this.icon,this.isEnabled,this.showCalender,this.minDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<DatePickerListener>(create: (_) => DatePickerListener(dateController)),
        ],
        builder:(context, child){
          return _DateWidget(key,hintText,dateController: dateController,currentTime: currentTime,borderColor: borderColor,noHeader:noHeader,datePickerType: datePickerType,minDate:minDate,onTap:onTap,margin:margin,textFieldHeader:textFieldHeader,isCompulsory: isCompulsory,height: height,stroke: stroke,padding: padding,icon: icon,isEnabled:isEnabled,showCalender:showCalender,maxDate:maxDate);
        }
    );
  }
}

class _DateWidget extends StatefulWidget {
  String textFieldHeader;
  DateTime? currentTime;
  DateController dateController;
  double? margin;
  int? borderColor;
  DatePickerType? datePickerType;
  DateTime? defaultTime;
  bool? isCompulsory;
  Key? key;
  String? hintText;
  double? stroke;
  double? padding,height;
  IconData? icon;
  bool? isEnabled,showCalender;
  DateTime? minDate,maxDate;
  bool? noHeader;
  Function()? onTap;

  _DateWidget(this.key,this.hintText,{required this.dateController,this.currentTime,this.borderColor,this.datePickerType,this.noHeader,this.maxDate,this.onTap,this.margin,required this.textFieldHeader,this.isCompulsory,this.height,this.stroke,this.padding,this.icon,this.isEnabled,this.showCalender,this.minDate}) : super(key: key);

  @override
  State<_DateWidget> createState() => _DateWidgetState();
}

class _DateWidgetState extends State<_DateWidget> {

  @override
  void initState() {
    widget.dateController.update = update;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if(widget.dateController.defaultTime!=null)
      {
        Provider.of<DatePickerListener>(context,listen: false).update();
      }
    });
    super.initState();
  }
  update()
  {
    Provider.of<DatePickerListener>(context,listen: false).update();
  }
  @override
  Widget build(BuildContext context) {
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);

    return Consumer<DatePickerListener>(
          builder: (context, data, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(widget.noHeader != true)...[
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(widget.margin??6.6)),
                      child:
                      Row(children: [
                        Text(
                          widget.textFieldHeader??'',
                          style: GetFont.get(
                              context,
                              fontSize: 1.6,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                        ),
                        //Expanded(child: Container(),),
                        if(widget.isCompulsory==true)...
                        [
                          SizedBox(width: ScreenSize(context).heightOnly(1),),
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            child: Material(
                              color: const Color(MyColor.colorSecondary).withOpacity(0.8),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(1),vertical: ScreenSize(context).heightOnly( 0.3)),
                                child: Text(
                                  '${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra2)}',
                                  style: GetFont.get(
                                      context,
                                      fontSize: 1.0,
                                      fontWeight: FontWeight.w600,
                                      color: MyColor.colorWhite
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ],
                      )
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly(2),),
                ],
                Container(
                  height: ScreenSize(context).heightOnly(widget.height??6.3),
                  margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(widget.margin??5.6)),
                  decoration: ShapeDecoration(
                    color: const Color(MyColor.colorWhite),
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: widget.stroke??0.75, style: BorderStyle.solid,
                          color: Color(widget.isEnabled==false?MyColor.colorGrey7:MyColor.colorBlack)
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    ),
                  ),
                  child: InkWell(
                    onTap: widget.isEnabled==false?null:widget.onTap??(){
                      if(widget.datePickerType == DatePickerType.date)
                      {
                        DatePickerBdaya.showDatePicker(context,
                            showTitleActions: true,
                            theme: const DatePickerThemeBdaya(
                                backgroundColor: Color(MyColor.colorWhite)
                            ),
                            minTime: widget.minDate??DateTime.now(),
                            maxTime: widget.maxDate??DateTime.now().add(const Duration(days: 600)),
                            onChanged: (date) {

                            }, onConfirm: (date) {
                              validateDate(date,data);

                            }, currentTime: widget.currentTime??DateTime.now(), locale: LocaleType.en);
                      }
                      else
                      {
                        DatePickerBdaya.showTimePicker(
                            context,
                            showSecondsColumn: false,
                            showTitleActions: true,
                            theme: const DatePickerThemeBdaya(
                                backgroundColor: Color(MyColor.colorWhite)
                            ),
                            onChanged: (date) {

                            }, onConfirm: (date)
                            {
                              validateDate(date,data);

                            }, currentTime: widget.currentTime??DateTime.now(), locale: LocaleType.en);
                      }
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(widget.padding??0.0),vertical: 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              data.dateTimeValue??widget.hintText??'',
                              style: GetFont.get(
                                context,
                                fontSize: data.dateTimeValue!=null?1.8:1.6,
                                fontWeight: data.dateTimeValue!=null?FontWeight.w500:FontWeight.w400,
                                color: widget.isEnabled==false?MyColor.colorGrey7:data.dateTimeValue!=null?MyColor.colorBlack:MyColor.colorGrey3,
                              ),
                            ),
                          ),
                          SvgPicture.string(
                            SvgPicturesData.calendar,
                            height: ScreenSize(context).heightOnly(2.2),
                            width: ScreenSize(context).heightOnly(2.2),
                            color: Color(widget.isEnabled==false?MyColor.colorGrey7:MyColor.colorBlack),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          }
    );
  }
  validateDate(DateTime date, DatePickerListener listener)
  {
    if(widget.minDate!=null&&!date.isAfter(widget.minDate!))
    {
      SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.minDate));
    }
    else if(widget.maxDate!=null&&!date.isBefore(widget.maxDate!))
    {
      SnackBarDesign.errorSnack(CallLanguageKeyWords.get(context, LanguageCodes.maxDate));
    }
    else
    {
      listener.selectedTime(date);
    }
  }
}

class DatePickerListener extends GetChangeNotifier
{
  String? dateTimeValue;
  String? dateValue;
  String? timeValue;
  DateController dateController;

  DatePickerListener(this.dateController,)
  {
    // if(dateController.initialTimeForController!=null)
    //   {
    //     DateFormat dateFormat = dateController.dateFormat??DateFormat.yMMMMd();
    //     dateTimeValue = dateFormat.format(dateController.initialTimeForController!);
    //   }
  }
  void update()
  {
    if(dateController.defaultTime!=null)
    {

      dateTimeValue = DateFormat.yMEd().format(dateController.defaultTime!);

      DateFormat dateFormat = dateController.dateFormat??DateFormat.yMMMMd();
      // if(dateValue==null&&dateController.initialTimeForController!=null)
      //   {
      //     /// First we check if dateValue is null obviously when the first time date ui get visible to the user date value will be null
      //     /// because currently user has not selected any date or time we set initial date value in header area for user afterwards if user
      //     /// selected the date then default and received value will take place
      //
      //     dateValue = dateFormat.format(dateController.initialTimeForController!);
      //
      //   }
      // else
      //   {
          dateValue = dateFormat.format(dateController.defaultTime!);
      //  }

      if(dateController.defaultTime!.hour>0||dateController.defaultTime!.minute>0)
        {
          DateFormat timeFormat = dateController.timeFormat??DateFormat('HH:mm a');
          timeValue = timeFormat.format(dateController.defaultTime!);
        }
      notifyListeners();
    }
  }

  void selectedDate(DateTime date) {
    //DateFormat dateFormat = DateFormat.yMEd();

    dateTimeValue = DateFormat.yMEd().format(date);

    DateFormat dateFormat = dateController.dateFormat??DateFormat.yMMMMd();
    dateValue = dateFormat.format(date);

    DateFormat timeFormat = dateController.timeFormat??DateFormat('HH:mm a');
    timeValue = timeFormat.format(date);

    notifyListeners();

    dateController.updateDateTime(date);
    dateController.callBack(DateReturn(dateController.dateType,date));
  }
  void selectedTime(DateTime date) {

    dateTimeValue = DateFormat.yMEd().format(date);
    DateFormat dateFormat = dateController.dateFormat??DateFormat.yMMMMd();
    dateValue = dateFormat.format(date);

    DateFormat timeFormat = dateController.timeFormat??DateFormat('HH:mm a');
    timeValue = timeFormat.format(date);

    notifyListeners();

    dateController.updateDateTime(date);
    dateController.callBack(DateReturn(dateController.dateType,date));
  }
}
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