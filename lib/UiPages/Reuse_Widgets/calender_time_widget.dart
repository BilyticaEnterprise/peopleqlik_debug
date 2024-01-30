import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';

class CalenderTimeWidget extends StatefulWidget {
  final CalenderTimeEnum? calenderTimeEnum;
  final String? headerText,hint;
  final bool? clearAll;
  final bool? isCompulsory,allowedPreviously,allowedFuture;
  final void Function(SelectedDateTime) selectedDateTime;
  const CalenderTimeWidget(this.calenderTimeEnum,this.headerText,this.hint,this.selectedDateTime,this.isCompulsory,{this.allowedPreviously,this.allowedFuture,this.clearAll,Key? key}) : super(key: key);

  @override
  _CalenderTimeWidgetState createState() => _CalenderTimeWidgetState();
}

class _CalenderTimeWidgetState extends State<CalenderTimeWidget> {
  String? selectedTime;
  @override
  void dispose() {
    selectedTime = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.clearAll!=null&&widget.clearAll==true)
      {
        selectedTime = null;
      }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 0.6)),
          child: Row(
            children: [
              Text(
                widget.headerText??'',
                style: GetFont.get(
                    context,
                    fontSize: 1.6,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                ),
              ),
              if(widget.isCompulsory!=null&&widget.isCompulsory == true)...[
                SizedBox(width: ScreenSize(context).heightOnly( 1),),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Material(
                    color: const Color(MyColor.colorSecondary).withOpacity(0.8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1),vertical: ScreenSize(context).heightOnly( 0.3)),
                      child: Text(
                        'Com',
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
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Container(
          height: ScreenSize(context).heightOnly( 6.5),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              border: Border.all(
                  color: const Color(MyColor.colorBlack),
                  width: 0.7
              )
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: Material(
              color: const Color(MyColor.colorTransparent),
              child: InkWell(
                splashColor: const Color(MyColor.colorGrey0),
                onTap: (){
                  PrintLogs.printLogs('allworsadasd ${widget.allowedPreviously}');
                  if(widget.calenderTimeEnum==CalenderTimeEnum.timeStart||widget.calenderTimeEnum==CalenderTimeEnum.timeEnd)
                  {
                    DatePickerBdaya.showTimePicker(context,
                        showTitleActions: true,
                         theme: const DatePickerThemeBdaya(
                           backgroundColor: Color(MyColor.colorWhite)
                         ),
                         onConfirm: (date) {
                           PrintLogs.printLogs('confirm $date');
                          selectedTime = DateFormat.Hms().format(date);
                          setState(() {
                            
                          });
                          widget.selectedDateTime(SelectedDateTime(date.toString(),widget.calenderTimeEnum));
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.en);
                  }
                  else
                  {
                    DatePickerBdaya.showDatePicker(context,
                        showTitleActions: true,
                        theme: const DatePickerThemeBdaya(
                            backgroundColor: Color(MyColor.colorWhite)
                        ),
                        minTime: widget.allowedPreviously!=null&&widget.allowedPreviously==true?DateTime.now().subtract(const Duration(days: 1000)):DateTime.now(),
                        maxTime: DateTime.now().add(const Duration(days: 1000)), onChanged: (date) {

                        }, onConfirm: (date) {
                          DateFormat dateFormat = DateFormat.yMEd();
                          selectedTime = dateFormat.format(date);
                          setState(() {
                          });
                          widget.selectedDateTime(SelectedDateTime(date.toString(),widget.calenderTimeEnum));
                        },
                        currentTime: DateTime.now(),
                        locale: LocaleType.en);
                  }
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 4)),
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        selectedTime??widget.hint??'Select',
                        style: GetFont.get(
                            context,
                            fontWeight: selectedTime!=null?FontWeight.w600:FontWeight.w400,
                            fontSize: 1.6,
                            color: selectedTime!=null?MyColor.colorBlack:MyColor.colorGrey3
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
class SelectedDateTime
{
  String? dateTime;
  CalenderTimeEnum? calenderTimeEnum;
  SelectedDateTime(this.dateTime,this.calenderTimeEnum);
}
enum CalenderTimeEnum
{
  calenderStart,calenderEnd,calenderSelect,timeStart,timeEnd
}