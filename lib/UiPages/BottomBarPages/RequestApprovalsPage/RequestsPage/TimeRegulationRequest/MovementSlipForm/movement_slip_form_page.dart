import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/MovementSlipForm/ExtraWidgets/time_date_widget.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:provider/provider.dart';

import '../../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/TimeRegulationListener/MovementSlipFormListeners/movement_slip_form_listener.dart';
import '../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import '../../../../../../BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import '../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../src/divider.dart';
import '../../../../../../src/language_codes.dart';
import '../../../../../../src/lottie_string.dart';
import '../../../../../../src/screen_sizes.dart';
import '../../../../../Reuse_LogicalWidgets/current_employee_name_note.dart';
import '../../../../../Reuse_Widgets/Appbars/generic_app_bar.dart';
import '../../../../../Reuse_Widgets/Buttons/bottom_single_button.dart';
import '../../../../../Reuse_Widgets/DatePickText/date_picker_text_style_1.dart';
import '../../../../../Reuse_Widgets/DatePickText/date_picker_text_style_2.dart';
import '../../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../../../Reuse_Widgets/DropDowns/drop_down_header.dart';
import '../../../../../Reuse_Widgets/ErrorsUi/not_available.dart';
import '../../../../../Reuse_Widgets/TextFields/text_field_latest.dart';
import '../../../../../Reuse_Widgets/Buttons/buttons.dart';
import '../../../../../Reuse_Widgets/circular_indicator_customized.dart';
import '../../../../../Reuse_Widgets/text_remarks_header.dart';
import '../../../../GlobalEmployeeSearchUi/call_employee_search_ui.dart';

class MoveSlipFormPage extends StatelessWidget {
  MoveSlipFormPage({Key? key}) : super(key: key);

  RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)?.settings.arguments as RequestDataTaker?;
    Provider.of<GlobalSelectedEmployeeController>(context,listen: false).saveTempEmployee();
    return WillPopScope(
      onWillPop: ()async{
        Provider.of<GlobalSelectedEmployeeController>(context,listen: false).specialPop(context);
        return false;
      },
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider<MovementSlipFormListener>(create: (_) => MovementSlipFormListener(context))
          ],
          builder: (context, snapshot) {
            return GetPageStarterScaffold(
              body: BodyData(),
              appBar: Consumer<GlobalSelectedEmployeeController>(
                  builder: (context, employeeData, child) {
                    return EmployeeAppBarWidget(
                      requestDataTaker?.title??'',
                      onBackTap: (){
                        Provider.of<GlobalSelectedEmployeeController>(context,listen: false).specialPop(context);
                      },
                      selectEmployeeTap: () {
                        EmployeeSearchBottomSheet().show(
                            context,
                                (employeeInfoMapper)
                            {
                              Provider.of<MovementSlipFormListener>(context,listen: false).resetAll();
                            }
                        );
                      },
                      removeEmployeeTap: () async {
                        await employeeData.resetEmployee();
                        Provider.of<MovementSlipFormListener>(context,listen: false).resetAll();
                      },
                      hidePlusButton: true,
                      employeeInfoMapper: employeeData.getEmployee(),
                    );
                  }
              ),
              bottomNavigationBar: Consumer<MovementSlipFormListener>(
                builder: (context, data, child) {
                  if(data.apiStatus == ApiStatus.done||data.apiStatus == ApiStatus.empty)
                    {
                      return BottomSingleButton(text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsaddFormButton)}',onPressed: data.confirmPressed,);
                    }
                  else
                    {
                      return Container(height: 0,);
                    }
                }
              ),
                checkEmployeeIfExistInCurrentCompany: Provider.of<GlobalSelectedEmployeeController>(context,listen: false).checkIfCurrentUserCompanyMatches(),
                employeeChangeCurrentCompanyTap: (){
                  EmployeeSearchBottomSheet().show(
                      context,
                          (employeeInfoMapper)
                      {
                        Provider.of<MovementSlipFormListener>(context,listen: false).resetAll();
                      }
                  );
                }
            );
          }
      ),
    );
  }
}
class BodyData extends StatelessWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovementSlipFormListener>(
          builder: (context, data, child) {
            data.context = context;
            return SingleChildScrollView(
              key: Key('Scroll${data.resetKey}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CurrentEmployeeNoteWidget(),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  DatePickerTextStyle1(Key('dateKey${data.resetKey}'),'${CallLanguageKeyWords.get(context, LanguageCodes.tR1)}', dateController: data.initialDateController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.tR2)}',minDate: data.minDate,isCompulsory: true,margin: 6.0,padding: 4,),
                  Flexible(child: OnDateSelectWidget(data))
                  //  TextWidgetLatest(data.dateController,TextInputAction.next,data.dateFocus, const Key('2'),'Click to select date',callBack: response,textInputType: TextInputType.text, textFieldHeader: 'Date',isCompulsory: true,margin: 0,padding: 4,isEnabled: true,)
                ],
              ),
            );
          }
      );
  }

  response(String p1) {

  }

}
class OnDateSelectWidget extends StatelessWidget {
  final MovementSlipFormListener data;
  const OnDateSelectWidget(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(data.apiStatus == ApiStatus.done||data.apiStatus == ApiStatus.empty)
      {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DividerVertical(2),
            HeaderDropDownField(dropDownDataType: data.typeDropDown!, header:'${CallLanguageKeyWords.get(context, LanguageCodes.type)}', key: const Key('2'), isCompulsory: true, onSelectedDropDown: data.dropDownCallBack,isEnabled: true),
            const DividerVertical(2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6.0)),
              child: DateAndTimeWidget(
                widget1: DatePickerTextStyle2(const Key('11'),'${CallLanguageKeyWords.get(context, LanguageCodes.tR3)}', dateController: data.fromDateTimeController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.tR4)}',currentTime: data.fromDateTimeController?.receivedDate??data.initialDateController?.receivedDate??DateTime.now(),minDate: DateTime(data.initialDateController!.receivedDate!.year,data.initialDateController!.receivedDate!.month,data.initialDateController!.receivedDate!.day),maxDate: DateTime(data.initialDateController!.receivedDate!.year,data.initialDateController!.receivedDate!.month,data.initialDateController!.receivedDate!.day).add(const Duration(hours: 47,minutes: 59)),isCompulsory: true,datePickerType: DatePickerType.dateTime,margin: 0,padding: 4,),
                widget2: DatePickerTextStyle2(const Key('12'),'${CallLanguageKeyWords.get(context, LanguageCodes.tR3)}', dateController: data.toDateTimeController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.tR5)}',currentTime: data.toDateTimeController?.receivedDate??data.initialDateController?.receivedDate??DateTime.now(),minDate: DateTime(data.initialDateController!.receivedDate!.year,data.initialDateController!.receivedDate!.month,data.initialDateController!.receivedDate!.day),maxDate: DateTime(data.initialDateController!.receivedDate!.year,data.initialDateController!.receivedDate!.month,data.initialDateController!.receivedDate!.day).add(const Duration(hours: 47,minutes: 59)),isCompulsory: true,datePickerType: DatePickerType.dateTime,margin: 0,padding: 4,)
              ),
            ),
            const DividerVertical(2),
            HeaderTextRemarksField('${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarks)}','${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarksHint)}',data.remarksController,data.remarksNodeFocus!,false,callBack: (t){},key: const Key('remarkssanTsada'),),
            const DividerVertical(14),
          ],
        );
      }
    else if(data.apiStatus == ApiStatus.error)
    {
      return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
    }
    else if(data.apiStatus == ApiStatus.notAllowed)
    {
      return NotAvailable(LottieString.noPermission, '${CallLanguageKeyWords.get(context, LanguageCodes.movementSlipNotAllowedHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.movementSlipNotAllowedValue)}',topMargin: 8,width: 30);
    }
    else if(data.apiStatus == ApiStatus.nothing)
      {
        return Container(height: 0,);
      }
    else
    {
      return const CircularIndicatorCustomized(marginTop: 4,);
    }
  }
}

