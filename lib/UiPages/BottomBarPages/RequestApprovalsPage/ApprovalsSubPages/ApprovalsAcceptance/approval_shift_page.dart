import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../BusinessLogicModel/Enums/apistatus_enum.dart';
import '../../../../../BusinessLogicModel/Listeners/Approvals/approvals_accept_listener.dart';
import '../../../../../BusinessLogicModel/Listeners/Approvals/approvals_detail_collector.dart';
import '../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/ShiftListener/acceptance_rejection_shift_approval_listener.dart';
import '../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/ShiftListener/shift_detail_listener.dart';
import '../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../src/colors.dart';
import '../../../../../src/fonts.dart';
import '../../../../../src/language_codes.dart';
import '../../../../../src/lottie_string.dart';
import '../../../../../src/screen_sizes.dart';
import '../../../../Reuse_Widgets/Buttons/buttons.dart';
import '../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../../Reuse_Widgets/ErrorsUi/not_available.dart';
import '../../../../Reuse_Widgets/circular_indicator_customized.dart';
import '../../RequestsPage/ShiftPages/ShiftListPages/UiWidgets/shift_detail_widget.dart';
import 'CommonWidgets/approval_list_widget.dart';
import 'CommonWidgets/call_bottom_sheet_for_remarks.dart';
import 'approval_acceptance_rejection_page.dart';

class ApprovalShiftDetailPage extends StatelessWidget {
  ApprovalShiftDetailPage({Key? key}) : super(key: key);

  ApprovalResultSetData? approvalResultSetData;
  @override
  Widget build(BuildContext context) {
    approvalResultSetData = ModalRoute.of(context)!.settings.arguments as ApprovalResultSetData;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<ApprovalsDetailCollector>(create: (_) => ApprovalsDetailCollector()),
          ChangeNotifierProvider<ApprovalsAcceptRejectCollector>(create: (_) => ApprovalsAcceptRejectCollector()),
          ChangeNotifierProvider<AcceptanceRejectionShiftApproval>(create: (_) => AcceptanceRejectionShiftApproval())
        ],
        builder: (context, snapshot) {
          return GetPageStarterScaffold(
            title: '${CallLanguageKeyWords.get(context, LanguageCodes.shift)}',
            body: BodyData(approvalResultSetData),

          );
        }
    );
  }
}
class BodyData extends StatefulWidget {
  final ApprovalResultSetData? approvalResultSetData;
  const BodyData(this.approvalResultSetData, {Key? key}) : super(key: key);

  @override
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApprovalsDetailCollector>(context,listen: false).approvalResultSet = widget.approvalResultSetData?.approvalResultSet;
      Provider.of<AcceptanceRejectionShiftApproval>(context,listen: false).start(context,widget.approvalResultSetData?.approvalResultSet);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AcceptanceRejectionShiftApproval>(
        builder: (context, data, child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly( 2), ScreenSize(context).widthOnly( 5.6), ScreenSize(context).heightOnly(4)),
                    child: ShiftDetailWidget(data: data.requestDetail),
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
                  ],
                  if(widget.approvalResultSetData?.show == true)...[
                    SizedBox(height: ScreenSize(context).heightOnly( 4),),
                    ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.announcementReject)}',buttonColor: MyColor.colorBlack,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: rejectPressed,),
                    SizedBox(height: ScreenSize(context).heightOnly( 2),),
                    ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.approvalBodyPanelButton2)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: approvePressed,),
                    SizedBox(height: ScreenSize(context).heightOnly( 6),),
                  ]
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
