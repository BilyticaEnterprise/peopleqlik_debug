import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeDetailModule/presentation/listener/get_overtime_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/applied_for_employee_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_history_view.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../../../../../../Version1/models/call_setting_data.dart';
import '../../../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../../utils/Appbars/generic_app_bar.dart';
import '../../../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../../utils/lottie_anims_utils/lottie_string.dart';
import '../../../../../../../../../utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import '../../../../../../../../../../utils/screenLoader/circular_indicator_customized.dart';
import '../../../../../../../../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/CommonWidgets/approval_list_widget.dart';
import '../../../../../../../ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'widget/overtime_detail_widget.dart';

class OvertimeDetailPage extends StatelessWidget {
  OvertimeDetailPage({Key? key}) : super(key: key);

  late AllRequestDetailMapper allRequestDetailMapper;

  @override
  Widget build(BuildContext context) {
    allRequestDetailMapper = ModalRoute.of(context)!.settings.arguments as AllRequestDetailMapper;
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<GetOvertimeDetailBloc>(create: (_) => GetOvertimeDetailBloc(AppStateNothing(), allRequestDetailMapper: allRequestDetailMapper,))
        ],
        builder: (context) {
          return GetPageStarterScaffoldStateLess(
            body: BodyData(allRequestDetailMapper),
            appBar: Consumer<GlobalSelectedEmployeeController>(
                builder: (context, employeeData, child) {
                  return EmployeeAppBarWidget(
                    settingsModelListener.settingsResultSet?.screenDetail?.firstWhere((element) => element.screenID.toString() == allRequestDetailMapper.screenID).screenName??'',
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
  final AllRequestDetailMapper allRequestDetailMapper;
  const BodyData(this.allRequestDetailMapper, {Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      BlocProvider.of<GetOvertimeDetailBloc>(context,listen: false).fetchOvertimeDetail(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetOvertimeDetailBloc,AppState>(
      listener: (context,data){},
      builder: (context, data) {
        if(data is AppStateDone)
          {
            return _BodyDataNow(widget.allRequestDetailMapper);
          }
        else if(data is AppStateEmpty)
        {
          return NotAvailable(LottieString.notAvailable, '${CallLanguageKeyWords.get(context, LanguageCodes.noInfoAvailableHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.noInfoAvailableValue)}',topMargin: 8,width: 40,);
        }
        else if(data is AppStateError)
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

class _BodyDataNow extends StatelessWidget {
  final AllRequestDetailMapper allRequestDetailMapper;
  _BodyDataNow(this.allRequestDetailMapper, {super.key});

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    GetOvertimeDetailBloc data = BlocProvider.of<GetOvertimeDetailBloc>(context,listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
              padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 2), ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly(4)),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context,index){
                return OverTimeDetailWidget(data.useCase.getOvertimeDetailResult()?[index],index);
              },
              separatorBuilder: (context,index){
                return const DividerByHeight(3);
              },
              itemCount: data.useCase.getOvertimeDetailResult()?.length??0
          ),
          // const DividerByHeight(3),
          // AppliedForEmployeeWidget(data: data.useCase.getOvertimeDetailResult()?.appliedForEmployee),
          // const DividerByHeight(1),
          ApprovalHistoryView(approvalList: data.useCase.getApprovalListForView()),
          if(data.useCase.canAdminApprove() == true && allRequestDetailMapper.isApprovalScreen == true)...[
            SizedBox(height: ScreenSize(context).heightOnly( 4),),
            ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.announcementReject)}',buttonColor: MyColor.colorBlack,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: rejectPressed,),
            SizedBox(height: ScreenSize(context).heightOnly( 2),),
            ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.approvalBodyPanelButton2)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: approvePressed,),
            SizedBox(height: ScreenSize(context).heightOnly( 6),),
          ],

          SizedBox(height: ScreenSize(context).heightOnly( 10),),

        ],
      ),
    );
  }
  void rejectPressed()
  {
    BlocProvider.of<GetOvertimeDetailBloc>(context,listen: false).actionButtonPressed(context,AcceptReject.reject,3);
  }

  void approvePressed()
  {
    BlocProvider.of<GetOvertimeDetailBloc>(context,listen: false).actionButtonPressed(context,AcceptReject.accept,2);
  }
}
