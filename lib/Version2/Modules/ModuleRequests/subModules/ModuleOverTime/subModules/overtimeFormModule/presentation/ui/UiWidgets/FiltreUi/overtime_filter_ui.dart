import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/TimeOffAndEnCashModel/overtime_filter_mapper.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeFormModule/presentation/listener/overtime_filter_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeFormModule/presentation/ui/UiWidgets/FiltreUi/UiWidgets/select_employee.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/bottomSheetUi/bottom_sheet_header.dart';
import 'package:peopleqlik_debug/utils/dateRangePicker/configs.dart';
import 'package:peopleqlik_debug/utils/dateRangePicker/date_range_picker.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_single_button.dart';
import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';

class FilterOverTime extends StatelessWidget {
  final OvertimeFilterMapper? previousSelectedOvertimeFilterMapper;
  const FilterOverTime({this.previousSelectedOvertimeFilterMapper,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OvertimeFilterListener>(
      create: (_) => OvertimeFilterListener(context,overtimeFilterMapper: previousSelectedOvertimeFilterMapper),
      builder: (context, snapshot) {
        return SizedBox(
          height: ScreenSize(context).heightOnly(100),
          child: SafeArea(
            top: false,
            bottom: false,
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
                    title: HeaderBottomSheet(text: '${CallLanguageKeyWords.get(context, LanguageCodes.selectFilters)}',),
                  ),
                  body: FilterOverTimeBodyUi(),
                  bottomNavigationBar: BottomSingleButton(text: CallLanguageKeyWords.get(context, LanguageCodes.done)??'',
                    onPressed: (){
                    Provider.of<OvertimeFilterListener>(context,listen: false).submit(context);
                  },),
                ),
              ),
            ),
        );
      }
    );
  }
}


class FilterOverTimeBodyUi extends StatelessWidget {
  const FilterOverTimeBodyUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OvertimeFilterListener>(
        builder: (context, data, child) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      firstDate: DateTime.now().subtract(const Duration(days: 60)),
                      lastDate: DateTime.now().add(const Duration(days: 365))
                    ),
                    onValueChanged: (dates) {
                      data.selectedDates(dates);
                    },
                    initialValue: [data.startDate??DateTime.now(),data.endDate],
                  ),
                ),
                HeaderDropDownField(dropDownDataType: data.overTimeTypeDropDown!, header:'${CallLanguageKeyWords.get(context, LanguageCodes.overTimeType)}',selectedIndex: data.getIndex(typeId: data.selectedObjOvertimeTypes?.typeID), key: const Key('2'), isCompulsory: true, onSelectedDropDown: data.dropDownCallBack,isEnabled: true),
                const DividerByHeight(4),
                if(data.selectedObjOvertimeTypes!=null)...[
                  SelectEmployeeWidget(typeId: data.selectedObjOvertimeTypes!.typeID!,employeeInfoMapperList: data.employeeList,employeeListCallBack: (list){data.updateSelectedEmployeeList(context,list);},)
                ]
              ],
            ),
          );
        }
    );
  }
}
