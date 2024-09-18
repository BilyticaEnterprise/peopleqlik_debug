import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/TimeOffAndEnCashModel/overtime_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeListModule/presentation/listener/overtime_list_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeListModule/presentation/ui/UiWidgets/overtime_list_widget.dart';
import 'package:provider/provider.dart';

import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import '../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../../../../Version1/models/RequestsModel/request_data_taker.dart';
import '../../../../../../../../../../../../Version1/models/call_setting_data.dart';
import '../../../../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../../../utils/lottie_anims_utils/lottie_string.dart';
import '../../../../../../../../../configs/routing/pages_name.dart';
import '../../../../../../../../../utils/Appbars/generic_app_bar.dart';
import '../../../../../../../../../../utils/screen_sizes.dart';
import '../../../../../../../../../utils/Reuse_LogicalWidgets/skeleton_list_widget.dart';
import '../../../../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import '../../../../../../../../../../../utils/screenLoader/circular_indicator_customized.dart';

class OverTimeListPage extends StatelessWidget {
  OverTimeListPage({Key? key}) : super(key: key);

  RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)?.settings.arguments as RequestDataTaker?;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<OverTimeListListener>(create: (_) => OverTimeListListener())
      ],
      builder: (context, snapshot) {
        return GetPageStarterScaffoldStateLess(
          body: BodyData(requestDataTaker),
          appBar: Consumer<GlobalSelectedEmployeeController>(
              builder: (context, employeeData, child) {
                return EmployeeAppBarWidget(
                  requestDataTaker?.title??'',
                  hideEmployeeSearch: true,
                  selectEmployeeTap: () {
                  },
                  removeEmployeeTap: () async {
                  },
                  addFormClick: () {
                    Navigator.pushNamed(context, CurrentPage.OverTimeFormPage,arguments: requestDataTaker).then((value){
                      if(value!=null&&value is bool && value == true)
                      {
                       Provider.of<OverTimeListListener>(context,listen: false).start(context, ApiStatus.started);
                      }
                    });
                  },
                  employeeInfoMapper: employeeData.getEmployee(),
                );
              }
          ),

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
      Provider.of<OverTimeListListener>(context,listen: false).start(context, ApiStatus.started);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<OverTimeListListener>(
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
                      return OverTimeActualListWidget(index,data.dataList?[index],onTap: (){
                        OvertimeListData overtimeListData = data.dataList?[index];
                        Navigator.pushNamed(context, CurrentPage.OvertimeDetailPage,arguments: AllRequestDetailMapper(documentNumber: overtimeListData.documentNo,companyCode: overtimeListData.companyCode.toString(),screenID: overtimeListData.screenID.toString(),isApprovalScreen: false));
                      },);
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
