import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/OvertimeFormPages/UiWidgets/FiltreUi/UiWidgets/select_employee.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:provider/provider.dart';
import 'package:timelines/timelines.dart';
import '../../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/OverTimeListeners/OverTimeHourListeners/hour_selector_listener.dart';
import '../../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/OverTimeListeners/overtime_filter_listener.dart';
import '../../../../../../../../BusinessLogicModel/Models/TimeOffAndEnCashModel/overtime_filter_mapper.dart';
import '../../../../../../../../BusinessLogicModel/Models/TimeOffAndEnCashModel/overtime_hour_mapper.dart';
import '../../../../../../../../BusinessLogicModel/Models/TimeOffAndEnCashModel/overtime_time_range_model.dart';
import '../../../../../../../../src/DateRangePicker/configs.dart';
import '../../../../../../../../src/DateRangePicker/date_range_picker.dart';
import '../../../../../../../../src/colors.dart';
import '../../../../../../../../src/fonts.dart';
import '../../../../../../../../src/lottie_string.dart';
import '../../../../../../../../src/screen_sizes.dart';
import '../../../../../../../Reuse_Widgets/BottomSheetUi/bottom_sheet_header.dart';
import '../../../../../../../Reuse_Widgets/DatePickText/date_picker_text_style_1.dart';
import '../../../../../../../Reuse_Widgets/DatePickText/date_picker_text_style_2.dart';
import '../../../../../../../Reuse_Widgets/ErrorsUi/not_available.dart';
import '../../../../../../../Reuse_Widgets/dividers.dart';

class OverTimeHourSheet extends StatelessWidget {
  final List<EmployeeDateTimeList>? overtimeHourMapper;
  final List<OvertimeTimeRangeResultSet>? apiResultSet;
  const OverTimeHourSheet({this.overtimeHourMapper,this.apiResultSet,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HourSelectorListener>(
        create: (_) => HourSelectorListener(overtimeHourMapper!,apiResultSet),
        builder: (context, snapshot) {
          return SizedBox(
            height: ScreenSize(context).heightOnly(90),
            child: SafeArea(
              top: false,
              bottom: false,
              child: ClipRRect(
                borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft: Radius.circular(15)),
                child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: Scaffold(
                    primary: false,
                    extendBody: false,
                    resizeToAvoidBottomInset: false,
                    extendBodyBehindAppBar: false,
                    backgroundColor: Color(MyColor.colorWhite),
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Color(MyColor.colorWhite),
                      elevation: 0,
                      titleSpacing: 0,
                      toolbarHeight: ScreenSize(context).heightOnly(9),
                      title: HeaderBottomSheet(text: '',doneTap: (){
                        Provider.of<HourSelectorListener>(context,listen: false).submit(context);
                      },),
                    ),
                    body: HourSheetBodyUi(),
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}


class HourSheetBodyUi extends StatelessWidget {
  const HourSheetBodyUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HourSelectorListener>(
        builder: (context, data, child) {
          if(data.selectedOvertimeTimeList!=null)
            {
              return HourTimeLineTile(timeList: data.selectedOvertimeTimeList,dateControllerList: data.dateControllerList,isEnabled: data.enabledList,);
            }
          else
            {
              return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
            }
        }
    );
  }
}
class HourTimeLineTile extends StatelessWidget {
  final List<EmployeeDateTimeList> timeList;
  final List<bool>? isEnabled;
  final List<DateController>? dateControllerList;
  const HourTimeLineTile({required this.timeList,required this.dateControllerList,this.isEnabled,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Timeline.tileBuilder(
      shrinkWrap: true,
      theme: TimelineThemeData(
        nodePosition: 0,
        connectorTheme: ConnectorThemeData(
          thickness: ScreenSize(context).heightOnly( 0.4),
          color: const Color(0xffd3d3d3),
        ),
        indicatorTheme: IndicatorThemeData(
          size: ScreenSize(context).heightOnly( 2),
        ),
      ),
      padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly(6), 0, ScreenSize(context).widthOnly(6), ScreenSize(context).heightOnly(16)),
      builder: TimelineTileBuilder.connected(
        contentsBuilder: (_, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 3)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${CallLanguageKeyWords.get(context, LanguageCodes.on)} ${GetDateFormats().getDayName(timeList[index].date)} ${isEnabled?[index]==false?'${CallLanguageKeyWords.get(context, LanguageCodes.movementSlipNotAllowedHeader)}':''}',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w400,
                    fontSize: 1.6,
                    color: isEnabled?[index]==false?MyColor.colorRed:MyColor.colorBlack
                ),
              ),
              const DividerByHeight(1.0),
              DatePickerTextStyle2(Key('11$index'),'${CallLanguageKeyWords.get(context, LanguageCodes.tR3)}', dateController: dateControllerList![index], textFieldHeader: 'From (Date & time)',currentTime: timeList[index].date??DateTime.now(),noHeader: true,datePickerType: DatePickerType.time,isEnabled: isEnabled?[index],margin: 0,padding: 4,)
            ],
          ),
        ),
        connectorBuilder: (_, index, __) {
          return SolidLineConnector(color: Color(MyColor.colorGrey0,),);
        },
        indicatorBuilder: (_, index) {
          return DotIndicator(
            color: Color(timeList[index].selectedDateTime!=null?MyColor.colorPrimary:MyColor.colorRed),
            child: Icon(
              Icons.last_page,
              color: Colors.white,
              size: ScreenSize(context).heightOnly( 1.4),
            ),
          );
        },
        itemExtentBuilder: (_, __) => ScreenSize(context).heightOnly(13),
        itemCount: timeList.length,
      ),
    );
  }
}
