import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeFormModule/presentation/listener/overtime_form_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeFormModule/presentation/ui/UiWidgets/employee_list_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeFormModule/presentation/ui/UiWidgets/overtime_bottom_bar.dart';
import 'package:provider/provider.dart';

import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import '../../../../../../../../../../Version1/models/RequestsModel/request_data_taker.dart';
import '../../../../../../../../../../../Version1/models/call_setting_data.dart';
import '../../../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../../utils/lottie_anims_utils/lottie_string.dart';
import '../../../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../../../../../utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import '../../../../../../../../../../utils/screenLoader/circular_indicator_customized.dart';
import '../../../../../../../../../Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/TimeRegulationRequest/TimeRegulationFormPage/TimeRegulationFetchDateListPages/ExtraWidgets/filter_icon.dart';


class OverTimeFormPage extends StatelessWidget {
  OverTimeFormPage({Key? key}) : super(key: key);

  RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)?.settings.arguments as RequestDataTaker?;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<OverTimeFormListener>(create: (_) => OverTimeFormListener()),
        ],
        builder: (context, snapshot) {
          return GetPageStarterScaffoldStateLess(
            body: BodyData(),
            action: FilterWidget(
                    (){
                  Provider.of<OverTimeFormListener>(context,listen: false).callFilter(context);
                }
            ),
            title: requestDataTaker?.title??'',
            bottomNavigationBar: OverTimeBottomBar(
              onTap: (){
                Provider.of<OverTimeFormListener>(context,listen: false).submit(context);
              },
            )
          );
        }
    );
  }
}
class BodyData extends StatelessWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OverTimeFormListener>(
        builder: (context, data, child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 2), ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly(16)),
                itemBuilder: (context,index){
                  return EmployeeListWidget(teamDataList: data.overtimeFilterMapper?.employeeList?[index],
                    length: data.getLengthOfSelectedDates(data.overtimeHourFilterMapper?[index].employeeDateTimeList),
                    onTap: ()
                    {
                      data.callHourBottomSheet(context,index);
                      },
                  );
                },
                separatorBuilder: (context,index){return SizedBox(height: ScreenSize(context).heightOnly(3),);},
                itemCount: data.overtimeFilterMapper?.employeeList?.length??0
            );
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable(LottieString.notAvailable, '${CallLanguageKeyWords.get(context, LanguageCodes.noInfoAvailableHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.noInfoAvailableValue)}',topMargin: 8,width: 40,);
          }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
          }
          else if(data.apiStatus == ApiStatus.nothing)
          {
            return NotAvailable(LottieString.overtime, '${CallLanguageKeyWords.get(context, LanguageCodes.overtimeSelectFilterHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.overtimeSelectFilterValue)}',topMargin: 8,width: 30,action: ButtonWidget(text: CallLanguageKeyWords.get(context, LanguageCodes.overtimeSelectFilterButtonValue)??'',buttonColor: MyColor.colorPrimary,textSize: 1.8,textColor: MyColor.colorWhite,height: 6.2,elevation: 0,width: ScreenSize(context).widthOnly(60),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: (){Provider.of<OverTimeFormListener>(context,listen: false).callFilter(context);},),);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }

}
