import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:provider/provider.dart';

import '../../../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/employee_info_mapper.dart';
import '../../../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/TimeRegulationListener/TimeRegulationFormListeners/TimeRegulationFetchDateListListeners/time_regulation_filter_listener.dart';
import '../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/TimeRegulationListener/TimeRegulationFormListeners/TimeRegulationFetchDateListListeners/time_regulation_form_list_listener.dart';
import '../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import '../../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../../src/colors.dart';
import '../../../../../../../src/divider.dart';
import '../../../../../../../src/language_codes.dart';
import '../../../../../../../src/lottie_string.dart';
import '../../../../../../../src/screen_sizes.dart';
import '../../../../../../Reuse_Widgets/Appbars/generic_app_bar.dart';
import '../../../../../../Reuse_Widgets/BottomSheetUi/bottom_sheet_ui.dart';
import '../../../../../../Reuse_Widgets/Buttons/buttons.dart';
import '../../../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../../../../Reuse_Widgets/ErrorsUi/not_available.dart';
import '../../../../../../Reuse_Widgets/circular_indicator_customized.dart';
import '../../../../../GlobalEmployeeSearchUi/call_employee_search_ui.dart';
import 'ExtraWidgets/filter_body_ui.dart';
import 'ExtraWidgets/filter_icon.dart';
import 'ExtraWidgets/time_regulation_form_fetch_list_page.dart';

class TimeRegulationFetchDateListPage extends StatelessWidget {
  TimeRegulationFetchDateListPage({Key? key}) : super(key: key);

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
            ChangeNotifierProvider<TimeRegulationFormFetchListListener>(create: (_) => TimeRegulationFormFetchListListener(context)),
            ChangeNotifierProvider<TimeRegulationFilterListener>(create: (_) => TimeRegulationFilterListener(context))
          ],
          builder: (context, snapshot) {
            return GetPageStarterScaffold(
              body: BodyData(requestDataTaker),
              appBar: Consumer<GlobalSelectedEmployeeController>(
                  builder: (context, employeeData, child) {
                    return EmployeeAppBarWidget(
                      requestDataTaker?.title??'',
                      onBackTap: (){
                        Provider.of<GlobalSelectedEmployeeController>(context,listen: false).specialPop(context);
                      },
                      rightPadding: 3.4,
                      actionWidget: FilterWidget(
                              (){
                                ShowBottomSheet.show(
                                    context,
                                    height: 90,
                                    body: FilterBodyUi(Provider.of<TimeRegulationFormFetchListListener>(context,listen: false),Provider.of<TimeRegulationFilterListener>(context,listen: false)),
                                    onDoneTap: (){
                                      Navigator.pop(context);
                                      Provider.of<TimeRegulationFormFetchListListener>(context,listen: false).updateFilters(context,Provider.of<TimeRegulationFilterListener>(context,listen: false).filterData);
                                    }
                                );
                              }
                              ),
                      selectEmployeeTap: () {
                        EmployeeSearchBottomSheet().show(
                            context,
                                (employeeInfoMapper)
                            {
                              Provider.of<TimeRegulationFormFetchListListener>(context,listen: false).resetAll(context);
                            }
                        );
                      },
                      removeEmployeeTap: () async {
                        await employeeData.resetEmployee();
                        Provider.of<TimeRegulationFormFetchListListener>(context,listen: false).resetAll(context);
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
                        Provider.of<TimeRegulationFormFetchListListener>(context,listen: false).resetAll(context);
                      }
                  );
                }
            );
          }
      ),
    );
  }
}
class BodyData extends StatefulWidget {
  final RequestDataTaker? requestDataTaker;
  const BodyData(this.requestDataTaker, {Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      TimeRegulationFormFetchListListener timeRegulationFormFetchListListener = Provider.of<TimeRegulationFormFetchListListener>(context,listen: false);
      Provider.of<TimeRegulationFilterListener>(context,listen: false).updateFilter(timeRegulationFormFetchListListener.filterData);
      timeRegulationFormFetchListListener.start(context, ApiStatus.started);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TimeRegulationFormFetchListListener>(
        builder: (context, data, child) {
          if(data.apiStatus == ApiStatus.done||data.apiStatus == ApiStatus.pagination)
          {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification){
                if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                {
                  data.updateStep(true, context);
                  return true;
                }
                else
                {
                  data.updateStep(false, context);
                  return false;
                }
              },
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 2), ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly(16)),
                  itemBuilder: (context,index){
                    return TimeRegulationFormFetchListWidget(index,data.dataList?[index],onTap: (){
                      Navigator.pushNamed(context, CurrentPage.TimeRegulationFormPage, arguments: RequestDataTaker(widget.requestDataTaker?.title,extraData: data.dataList?[index])).then((value){
                        if(value!=null && value is bool && value==true)
                          {
                            Provider.of<TimeRegulationFormFetchListListener>(context,listen: false).start(context, ApiStatus.started);
                          }
                      });
                    },);
                  },
                  separatorBuilder: (context,index){return SizedBox(height: ScreenSize(context).heightOnly(3),);},
                  itemCount: data.dataList?.length??0
              ),
            );
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable(LottieString.notAvailable, '${CallLanguageKeyWords.get(context, LanguageCodes.noInfoAvailableHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationFilterCallDescription)}',topMargin: 8,width: 40,action: ButtonWidget(text: CallLanguageKeyWords.get(context, LanguageCodes.overtimeSelectFilterButtonValue)??'',buttonColor: MyColor.colorPrimary,textSize: 1.8,textColor: MyColor.colorWhite,height: 6.2,elevation: 0,width: ScreenSize(context).widthOnly(60),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: (){
              ShowBottomSheet.show(
                  context,
                  height: 90,
                  body: FilterBodyUi(Provider.of<TimeRegulationFormFetchListListener>(context,listen: false),Provider.of<TimeRegulationFilterListener>(context,listen: false)),
                  onDoneTap: (){
                    Navigator.pop(context);
                    Provider.of<TimeRegulationFormFetchListListener>(context,listen: false).updateFilters(context,Provider.of<TimeRegulationFilterListener>(context,listen: false).filterData);
                  }
              );
            },),);
          }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
}
