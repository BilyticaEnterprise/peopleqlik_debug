import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_form_listener.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class CalenderSeparationTimeWidget extends StatefulWidget {
  final RequestSeparationData? requestSeparationData;
  const CalenderSeparationTimeWidget(this.requestSeparationData,{Key? key}) : super(key: key);

  @override
  _CalenderSeparationTimeWidgetState createState() => _CalenderSeparationTimeWidgetState();
}

class _CalenderSeparationTimeWidgetState extends State<CalenderSeparationTimeWidget> {
  String? date,selectedTime;
  @override
  void initState() {
    if(widget.requestSeparationData?.data!=null&&widget.requestSeparationData!.data.toString().isNotEmpty)
    {
      DateFormat dateFormatMain = DateFormat('MM/dd/yyyy');
      DateFormat dateFormatMainExtra = DateFormat('yyyy-MM-dd');
      DateFormat dateFormatPrint = DateFormat.yMEd();
      try{
        DateTime t;
        try{
          t = dateFormatMain.parse(widget.requestSeparationData?.data);
          selectedTime = dateFormatMain.format(t);
        }catch(e){
          t =  dateFormatMainExtra.parse(widget.requestSeparationData?.data);
          selectedTime = dateFormatMainExtra.format(t);
        }
        date = dateFormatPrint.format(t);
      }catch(e)
      {
        print('vajjja ${e.toString()}');
      }
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.requestSeparationData!.callBack!(RequestSeparationCallBack(index: widget.requestSeparationData?.index,data: selectedTime!));
      });
    }
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.6)),
            child: Row(children: [
              Text(
                widget.requestSeparationData?.title??'',
                style: GetFont.get(
                    context,
                    fontSize: 1.6,
                    fontWeight: FontWeight.w600,
                    color: MyColor.colorBlack
                ),
              ),
              if(widget.requestSeparationData?.isRequired==true)...
              [
                SizedBox(width: ScreenSize(context).heightOnly( 1),),
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Material(
                    color: const Color(MyColor.colorSecondary).withOpacity(0.8),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1),vertical: ScreenSize(context).heightOnly( 0.3)),
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
            ],)
        ),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        Container(
          height: ScreenSize(context).heightOnly( 6.5),
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
          decoration: BoxDecoration(
            color: const Color(MyColor.colorWhite),
            borderRadius: const BorderRadius.all(Radius.circular(25.0)),
            border: Border.all(
                width: 0.7, style: BorderStyle.solid,
                color: Color(widget.requestSeparationData?.isEnable==false?MyColor.colorBackgroundDark:MyColor.colorBlack)
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: Material(
              color: Color(widget.requestSeparationData?.isEnable==false?MyColor.colorGreySecondary:MyColor.colorTransparent),
              child: InkWell(
                splashColor: const Color(MyColor.colorGrey0),
                onTap: widget.requestSeparationData?.isEnable==false?null:(){
                  DatePickerBdaya.showDatePicker(context,
                      showTitleActions: true,
                      theme: const DatePickerThemeBdaya(
                          backgroundColor: Color(MyColor.colorWhite)
                      ),
                      minTime: DateTime.now(),
                      maxTime: DateTime.now().add(const Duration(days: 600)), onChanged: (date) {

                      }, onConfirm: (date) {
                        //PrintLogs.print('confirm $date');
                          PrintLogs.printLogs('ifsetstateee');
                          DateFormat dateFormat = DateFormat.yMEd();
                          DateFormat dateFormatPrint = DateFormat('MM/dd/yyyy');

                          this.date = dateFormat.format(date);
                          selectedTime = dateFormatPrint.format(date);

                            setState(() {
                          });
                          widget.requestSeparationData!.callBack!(RequestSeparationCallBack(index: widget.requestSeparationData?.index,data: selectedTime!));

                      }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 4)),
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        date??widget.requestSeparationData?.hint??'Select',
                        style: GetFont.get(
                            context,
                            fontWeight: date!=null?FontWeight.w600:FontWeight.w400,
                            fontSize: 1.6,
                            color: date!=null?MyColor.colorBlack:MyColor.colorGrey3
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