import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleTimeRegulationAndMovement/subModules/timeRegulationMovementModule/subModules/timeRegulationAndMovementDetailModule/presentation/listeners/get_time_regulation_movement_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/applied_for_employee_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_history_view.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_remarks_sheet/call_remarks_bottom_sheet.dart';
import 'package:peopleqlik_debug/utils/States/app_state.dart';
import 'package:peopleqlik_debug/utils/bloc_logic_utils/bloc_provider_extended.dart';
import 'package:peopleqlik_debug/utils/buttons/buttons.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';

import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import '../../../../../../../../../../../../../../Version1/models/call_setting_data.dart';
import '../../../../../../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../../../../../utils/lottie_anims_utils/lottie_string.dart';
import '../../../../../../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../../../../../../../../utils/screen_sizes.dart';

import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import '../../../../../../../../../../../../../utils/screenLoader/circular_indicator_customized.dart';
import '../../../../../../../ModuleSeparation/submodule/separationDetail/presentaion/ui/request_separation_detail_page.dart';

class TimeRegulationAndMovementDetailPage extends StatelessWidget {
  TimeRegulationAndMovementDetailPage({Key? key}) : super(key: key);
  late AllRequestDetailMapper allRequestDetailMapper;

  @override
  Widget build(BuildContext context) {
    allRequestDetailMapper = ModalRoute.of(context)!.settings.arguments as AllRequestDetailMapper;
    return ExtendedMultiBlocProvider(
        providers: [
          BlocProvider<GetTimeRegulationMovementDetailBloc>(create: (_) => GetTimeRegulationMovementDetailBloc(AppStateNothing(),allRequestDetailMapper: allRequestDetailMapper))
        ],
        builder: (context) {
          return GetPageStarterScaffoldStateLess(
            title: 'Detail',
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
      BlocProvider.of<GetTimeRegulationMovementDetailBloc>(context,listen: false).fetchTimeRegulationMovementDetail(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetTimeRegulationMovementDetailBloc, AppState>(
      listener: (context,data){},
        builder: (context,data) {
          if(data is AppStateDone)
          {
            return BodyDataNow(widget.allRequestDetailMapper);
          }
          else if(data is AppStateEmpty)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableH)}', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableA)}',topMargin: 8,width: 30);
          }
          else if(data is AppStateError)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableH)}', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableA)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
}
class BodyDataNow extends StatelessWidget {
  AllRequestDetailMapper allRequestDetailMapper;
  BodyDataNow(this.allRequestDetailMapper, {Key? key}) : super(key: key);

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    GetTimeRegulationMovementDetailBloc data = BlocProvider.of<GetTimeRegulationMovementDetailBloc>(context,listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: ScreenSize(context).heightOnly( 2),),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(5.6)),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: const Color(MyColor.colorBackgroundDark),
                  width: 1,
                )
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail1)??'',GetDateFormats().getFilterDate(data.useCase.getTimeRegulationDetailResult()?.reqDate)),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail2)??'',data.useCase.getTimeRegulationDetailResult()?.statusName),
                  if(data.useCase.getTimeRegulationDetailResult()?.typeID == AppConstants.movementSlipTypeId)...[
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail3)??'',GetDateFormats().getFilterDateTime(data.useCase.getTimeRegulationDetailResult()?.waiveOffTimeIn)),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail4)??'',GetDateFormats().getFilterDateTime(data.useCase.getTimeRegulationDetailResult()?.waiveOffTimeOut)),
                  ],
                  if(data.useCase.getTimeRegulationDetailResult()?.typeID != AppConstants.movementSlipTypeId)...[
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail6)??'',GetDateFormats().getFilterDateTime(data.useCase.getTimeRegulationDetailResult()?.timeIn)),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail7)??'',GetDateFormats().getFilterDateTime(data.useCase.getTimeRegulationDetailResult()?.timeOut)),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail8)??'',GetDateFormats().getFilterDateTime(data.useCase.getTimeRegulationDetailResult()?.waiveOffTimeIn)),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail9)??'',GetDateFormats().getFilterDateTime(data.useCase.getTimeRegulationDetailResult()?.waiveOffTimeOut)),
                  ],
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail5)??'',data.useCase.getTimeRegulationDetailResult()?.waiveOffRemarks),
                ],
              ),
            ),
          ),
          const DividerByHeight(3),
          AppliedForEmployeeWidget(data: data.useCase.getTimeRegulationDetailResult()?.appliedForEmployee),
          const DividerByHeight(1),
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
    BlocProvider.of<GetTimeRegulationMovementDetailBloc>(context,listen: false).actionButtonPressed(context,AcceptReject.reject,3);
  }

  void approvePressed()
  {
    BlocProvider.of<GetTimeRegulationMovementDetailBloc>(context,listen: false).actionButtonPressed(context,AcceptReject.accept,2);
  }
}
