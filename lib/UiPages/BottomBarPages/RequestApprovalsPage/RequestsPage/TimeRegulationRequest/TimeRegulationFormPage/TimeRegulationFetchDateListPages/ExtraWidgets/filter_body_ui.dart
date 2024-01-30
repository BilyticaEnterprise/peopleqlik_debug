import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/divider.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/TimeRegulationListener/TimeRegulationFormListeners/TimeRegulationFetchDateListListeners/time_regulation_filter_listener.dart';
import '../../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/TimeRegulationListener/TimeRegulationFormListeners/TimeRegulationFetchDateListListeners/time_regulation_form_list_listener.dart';
import '../../../../../../../../src/DateRangePicker/configs.dart';
import '../../../../../../../../src/DateRangePicker/date_range_picker.dart';
import '../../../../../../../../src/colors.dart';
import '../../../../../../../../src/date_formats.dart';
import '../../../../../../../../src/fonts.dart';
import '../../../../../../../Reuse_Widgets/DropDowns/drop_down_header.dart';

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
        const DividerVertical(2),
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
