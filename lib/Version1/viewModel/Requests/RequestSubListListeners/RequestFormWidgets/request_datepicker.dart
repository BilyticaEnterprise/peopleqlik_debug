import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peopleqlik_debug/Version1/models/PaysSlipApprovalsRequest/request_list_form_model.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';

import '../request_form_get_listener.dart';

class CalenderTimeWidget extends StatefulWidget {
  final RequestSender? requestSender;
  final Function(RequestCallBack)? callBack;
  const CalenderTimeWidget(this.requestSender,this.callBack,{Key? key}) : super(key: key);

  @override
  _CalenderTimeWidgetState createState() => _CalenderTimeWidgetState();
}

class _CalenderTimeWidgetState extends State<CalenderTimeWidget> {
  ReqDetail? selectedTime;
  String? date;
  @override
  void initState() {
    PrintLogs.printLogs('dateeeelengthhh${widget.requestSender?.data?.length??0}');
    if(widget.requestSender?.data?[0]!=null)
      {
        DateFormat dateFormat = DateFormat('MM/dd/yyyy');
        DateFormat dateFormatPrint = DateFormat.yMEd();
        if(selectedTime==null)
        {
          selectedTime = ReqDetail();
          selectedTime?.id = widget.requestSender?.data?[0].id;
        }
        try{
          selectedTime?.name = dateFormat.format(DateTime.parse(widget.requestSender?.data?[0].name));
          date = dateFormatPrint.format(DateTime.parse(widget.requestSender?.data?[0].name));

        }catch(e)
        {}
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          widget.callBack!(RequestCallBack(selectedTime,widget.requestSender?.uiIndex,widget.requestSender?.dataIndex,widget.requestSender?.uiTypes,widget.requestSender?.dependent,widget.requestSender?.isEnable,widget.requestSender?.admRequestManagerDt));
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
              widget.requestSender?.header??'',
              style: GetFont.get(
                  context,
                  fontSize: 1.6,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
              ),
            ),
            //Expanded(child: Container(),),
            if(widget.requestSender?.dependent?.isDependent==true)...[
              SizedBox(width: ScreenSize(context).heightOnly( 1),),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Material(
                  color: const Color(MyColor.colorPrimary).withOpacity(0.8),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1),vertical: ScreenSize(context).heightOnly( 0.3)),
                    child: Text(
                      '${CallLanguageKeyWords.get(context, LanguageCodes.extrasextra1)} ${widget.requestSender?.dependent?.name}',
                      style: GetFont.get(
                          context,
                          fontSize: 1.0,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorWhite
                      ),
                    ),
                  ),
                ),
              ),
            ],
            if(widget.requestSender?.admRequestManagerDt?.isRequired==true)...
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
                color: Color(widget.requestSender?.isEnable==false?MyColor.colorBackgroundDark:MyColor.colorBlack)
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            child: Material(
              color: Color(widget.requestSender?.isEnable==false?MyColor.colorGreySecondary:MyColor.colorTransparent),
              child: InkWell(
                splashColor: const Color(MyColor.colorGrey0),
                onTap: widget.requestSender?.isEnable==false?null:(){
                    DatePickerBdaya.showDatePicker(context,
                        showTitleActions: true,
                        theme: const DatePickerThemeBdaya(
                            backgroundColor: Color(MyColor.colorWhite)
                        ),
                        minTime: DateTime.now(),
                        maxTime: DateTime.now().add(const Duration(days: 600)), onChanged: (date) {

                        }, onConfirm: (date) {
                          //PrintLogs.print('confirm $date');
                          if(widget.callBack!=null)
                            {
                              PrintLogs.printLogs('ifsetstateee');
                              DateFormat dateFormat = DateFormat.yMEd();
                              DateFormat dateFormatPrint = DateFormat('MM/dd/yyyy');
                              if(selectedTime==null)
                                {
                                  selectedTime = ReqDetail();
                                  selectedTime?.id = -1;
                                }
                              selectedTime?.name = dateFormatPrint.format(date);
                              this.date = dateFormat.format(date);
                              setState(() {
                              });
                              widget.callBack!(RequestCallBack(selectedTime,widget.requestSender?.uiIndex,widget.requestSender?.dataIndex,widget.requestSender?.uiTypes,widget.requestSender?.dependent,widget.requestSender?.isEnable,widget.requestSender?.admRequestManagerDt));

                            }//widget.selectedDateTime(SelectedDateTime(date.toString(),widget.calenderTimeEnum));
                        }, currentTime: DateTime.now(), locale: LocaleType.en);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 4)),
                  child: Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        date??widget.requestSender?.hint??'Select',
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