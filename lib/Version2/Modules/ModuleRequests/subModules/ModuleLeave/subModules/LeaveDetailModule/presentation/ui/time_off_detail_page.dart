import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/presentation/listener/get_leave_detail_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/presentation/listener/post_time_off_cancel_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/presentation/listener/time_off_detail_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/domain/models/time_off_cancel_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveApplyFormModule/domain/models/time_off_model.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/AcceptancePanels/approval_header_panel.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_rejection_page.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TimeOffPage/TimeOffSubPages/TimeOffPanel/time_off_cancel_panel_body.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/TimeOffPage/TimeOffSubPages/TimeOffPanel/time_off_cancel_panel_header.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/presentation/ui/widgets/time_off_view.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_history_view.dart';
import 'package:peopleqlik_debug/utils/Buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/ScreenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../../../utils/approval_heraricay_view.dart';
import '../../domain/models/get_leave_detail_model.dart';
import '../../../../../../../../../utils/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/utils/BottomSheetUi/bottom_sheet_ui.dart';
import '../../../../../../../../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/CommonWidgets/approval_list_widget.dart';
import '../../domain/models/time_off_detail_mapper.dart';

class TimeOffDetailPage extends StatelessWidget {
  late AllRequestDetailMapper allRequestDetailMapper;
  TimeOffDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    allRequestDetailMapper = ModalRoute.of(context)!.settings.arguments as AllRequestDetailMapper;
    return ExtendedMultiBlocProvider(
      providers: [
        BlocProvider<GetLeaveDetailBloc>(create: (_) => GetLeaveDetailBloc(AppStateNothing(),allRequestDetailMapper: allRequestDetailMapper),)
      ],
      builder: (context) {
        return MultiProvider(
          providers: [
            Provider<TimeOffCancelCollector>(create: (_) => TimeOffCancelCollector(),),
            ChangeNotifierProvider<TimeOffDetailListener>(create: (_) => TimeOffDetailListener())
          ],
          child: Scaffold(
            backgroundColor: const Color(MyColor.colorWhite),
              body: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar(
                        automaticallyImplyLeading: false,
                        pinned: false,
                        floating: true,
                        backgroundColor: const Color(MyColor.colorWhite),
                        snap: true,
                        elevation: 2,
                        titleSpacing: 0,
                        title: AppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.TimeOffDetail)}')
                    ),
                  ];
                },
                body: BodyData(),
              )
          ),
        );
      }
    );
  }
}
class BodyData extends StatefulWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Provider.of<TimeOffDetailListener>(context,listen: false).start(context, id, companyCode, employeeCode);
      BlocProvider.of<GetLeaveDetailBloc>(context,listen: false).fetchLeaveDetail(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    GetLeaveDetailBloc getLeaveDetailBloc = BlocProvider.of<GetLeaveDetailBloc>(context,listen: false);
    return BlocConsumer<GetLeaveDetailBloc,AppState>(
      listener: (context,data){},
      builder: (context, data) {
        if(data is AppStateDone)
          {

            return SizedBox(
              height: ScreenSize(context).heightOnly( 100),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    TimeOffViewWidget(data: getLeaveDetailBloc),
                    SizedBox(height: ScreenSize(context).heightOnly( 1),),
                    ApprovalHistoryView(approvalList: getLeaveDetailBloc.useCase.getApprovalListForView()),
                    if(getLeaveDetailBloc.useCase.getLeaveDetailResult()?.approvalStatusID == 1)...[
                      SizedBox(height:ScreenSize(context).heightOnly(6),),
                      Center(child: ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.timeOffDelete)}',buttonColor: MyColor.colorRed,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: cancelPressed,)),
                    ],
                    SizedBox(height:ScreenSize(context).heightOnly(16),),
                  ],
                ),
              ),
            );
          }
        else if(data is AppStateEmpty)
        {
          return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr11)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr12)}',topMargin: 8,width: 40,);
        }
        else if(data is AppStateError)
        {
          return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
        }
        else
        {
          return const CircularIndicatorCustomized();
        }
      }
    );

  }
  cancelPressed() async
  {
    Future.delayed(const Duration(milliseconds: 50),(){
      ShowBottomSheet.show(
          context,
          height: 90,
          body: LeaveCancelBody(),
          appBar: CancelPanelHeader(),
          callBack: (filterValues){
            if(filterValues!=null&&filterValues is String)
              {
                Future.delayed(const Duration(milliseconds: 100),(){
                  TimeOffCancelCollector timeOffCancelCollector = Provider.of<TimeOffCancelCollector>(context,listen: false);
                  timeOffCancelCollector.cancelLeaveJson?.cancelLeaveRemarks = filterValues;
                  timeOffCancelCollector.fillData(context,Provider.of<TimeOffDetailListener>(context,listen: false).timeOffDetailResultSet?.lObjLeaveApplication?.first);
                });
              }
          }
      );
    });
  }
  //TimeOffCancelCollector


}

class TimeDetailInfoWidget extends StatelessWidget {
  final String? header,value;
  const TimeDetailInfoWidget({this.header,this.value,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          header??'',
          style: GetFont.get(
              context,
              fontSize: 1.6,
              fontWeight: FontWeight.w600,
              color: MyColor.colorBlack
          ),
        ),
        Text(
          value??'',
          style: GetFont.get(
              context,
              fontSize: 1.6,
              fontWeight: FontWeight.w600,
              color: MyColor.colorBlack
          ),
        )
      ],
    );
  }
}
