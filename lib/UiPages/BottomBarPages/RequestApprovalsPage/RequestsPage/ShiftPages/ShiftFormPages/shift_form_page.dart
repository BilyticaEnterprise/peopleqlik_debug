import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/src/divider.dart';
import 'package:provider/provider.dart';

import '../../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/ShiftListener/shift_form_listener.dart';
import '../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import '../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../src/colors.dart';
import '../../../../../../src/language_codes.dart';
import '../../../../../../src/screen_sizes.dart';
import '../../../../../Reuse_LogicalWidgets/current_employee_name_note.dart';
import '../../../../../Reuse_Widgets/Appbars/generic_app_bar.dart';
import '../../../../../Reuse_Widgets/Buttons/buttons.dart';
import '../../../../../Reuse_Widgets/DatePickText/date_picker_text_style_1.dart';
import '../../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../../../Reuse_Widgets/DropDowns/drop_down_header.dart';
import '../../../../../Reuse_Widgets/DropDowns/drop_down_multiple.dart';
import '../../../../../Reuse_Widgets/circular_indicator_customized.dart';
import '../../../../GlobalEmployeeSearchUi/call_employee_search_ui.dart';

class ShiftFormPage extends StatelessWidget {
  ShiftFormPage({Key? key}) : super(key: key);

  RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    Provider.of<GlobalSelectedEmployeeController>(context,listen: false).saveTempEmployee();
    requestDataTaker = ModalRoute.of(context)?.settings.arguments as RequestDataTaker?;

    return WillPopScope(
      onWillPop: ()async{
        Provider.of<GlobalSelectedEmployeeController>(context,listen: false).specialPop(context);
        return false;
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<ShiftFormListener>(create: (_) => ShiftFormListener(context))
        ],
        builder: (context, snapshot) {
          return GetPageStarterScaffold(
            body: BodyNow(),
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
                            Provider.of<ShiftFormListener>(context,listen: false).start(context);
                          }
                      );
                    },
                    removeEmployeeTap: () async {
                      await employeeData.resetEmployee();
                      Provider.of<ShiftFormListener>(context,listen: false).start(context);
                    },
                    hidePlusButton: true,
                    employeeInfoMapper: employeeData.getEmployee(),
                  );
                }
            ),
              checkEmployeeIfExistInCurrentCompany: Provider.of<GlobalSelectedEmployeeController>(context,listen: false).checkIfCurrentUserCompanyMatches(),
              employeeChangeCurrentCompanyTap: (){
                EmployeeSearchBottomSheet().show(
                    context,
                        (employeeInfoMapper)
                    {
                      Provider.of<ShiftFormListener>(context,listen: false).start(context);
                    }
                );
              }
          );
        }
      ),
    );
  }
}
class BodyNow extends StatelessWidget {
  const BodyNow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ShiftFormListener>(
      builder: (context, data, child) {
        if(data.apiStatus == ApiStatus.done)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CurrentEmployeeNoteWidget(),
                  const DividerVertical(2),
                  HeaderDropDownField(dropDownDataType: data.regularShiftTypeDropDown!, header:'${CallLanguageKeyWords.get(context, LanguageCodes.regularShift)}', key: Key('regular${data.refreshKeyNumber}'), isCompulsory: true, onSelectedDropDown: data.dropDownCallBack,isEnabled: true),
                  const DividerVertical(3),
                  HeaderDropDownField(dropDownDataType: data.ramdaanShiftTypeDropDown!, header:'${CallLanguageKeyWords.get(context, LanguageCodes.ramzanShift)}', key: Key('ramzan${data.refreshKeyNumber}'), isCompulsory: false, onSelectedDropDown: data.dropDownCallBack,isEnabled: true),
                  const DividerVertical(3),
                  MultiHeaderDropDownField(dropDownDataType: data.listOfDays!, header:'${CallLanguageKeyWords.get(context, LanguageCodes.offDays)}', key: Key('listDays${data.refreshKeyNumber}'), isCompulsory: true, onSelectedDropDown: data.multiDropDownCallBack,isEnabled: true),
                  const DividerVertical(3),
                  DatePickerTextStyle1(Key('dateKey${data.refreshKeyNumber}'),'${CallLanguageKeyWords.get(context, LanguageCodes.select)} ${CallLanguageKeyWords.get(context, LanguageCodes.effectiveDate)}', dateController: data.effectiveDateController!, textFieldHeader: '${CallLanguageKeyWords.get(context, LanguageCodes.effectiveDate)}',minDate: DateTime.now().subtract(const Duration(days: 800)),isCompulsory: true,margin: 6.0,padding: 4,),
                  const DividerVertical(8),
                  ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestsaddFormButton)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: (){data.confirmPressed(context);},),
                  const DividerVertical(16),

                ],
              ),
            );
          }
        else
          {
            return const CircularIndicatorCustomized();
          }
      }
    );
  }
}
