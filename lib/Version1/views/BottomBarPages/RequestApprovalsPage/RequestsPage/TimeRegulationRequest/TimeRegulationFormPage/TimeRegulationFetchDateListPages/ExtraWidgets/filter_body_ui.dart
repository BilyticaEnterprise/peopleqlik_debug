import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/TimeRegulationListener/TimeRegulationFormListeners/TimeRegulationFetchDateListListeners/time_regulation_filter_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/TimeRegulationListener/TimeRegulationFormListeners/TimeRegulationFetchDateListListeners/time_regulation_form_list_listener.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import '../../../../../../../../../utils/DateRangePicker/configs.dart';
import '../../../../../../../../../utils/DateRangePicker/date_range_picker.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../utils/date_formats.dart';
import '../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../utils/DropDowns/drop_down_header.dart';

class FilterBodyUi extends StatelessWidget {
  final TimeRegulationFormFetchListListener data;
  final TimeRegulationFilterListener listener;
  const FilterBodyUi(this.data, this.listener, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeaderDropDownField(dropDownDataType: listener.typeDropDown!,selectedIndex: listener.selectedIndex, header:'Transaction type', key: const Key('2'), isCompulsory: true, onSelectedDropDown: listener.dropDownCallBack,isEnabled: true),
        const DividerByHeight(2),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(3)),
          child: CalendarDatePicker2(
            config: CalendarDatePicker2Config(
              weekdayLabels: ['Sun','Mon','Tue','Wed','Thr','Fri','Sat'],
              calendarType: CalendarDatePicker2Type.range,
              selectedDayHighlightColor: const Color(MyColor.colorIndigo),
              disabledDayTextStyle: GetFont.get(
                  context,
                  color: 0xffE9E9E9
              ),
              // selectedYearHighlightColor: const Color(MyColor.colorRed),
              selectedDayTextStyle: const TextStyle(color: Colors.white),
              firstDate: listener.minDate
            ),
            onValueChanged: (dates) {
              listener.selectedDates(dates);
            },
            initialValue: data.filterData?.fromTime!=null?[GetDateFormats().getMonthFormatDateTime(data.filterData!.fromTime),GetDateFormats().getMonthFormatDateTime(data.filterData!.toTime)]:[],
          ),
        ),
      ],
    );
  }
}
