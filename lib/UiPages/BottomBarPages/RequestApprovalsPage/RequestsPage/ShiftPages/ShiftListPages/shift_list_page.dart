import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../BusinessLogicModel/Enums/apistatus_enum.dart';
import '../../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/ShiftListener/shift_list_listener.dart';
import '../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import '../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../src/language_codes.dart';
import '../../../../../../src/lottie_string.dart';
import '../../../../../../src/pages_name.dart';
import '../../../../../../src/screen_sizes.dart';
import '../../../../../Reuse_LogicalWidgets/skeleton_list_widget.dart';
import '../../../../../Reuse_Widgets/Appbars/generic_app_bar.dart';
import '../../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../../../Reuse_Widgets/ErrorsUi/not_available.dart';
import '../../../../../Reuse_Widgets/circular_indicator_customized.dart';
import '../../../../GlobalEmployeeSearchUi/call_employee_search_ui.dart';
import 'UiWidgets/shift_list_widget.dart';

class ShiftListPage extends StatelessWidget {
  ShiftListPage({Key? key}) : super(key: key);

  RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)?.settings.arguments as RequestDataTaker?;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ShiftListListener>(create: (_) => ShiftListListener()),
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
                              Provider.of<ShiftListListener>(context,listen: false).start(context, ApiStatus.started);
                            }
                        );
                      },
                      removeEmployeeTap: () async {
                        await employeeData.resetEmployee();
                        Provider.of<ShiftListListener>(context,listen: false).start(context, ApiStatus.started);
                      },
                      addFormClick: () {
                        Navigator.pushNamed(context, CurrentPage.ShiftFormPage,arguments: requestDataTaker).then((value){
                          if(value!=null&&value is bool && value == true)
                          {
                            Provider.of<ShiftListListener>(context,listen: false).start(context, ApiStatus.started);
                          }
                        });
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
                      Provider.of<ShiftListListener>(context,listen: false).start(context, ApiStatus.started);
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
      Provider.of<ShiftListListener>(context,listen: false).start(context, ApiStatus.started);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ShiftListListener>(
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
                    if(data.reachedEnd&&index==data.dataList!.length-1) {
                      return SkeletonListWidget(index,height: 22,);
                    } else {
                      return ShiftListWidget(
                      index: index,
                      data: data.dataList?[index],
                        onTap: (){
                          widget.requestDataTaker?.extraData = data.dataList?[index];
                        Navigator.pushNamed(context, CurrentPage.ShiftDetailPage, arguments: widget.requestDataTaker);
                        },
                    );
                    }
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
