import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/TimeRegulationListener/MovementSlipFormListeners/movement_slip_form_listener.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/MovementSlipForm/ExtraWidgets/time_date_widget.dart';
import 'package:provider/provider.dart';

import '../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../../Version1/models/RequestsModel/request_data_taker.dart';
import '../../../../../../../../../Version1/models/call_setting_data.dart';
import '../../../../../../../utils/Appbars/generic_app_bar.dart';
import '../../../../../../../utils/datePickText/date_controller.dart';
import '../../../../../../../utils/datePickText/date_picker_text_style_1.dart';
import '../../../../../../../utils/datePickText/date_picker_text_style_2.dart';
import '../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/dropDowns/drop_down_header.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/lottie_anims_utils/lottie_string.dart';
import '../../../../../../../utils/screen_sizes.dart';
import '../../../../../../../utils/Reuse_LogicalWidgets/current_employee_name_note.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_single_button.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import '../../../../../../../../utils/screenLoader/circular_indicator_customized.dart';
import '../../../../../../../utils/TextFieldRemarks/text_remarks_header.dart';
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
            return GetPageStarterScaffoldStateLess(
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
            const DividerByHeight(2),
            HeaderDropDownField(dropDownDataType: data.typeDropDown!, header:'${CallLanguageKeyWords.get(context, LanguageCodes.type)}', key: const Key('2'), isCompulsory: true, onSelectedDropDown: data.dropDownCallBack,isEnabled: true),
            const DividerByHeight(2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(6.0)),
              child: DateAndTimeWidget(
                widget1: DatePickerTextStyle2(const Key('11'),'${CallLanguageKeyWords.get(context, LanguageCodes.tR3)}', dateController: data.fromDateTimeController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.tR4)}',currentTime: data.fromDateTimeController?.receivedDate??data.initialDateController?.receivedDate??DateTime.now(),minDate: DateTime(data.initialDateController!.receivedDate!.year,data.initialDateController!.receivedDate!.month,data.initialDateController!.receivedDate!.day),maxDate: DateTime(data.initialDateController!.receivedDate!.year,data.initialDateController!.receivedDate!.month,data.initialDateController!.receivedDate!.day).add(const Duration(hours: 47,minutes: 59)),isCompulsory: true,datePickerType: DatePickerType.dateTime,margin: 0,padding: 4,),
                widget2: DatePickerTextStyle2(const Key('12'),'${CallLanguageKeyWords.get(context, LanguageCodes.tR3)}', dateController: data.toDateTimeController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.tR5)}',currentTime: data.toDateTimeController?.receivedDate??data.initialDateController?.receivedDate??DateTime.now(),minDate: DateTime(data.initialDateController!.receivedDate!.year,data.initialDateController!.receivedDate!.month,data.initialDateController!.receivedDate!.day),maxDate: DateTime(data.initialDateController!.receivedDate!.year,data.initialDateController!.receivedDate!.month,data.initialDateController!.receivedDate!.day).add(const Duration(hours: 47,minutes: 59)),isCompulsory: true,datePickerType: DatePickerType.dateTime,margin: 0,padding: 4,)
              ),
            ),
            const DividerByHeight(2),
            HeaderTextRemarksField('${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarks)}','${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarksHint)}',data.remarksController,data.remarksNodeFocus!,false,callBack: (t){},key: const Key('remarkssanTsada'),),
            const DividerByHeight(14),
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

