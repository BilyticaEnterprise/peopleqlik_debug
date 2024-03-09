import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/TimeRegulationListener/approval_time_regulation_detail_listener.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:provider/provider.dart';

import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import '../../../../../../Version1/viewModel/Approvals/approvals_accept_listener.dart';
import '../../../../../../Version1/viewModel/Approvals/approvals_detail_collector.dart';
import '../../../../../../Version1/Models/ApprovalsModel/approval_result_set_data.dart';
import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../utils/lottie_anims_utils/lottie_string.dart';
import '../../../../../../../utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/Buttons/buttons.dart';
import '../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import '../../../../../../../../utils/ScreenLoader/circular_indicator_customized.dart';
import '../../RequestsPage/SeperationRequestPages/request_separation_detail_page.dart';
import 'AcceptancePanels/approval_body_panel.dart';
import 'AcceptancePanels/approval_header_panel.dart';
import 'CommonWidgets/approval_list_widget.dart';
import 'CommonWidgets/call_bottom_sheet_for_remarks.dart';
import 'approval_acceptance_rejection_page.dart';

class AcceptanceTimeRegulationPage extends StatelessWidget {
  AcceptanceTimeRegulationPage({Key? key}) : super(key: key);

  ApprovalResultSetData? approvalResultSetData;

  @override
  Widget build(BuildContext context) {
    approvalResultSetData = ModalRoute.of(context)!.settings.arguments as ApprovalResultSetData;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ApprovalsDetailCollector>(create: (_) => ApprovalsDetailCollector()),
          ChangeNotifierProvider<ApprovalsAcceptRejectCollector>(create: (_) => ApprovalsAcceptRejectCollector()),
          ChangeNotifierProvider<ApprovalAcceptanceTimeRegulationListener>(create: (_) => ApprovalAcceptanceTimeRegulationListener())
        ],
      builder: (context, snapshot) {
        return GetPageStarterScaffoldStateLess(
          title: '${CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationApproval)}',
          body: BodyData(approvalResultSetData),
        );
      }
    );
  }
}
class BodyData extends StatefulWidget {
  final ApprovalResultSetData? approvalResultSetData;
  const BodyData(this.approvalResultSetData,{Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApprovalsDetailCollector>(context,listen: false).approvalDetailMapper = widget.approvalResultSetData?.approvalDetailMapper;
      Provider.of<ApprovalAcceptanceTimeRegulationListener>(context,listen: false).start(context, widget.approvalResultSetData?.approvalDetailMapper);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ApprovalAcceptanceTimeRegulationListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return BodyDataNow(widget.approvalResultSetData);
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable(LottieString.errorAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableH)}', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableA)}',topMargin: 8,width: 30);
          }
          else if(data.apiStatus == ApiStatus.error)
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
  final ApprovalResultSetData? approvalResultSetData;

  BodyDataNow(this.approvalResultSetData, {Key? key}) : super(key: key);

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    ApprovalAcceptanceTimeRegulationListener data = Provider.of<ApprovalAcceptanceTimeRegulationListener>(context,listen: false);
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
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail1)??'',GetDateFormats().getFilterDate(data.timeRegulationLeaveDetail?[0].requestDate)),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail2)??'',data.timeRegulationLeaveDetail?[0].waiveOffStatus),
                  if(data.timeRegulationLeaveDetail?[0].typeID == AppConstants.movementSlipTypeId)...[
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail3)??'',GetDateFormats().getFilterDateTime(data.timeRegulationLeaveDetail?[0].waiveOffTimeIn)),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail4)??'',GetDateFormats().getFilterDateTime(data.timeRegulationLeaveDetail?[0].waiveOffTimeOut)),
                  ],
                  if(data.timeRegulationLeaveDetail?[0].typeID != AppConstants.movementSlipTypeId)...[
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail6)??'',GetDateFormats().getFilterDateTime(data.timeRegulationLeaveDetail?[0].timeIn)),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail7)??'',GetDateFormats().getFilterDateTime(data.timeRegulationLeaveDetail?[0].timeOut)),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail8)??'',GetDateFormats().getFilterDateTime(data.timeRegulationLeaveDetail?[0].waiveOffTimeIn)),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail9)??'',GetDateFormats().getFilterDateTime(data.timeRegulationLeaveDetail?[0].waiveOffTimeOut)),
                  ],
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail5)??'',data.timeRegulationLeaveDetail?[0].waiveOffRemarks),
                ],
              ),
            ),
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
              //fit: FlexFit.loose,
                flex: 1,
                child: ApprovalListWidget(data.approvalsList)
            ),
          ],
          if(approvalResultSetData?.show == true)...[
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
    Provider.of<ApprovalsDetailCollector>(context,listen: false).updateType(AcceptReject.reject);
    CallBottomSheetForRemarks().call(context, Provider.of<ApprovalsDetailCollector>(context,listen: false), Provider.of<ApprovalsAcceptRejectCollector>(context,listen: false));
  }
  void approvePressed()
  {
    Provider.of<ApprovalsDetailCollector>(context,listen: false).updateType(AcceptReject.accept);
    CallBottomSheetForRemarks().call(context, Provider.of<ApprovalsDetailCollector>(context,listen: false), Provider.of<ApprovalsAcceptRejectCollector>(context,listen: false));
  }
}
