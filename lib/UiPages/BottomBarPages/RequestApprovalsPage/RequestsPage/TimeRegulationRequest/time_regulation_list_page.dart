import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/AppConstants/app_constants.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/generic_app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/time_off_app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import '../../../../../BusinessLogicModel/Enums/request_enums.dart';
import '../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/TimeRegulationListener/time_regulation_list_listener.dart';
import '../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import '../../../../../BusinessLogicModel/Listeners/SettingListeners/settings_listeners.dart';
import '../../../../../BusinessLogicModel/Models/pop_with_results.dart';
import '../../../../../src/hide_keyboard.dart';
import '../../../../../src/lottie_string.dart';
import '../../../../../src/pages_name.dart';
import '../../../../../src/prints_logs.dart';
import '../../../../../src/snackbar_design.dart';
import '../../../../Reuse_Widgets/BottomSheetUi/bottom_sheet_ui.dart';
import '../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../../Reuse_Widgets/TopTabBar/top_tab_bar.dart';
import '../../../../Reuse_Widgets/circular_indicator_customized.dart';
import '../../../GlobalEmployeeSearchUi/call_employee_search_ui.dart';
import 'TimeRegulationListWidgets/time_regulation_list_widgets.dart';

class TimeRegulationListPage extends StatelessWidget {
  TimeRegulationListPage({Key? key}) : super(key: key);

  RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)?.settings.arguments as RequestDataTaker?;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TimeRegulationListListener>(create: (_) => TimeRegulationListListener()),
        ],
        builder: (context, snapshot) {
          return GetPageStarterScaffold(
            body: BodyData(requestDataTaker),
            appBar: Consumer<GlobalSelectedEmployeeController>(
                builder: (context, employeeData, child) {
                  return EmployeeAppBarWidget(
                    requestDataTaker?.title??'',
                    hidePlusButton: employeeData.apiStatus==ApiStatus.done?false:true,
                    selectEmployeeTap: () {
                      EmployeeSearchBottomSheet().show(
                          context,
                              (employeeInfoMapper)
                          {
                            Provider.of<TimeRegulationListListener>(context,listen: false).start(context, ApiStatus.started);
                          }
                      );
                    },
                    removeEmployeeTap: () async {
                      await employeeData.resetEmployee();
                      Provider.of<TimeRegulationListListener>(context,listen: false).start(context, ApiStatus.started);
                    },
                    addFormClick: () {
                      if(requestDataTaker?.requestsEnum == RequestsEnum.timeRegulationMisc)
                        {
                          Navigator.pushNamed(context, CurrentPage.TimeRegulationFetchDateListPage,arguments: requestDataTaker).then((value){
                            if(value!=null&&value is bool && value == true)
                            {
                              Provider.of<TimeRegulationListListener>(context,listen: false).start(context, ApiStatus.started);
                            }
                            else if(value!=null&&value is PopWithResults)
                            {
                              Provider.of<TimeRegulationListListener>(context,listen: false).start(context, ApiStatus.started);
                            }
                          });
                        }
                      else
                        {
                          Navigator.pushNamed(context, CurrentPage.MoveSlipFormPage,arguments: requestDataTaker).then((value){
                          if(value!=null&&value is bool && value == true)
                          {
                            Provider.of<TimeRegulationListListener>(context,listen: false).start(context, ApiStatus.started);
                          }
                        });
                        }
                    },
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
                      Provider.of<TimeRegulationListListener>(context,listen: false).start(context, ApiStatus.started);
                    }
                );
              }
          );

        }
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
      Provider.of<GlobalSelectedEmployeeController>(context,listen: false).resetEmployee();
      Provider.of<TimeRegulationListListener>(context,listen: false).typeId = widget.requestDataTaker?.requestsEnum == RequestsEnum.timeRegulationMovementSlip?AppConstants.movementSlipTypeId:1;
      Provider.of<TimeRegulationListListener>(context,listen: false).start(context, ApiStatus.started);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TimeRegulationListListener>(
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
                    return AttendanceRegulationWidget(index,data.dataList?[index],type: data.typeId,onTap: (){

                      widget.requestDataTaker?.extraData = data.dataList?[index];
                      Navigator.pushNamed(context, CurrentPage.TimeRegulationDetailPage,arguments: widget.requestDataTaker);

                      },);
                  },
                  separatorBuilder: (context,index){return SizedBox(height: ScreenSize(context).heightOnly(3),);},
                  itemCount: data.dataList?.length??0
              ),
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
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
}
class ExtraAttendanceRegulationData
{
  int? index;
  ExtraAttendanceRegulationData({this.index = 0});
}