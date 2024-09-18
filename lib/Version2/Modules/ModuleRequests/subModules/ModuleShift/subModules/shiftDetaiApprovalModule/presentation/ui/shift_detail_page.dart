import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleShift/subModules/shiftDetaiApprovalModule/presentation/listener/get_shift_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/applied_for_employee_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_history_view.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../../../../Version1/models/call_setting_data.dart';
import '../../../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';

import '../../../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../../utils/lottie_anims_utils/lottie_string.dart';
import '../../../../../../../../../utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import '../../../../../../../../../../utils/screenLoader/circular_indicator_customized.dart';
import '../../../../../../../../../Version1/views/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/CommonWidgets/approval_list_widget.dart';
import 'widget/shift_detail_widget.dart';

class ShiftDetailPage extends StatelessWidget {
  ShiftDetailPage({Key? key}) : super(key: key);
  late AllRequestDetailMapper allRequestDetailMapper;

  @override
  Widget build(BuildContext context) {
    allRequestDetailMapper = ModalRoute.of(context)!.settings.arguments as AllRequestDetailMapper;
    SettingsModelListener settingsModelListener = Provider.of<SettingsModelListener>(context,listen: false);
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<GetShiftDetailBloc>(create: (_) => GetShiftDetailBloc(AppStateNothing(),allRequestDetailMapper: allRequestDetailMapper))
        ],
        builder: (context) {
          return GetPageStarterScaffoldStateLess(
            title: settingsModelListener.settingsResultSet?.screenDetail?.firstWhere((element) => element.screenID.toString() == allRequestDetailMapper.screenID).screenName??'',
            body: BodyData(allRequestDetailMapper),
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
      BlocProvider.of<GetShiftDetailBloc>(context,listen: false).fetchShiftDetail(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetShiftDetailBloc,AppState>(
      listener: (context,data){

      },
        builder: (context, data) {
          if(data is AppStateDone)
          {
            return _ShiftDetailBodyView(widget.allRequestDetailMapper);
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
class _ShiftDetailBodyView extends StatelessWidget {
  final AllRequestDetailMapper allRequestDetailMapper;
  _ShiftDetailBodyView(this.allRequestDetailMapper, {super.key});

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    GetShiftDetailBloc shiftDetailBloc = BlocProvider.of<GetShiftDetailBloc>(context,listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 2), ScreenSize(context).widthOnly( 5.6), 0),
            child: ShiftDetailWidget(data: shiftDetailBloc.useCase.getShiftDetailResult()),
          ),
          const DividerByHeight(3),
          AppliedForEmployeeWidget(data: shiftDetailBloc.useCase.getShiftDetailResult()?.appliedForEmployee),
          const DividerByHeight(1),
          ApprovalHistoryView(approvalList: shiftDetailBloc.useCase.getApprovalListForView()),
          if(shiftDetailBloc.useCase.canAdminApprove() == true && allRequestDetailMapper.isApprovalScreen == true)...[
            SizedBox(height: ScreenSize(context).heightOnly( 4),),
            ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.announcementReject)}',buttonColor: MyColor.colorBlack,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: rejectPressed,),
            SizedBox(height: ScreenSize(context).heightOnly( 2),),
            ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.approvalBodyPanelButton2)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: approvePressed,),
            SizedBox(height: ScreenSize(context).heightOnly( 6),),
          ],

        ],
      ),
    );
  }

  void rejectPressed()
  {
    BlocProvider.of<GetShiftDetailBloc>(context,listen: false).actionButtonPressed(context,AcceptReject.reject,3);
  }

  void approvePressed()
  {
    BlocProvider.of<GetShiftDetailBloc>(context,listen: false).actionButtonPressed(context,AcceptReject.accept,2);
  }
}

