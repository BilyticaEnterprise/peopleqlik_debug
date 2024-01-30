import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:provider/provider.dart';

import '../../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/OverTimeListeners/overtime_detail_api_listener.dart';
import '../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import '../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../src/colors.dart';
import '../../../../../../src/divider.dart';
import '../../../../../../src/fonts.dart';
import '../../../../../../src/language_codes.dart';
import '../../../../../../src/lottie_string.dart';
import '../../../../../../src/screen_sizes.dart';
import '../../../../../Reuse_Widgets/Appbars/generic_app_bar.dart';
import '../../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../../../Reuse_Widgets/ErrorsUi/not_available.dart';
import '../../../../../Reuse_Widgets/circular_indicator_customized.dart';
import '../../../ApprovalsSubPages/ApprovalsAcceptance/CommonWidgets/approval_list_widget.dart';
import '../OverTimeDashBoardTeamRequest/UiWidgets/overtime_dashboard_list_widget.dart';
import 'overtime_detail_widget.dart';

class OvertimeDetailPage extends StatelessWidget {
  OvertimeDetailPage({Key? key}) : super(key: key);

  late RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)?.settings.arguments as RequestDataTaker;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<OvertimeDetailListener>(create: (_) => OvertimeDetailListener(requestDataTaker?.extraData))
        ],
        builder: (context, snapshot) {
          return GetPageStarterScaffold(
            body: BodyData(),
            appBar: Consumer<GlobalSelectedEmployeeController>(
                builder: (context, employeeData, child) {
                  return EmployeeAppBarWidget(
                    requestDataTaker?.title??'',
                    hideEmployeeSearch: true,
                    hidePlusButton: true,
                    selectEmployeeTap: () {
                      // EmployeeSearchBottomSheet().show(
                      //     context,
                      //         (employeeInfoMapper)
                      //     {
                      //       Provider.of<OverTimeListListener>(context,listen: false).start(context, ApiStatus.started);
                      //     }
                      // );
                    },
                    employeeInfoMapper: employeeData.getEmployee(), removeEmployeeTap: () {  },
                  );
                }
            ),
          );
        }
    );
  }
}
class BodyData extends StatefulWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<OvertimeDetailListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<OvertimeDetailListener>(
      builder: (context, data, child) {
        if(data.apiStatus == ApiStatus.done)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListView.separated(
                      padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 2), ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly(4)),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return OverTimeDetailWidget(data.overTimeEmployeeModel?[index],index);
                      },
                      separatorBuilder: (context,index){
                        return const DividerVertical(3);
                      },
                      itemCount: data.overTimeEmployeeModel?.length??0
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 1),),
                  if(data.uniqueList!=null&&data.uniqueList!.isNotEmpty&&data.approvalsList!=null&&data.approvalsList!.isNotEmpty)...
                  [
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                      child: Text(
                        '${CallLanguageKeyWords.get(context, LanguageCodes.ApprovalHistory)}',
                        style: GetFont.get(
                            context,
                            fontWeight: FontWeight.w700,
                            fontSize: 2.2,
                            color: MyColor.colorBlack
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 1.5),),
                    Flexible(
                        flex: 1,
                        child: ApprovalListWidget(data.approvalsList)
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly(16),),
                  ],
                ],
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
