import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/TimeRegulationListener/TimeRegulationFormListeners/time_regulation_form_listener.dart';
import '../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import '../../../../../../../BusinessLogicModel/Models/TimeRegulationModels/time_regulation_monthly_model.dart';
import '../../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../../src/divider.dart';
import '../../../../../../../src/language_codes.dart';
import '../../../../../../../src/screen_sizes.dart';
import '../../../../../../Reuse_LogicalWidgets/current_employee_name_note.dart';
import '../../../../../../Reuse_Widgets/Buttons/bottom_single_button.dart';
import '../../../../../../Reuse_Widgets/DatePickText/date_picker_text_style_1.dart';
import '../../../../../../Reuse_Widgets/DatePickText/date_picker_text_style_2.dart';
import '../../../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../../../../Reuse_Widgets/DropDowns/drop_down_header.dart';
import '../../../../../../Reuse_Widgets/text_remarks_header.dart';
import '../../MovementSlipForm/ExtraWidgets/time_date_widget.dart';

class TimeRegulationFormPage extends StatelessWidget {
  TimeRegulationFormPage({Key? key}) : super(key: key);

  RequestDataTaker? data;
  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context)?.settings.arguments as RequestDataTaker;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TimeRegulationFormListener>(create: (_) => TimeRegulationFormListener(context,data?.extraData))
      ],
      builder: (context, snapshot) {
        return GetPageStarterScaffold(
          title: data?.title??'Time Regulation Form',
          body: BodyData(),
          bottomNavigationBar: BottomSingleButton(text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsaddFormButton)}',onPressed: (){Provider.of<TimeRegulationFormListener>(context,listen: false).confirmPressed(context);},),
        );
      }
    );
  }
}
class BodyData extends StatelessWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TimeRegulationFormListener>(
        builder: (context, data, child) {
          return SingleChildScrollView(
            key: Key('Scroll'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CurrentEmployeeNoteWidget(),
                SizedBox(height: ScreenSize(context).heightOnly( 2),),
                DatePickerTextStyle1(const Key('dateKey'),'${CallLanguageKeyWords.get(context, LanguageCodes.tR1)}', dateController: data.initialDateController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.tR2)}',isCompulsory: true,isEnabled: false,margin: 6.0,padding: 4,),
                const DividerVertical(2),
                HeaderDropDownField(dropDownDataType: data.typeDropDown!, header:'${CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationAttendanceType)}', key: const Key('2'), isCompulsory: true, onSelectedDropDown: data.dropDownCallBack,isEnabled: true),
                const DividerVertical(2),
                if(data.selectedTypeIndex!=null)...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6.0)),
                    child: DateAndTimeWidget(
                        widget1: DatePickerTextStyle2(const Key('11'),'${CallLanguageKeyWords.get(context, LanguageCodes.tR3)}', dateController: data.fromDateTimeController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.tR4)}',currentTime: data.attendanceDate??DateTime.now(),minDate: DateTime(data.attendanceDate!.year,data.attendanceDate!.month,data.attendanceDate!.day),maxDate: DateTime(data.attendanceDate!.year,data.attendanceDate!.month,data.attendanceDate!.day).add(const Duration(hours: 47,minutes: 59)),isCompulsory: true,datePickerType: DatePickerType.dateTime,margin: 0,padding: 4,isEnabled: data.fromDateTimeController?.enabled,),
                        widget2: DatePickerTextStyle2(const Key('12'),'${CallLanguageKeyWords.get(context, LanguageCodes.tR3)}', dateController: data.toDateTimeController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.tR5)}',currentTime: data.attendanceDate??DateTime.now(),minDate: DateTime(data.attendanceDate!.year,data.attendanceDate!.month,data.attendanceDate!.day),maxDate: DateTime(data.attendanceDate!.year,data.attendanceDate!.month,data.attendanceDate!.day).add(const Duration(hours: 47,minutes: 59)),isCompulsory: true,datePickerType: DatePickerType.dateTime,margin: 0,padding: 4,isEnabled: data.toDateTimeController?.enabled,)
                    ),
                  ),
                  const DividerVertical(2),
                  HeaderTextRemarksField('${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarks)}','${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarksHint)}',data.remarksController,data.remarksNodeFocus!,false,callBack: (t){},key: const Key('remarkssanTsada'),),
                  const DividerVertical(14),
                ]
              ],
            ),
          );
        }
    );
  }


}
