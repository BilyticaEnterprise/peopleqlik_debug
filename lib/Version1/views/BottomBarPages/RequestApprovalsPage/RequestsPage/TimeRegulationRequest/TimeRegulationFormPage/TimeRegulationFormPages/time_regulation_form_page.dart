import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/TimeRegulationListener/TimeRegulationFormListeners/time_regulation_form_listener.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../Version1/Models/RequestsModel/request_data_taker.dart';
import '../../../../../../../../Version1/Models/TimeRegulationModels/time_regulation_monthly_model.dart';
import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../utils/Buttons/bottom_single_button.dart';
import '../../../../../../../../utils/DatePickText/date_controller.dart';
import '../../../../../../../../utils/DatePickText/date_picker_text_style_1.dart';
import '../../../../../../../../utils/DatePickText/date_picker_text_style_2.dart';
import '../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../../../../utils/DropDowns/drop_down_header.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../utils/screen_sizes.dart';
import '../../../../../../../../utils/Reuse_LogicalWidgets/current_employee_name_note.dart';
import '../../../../../../../../utils/TextFieldRemarks/text_remarks_header.dart';
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
        return GetPageStarterScaffoldStateLess(
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
                const DividerByHeight(2),
                HeaderDropDownField(dropDownDataType: data.typeDropDown!, header:'${CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationAttendanceType)}', key: const Key('2'), isCompulsory: true, onSelectedDropDown: data.dropDownCallBack,isEnabled: true),
                const DividerByHeight(2),
                if(data.selectedTypeIndex!=null)...[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6.0)),
                    child: DateAndTimeWidget(
                        widget1: DatePickerTextStyle2(const Key('11'),'${CallLanguageKeyWords.get(context, LanguageCodes.tR3)}', dateController: data.fromDateTimeController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.tR4)}',currentTime: data.attendanceDate??DateTime.now(),minDate: DateTime(data.attendanceDate!.year,data.attendanceDate!.month,data.attendanceDate!.day),maxDate: DateTime(data.attendanceDate!.year,data.attendanceDate!.month,data.attendanceDate!.day).add(const Duration(hours: 47,minutes: 59)),isCompulsory: true,datePickerType: DatePickerType.dateTime,margin: 0,padding: 4,isEnabled: data.fromDateTimeController?.enabled,),
                        widget2: DatePickerTextStyle2(const Key('12'),'${CallLanguageKeyWords.get(context, LanguageCodes.tR3)}', dateController: data.toDateTimeController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.tR5)}',currentTime: data.attendanceDate??DateTime.now(),minDate: DateTime(data.attendanceDate!.year,data.attendanceDate!.month,data.attendanceDate!.day),maxDate: DateTime(data.attendanceDate!.year,data.attendanceDate!.month,data.attendanceDate!.day).add(const Duration(hours: 47,minutes: 59)),isCompulsory: true,datePickerType: DatePickerType.dateTime,margin: 0,padding: 4,isEnabled: data.toDateTimeController?.enabled,)
                    ),
                  ),
                  const DividerByHeight(2),
                  HeaderTextRemarksField('${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarks)}','${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarksHint)}',data.remarksController,data.remarksNodeFocus!,false,callBack: (t){},key: const Key('remarkssanTsada'),),
                  const DividerByHeight(14),
                ]
              ],
            ),
          );
        }
    );
  }


}
