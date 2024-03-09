import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/utils/provider_logic_utils/overrided_change_notifier.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/utils/snackbar_design.dart';
import 'package:provider/provider.dart';

import '../../../Version1/viewModel/LanguageListeners/language_listener.dart';
import '../../../Version1/Models/call_setting_data.dart';
import '../../../configs/colors.dart';
import '../dividers_screen/dividers.dart';
import '../../../configs/fonts.dart';
import '../../../configs/icons.dart';
import '../../../configs/language_codes.dart';
import '../../../configs/prints_logs.dart';
import '../../../utils/screen_sizes.dart';
import 'date_controller.dart';
import 'date_picker_text_style_1.dart';

class DatePickerTextStyle2 extends StatelessWidget {
  String textFieldHeader;
  double? margin;
  DateTime currentTime;
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
  DatePickerTextStyle2(this.key,this.hintText,{required this.dateController,required this.currentTime,this.borderColor,this.datePickerType = DatePickerType.date,this.noHeader,this.maxDate,this.onTap,this.margin,required this.textFieldHeader,this.isCompulsory,this.height,this.stroke,this.padding,this.icon,this.isEnabled,this.showCalender,this.minDate}) : super(key: key);

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
  DateTime currentTime;
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

  _DateWidget(this.key,this.hintText,{required this.dateController,required this.currentTime,this.borderColor,this.datePickerType,this.noHeader,this.maxDate,this.onTap,this.margin,required this.textFieldHeader,this.isCompulsory,this.height,this.stroke,this.padding,this.icon,this.isEnabled,this.showCalender,this.minDate}) : super(key: key);

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
                  color: const Color(MyColor.colorGrey6),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: widget.stroke??1.0, style: BorderStyle.solid,
                        color: Color(widget.isEnabled==false?MyColor.colorBackgroundDark:MyColor.colorGrey6)
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
                          }, currentTime: widget.currentTime, locale: LocaleType.en);
                    }
                    else if(widget.datePickerType == DatePickerType.dateTime)
                      {
                        DatePickerBdaya.showDateTimePicker(context,
                            showTitleActions: true,
                            theme: const DatePickerThemeBdaya(
                                backgroundColor: Color(MyColor.colorWhite)
                            ),
                            minTime: widget.minDate??DateTime.now(),
                            maxTime: widget.maxDate??DateTime.now(),
                            onChanged: (date) {

                            }, onConfirm: (date) {
                              validateDate(date, data);
                            }, currentTime: widget.currentTime, locale: LocaleType.en);
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
                        validateDate(date, data);
                      }, currentTime: widget.currentTime, locale: LocaleType.en);
                    }
                  },
                  borderRadius: const BorderRadius.all(Radius.circular(25.0)),
                  child: Padding(
                    padding: EdgeInsets.only(left: changeLanguage.languageEnum == LanguageEnum.english?ScreenSize(context).widthOnly(widget.padding??0.0):0,right: changeLanguage.languageEnum == LanguageEnum.arabic?ScreenSize(context).widthOnly(widget.padding??0.0):0),
                    child: Row(
                      children: [
                        Text(
                          data.dateValue??DateFormat.yMMMMd().format(widget.currentTime),
                          style: GetFont.get(
                            context,
                            fontSize: data.dateTimeValue!=null?1.8:1.6,
                            fontWeight: data.dateTimeValue!=null?FontWeight.w500:FontWeight.w400,
                            color: widget.isEnabled==false?MyColor.colorBackgroundDark:data.dateTimeValue!=null?MyColor.colorBlack:MyColor.colorGrey3,
                          ),
                        ),
                        DividerByWidth(widget.padding??2),
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(widget.padding??0.0),vertical: 0),
                            decoration: const ShapeDecoration(
                              color: Color(MyColor.colorWhite),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    data.timeValue??widget.hintText??'',
                                    style: GetFont.get(
                                      context,
                                      fontSize: data.timeValue!=null?1.8:1.6,
                                      fontWeight: data.timeValue!=null?FontWeight.w500:FontWeight.w400,
                                      color: widget.isEnabled==false?MyColor.colorBackgroundDark:data.timeValue!=null?MyColor.colorBlack:MyColor.colorGrey3,
                                    ),
                                  ),
                                ),
                                SvgPicture.string(
                                  SvgPicturesData.calendar,
                                  height: ScreenSize(context).heightOnly(2.2),
                                  width: ScreenSize(context).heightOnly(2.2),
                                  color: Color(widget.isEnabled==false?MyColor.colorBackgroundDark:MyColor.colorBlack),
                                )
                              ],
                            ),
                          ),
                        ),
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
    //PrintLogs.printLogs('12tsasas ${widget.minDate} ${widget.maxDate} $date');
    if(widget.minDate!=null&&!date.isAfter(widget.minDate!))
    {
     // PrintLogs.printLogs('1tsasas ${widget.minDate} ${widget.maxDate}');
      SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.minDate)} ${GetDateFormats().getSpecialFormatDate(widget.minDate)} ${CallLanguageKeyWords.get(context, LanguageCodes.minDateEr1)} ${GetDateFormats().getSpecialFormatDate(widget.minDate)}');
    }
    else if(widget.maxDate!=null&&!date.isBefore(widget.maxDate!))
    {
    //  PrintLogs.printLogs('2tsasas ${widget.minDate} ${widget.maxDate}');
      SnackBarDesign.errorSnack('${CallLanguageKeyWords.get(context, LanguageCodes.maxDate)} ${GetDateFormats().getSpecialFormatDate(widget.maxDate)} ${CallLanguageKeyWords.get(context, LanguageCodes.minDateEr2)} ${GetDateFormats().getSpecialFormatDate(widget.maxDate)}');
    }
    else
    {
      listener.selectedTime(date);
    }
  }
}
