import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Approvals/approvals_accept_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_detail_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_separation_detail_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/AcceptancePanels/approval_body_panel.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/AcceptancePanels/approval_header_panel.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_rejection_page.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/SeperationRequestPages/request_separation_detail_page.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Buttons/buttons.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/hide_keyboard.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import '../../../../Reuse_Widgets/BottomSheetUi/bottom_sheet_ui.dart';
import 'CommonWidgets/approval_list_widget.dart';
import 'CommonWidgets/call_bottom_sheet_for_remarks.dart';

class ApprovalAcceptanceRejectionSeparationPage extends StatefulWidget {
  ApprovalAcceptanceRejectionSeparationPage({Key? key}) : super(key: key);

  @override
  State<ApprovalAcceptanceRejectionSeparationPage> createState() => _ApprovalAcceptanceRejectionSeparationPageState();
}

class _ApprovalAcceptanceRejectionSeparationPageState extends State<ApprovalAcceptanceRejectionSeparationPage> {
  ApprovalResultSetData? approvalResultSetData;


  @override
  Widget build(BuildContext context) {
    approvalResultSetData = ModalRoute.of(context)!.settings.arguments as ApprovalResultSetData;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApprovalsDetailCollector>(create: (_) => ApprovalsDetailCollector()),
        ChangeNotifierProvider<ApprovalsAcceptRejectCollector>(create: (_) => ApprovalsAcceptRejectCollector()),
        ChangeNotifierProvider<GetRequestSeparationDetailListener>(create: (_) => GetRequestSeparationDetailListener(),)
      ],
      child: GestureDetector(
        onTap: (){HideShowKeyboard.hide(context);},
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
                      title: AppBarWidget("${CallLanguageKeyWords.get(context, LanguageCodes.announcementAppBar)}")
                  ),
                ];
              },
              body: Consumer<CheckInternetConnection>(
                  builder: (context,data,child) {
                    if(data.internetConnectionEnum == InternetConnectionEnum.available)
                    {
                      return BodyData(approvalResultSetData);
                    }
                    else
                    {
                      return NotAvailable(GetVariable.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
                    }
                  }
              ),
            )
        ),
      ),
    );
  }
}
class BodyData extends StatefulWidget {
  final ApprovalResultSetData? approvalResultSetData;
  const BodyData(this.approvalResultSetData, {Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApprovalsDetailCollector>(context,listen: false).approvalResultSet = widget.approvalResultSetData?.approvalResultSet;
      Provider.of<GetRequestSeparationDetailListener>(context,listen: false).start(context, widget.approvalResultSetData?.approvalResultSet?.documentNo);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetRequestSeparationDetailListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return BodyDataNow(data.requestSeparationDetailResultSet,widget.approvalResultSetData);
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableH)}', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableA)}',topMargin: 8,width: 30);
          }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableH)}', '${CallLanguageKeyWords.get(context, LanguageCodes.RequestDetailNoAvailableA)}',topMargin: 8,width: 30);
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
  RequestSeparationDetailResultSet? requestSeparationDetailResultSet;
  ApprovalResultSetData? approvalResultSetData;
  BodyDataNow(this.requestSeparationDetailResultSet, this.approvalResultSetData, {Key? key}) : super(key: key);
  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    GetRequestSeparationDetailListener getRequestSeparationDetailListener = Provider.of<GetRequestSeparationDetailListener>(context,listen: false);
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: const Color(MyColor.colorGrey7),
                  width: 1,
                )
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                        text: '${CallLanguageKeyWords.get(context, LanguageCodes.requestCompany)!.toUpperCase()} ',
                        style: GetFont.get(
                            context,
                            fontSize:2.0,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorGrey3
                        ),
                        children: [
                          TextSpan(
                            text: requestSeparationDetailResultSet?.reuestDetail?.displayName??'',
                            style: GetFont.get(
                                context,
                                fontSize:2.0,
                                fontWeight: FontWeight.w600,
                                color: MyColor.colorBlack
                            ),
                          )
                        ]
                    ),
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.separationEmployee)??'',requestSeparationDetailResultSet?.reuestDetail?.employeeName),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.separationJobTitle)??'',requestSeparationDetailResultSet?.reuestDetail?.jobTitle),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.separationEffectiveDate)??'',GetDateFormats().getFilterDate(requestSeparationDetailResultSet?.reuestDetail?.effectiveFrom)),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.separationLastWorkingDate)??'',GetDateFormats().getFilterDate(requestSeparationDetailResultSet?.reuestDetail?.lastWorkingDate)),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.separationJustification)??'',requestSeparationDetailResultSet?.reuestDetail?.remarks),
                ],
              ),
            ),
          ),
          SizedBox(height: ScreenSize(context).heightOnly( 1),),
          if(requestSeparationDetailResultSet?.approvalHistory!=null&&requestSeparationDetailResultSet!.approvalHistory!.isNotEmpty&&getRequestSeparationDetailListener.approvalsList!=null&&getRequestSeparationDetailListener.approvalsList!.isNotEmpty)...
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
                child: ApprovalListWidget(getRequestSeparationDetailListener.approvalsList)

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
  int? getColorOfLeaveStatusText(int? timeOffType)
  {
    switch(timeOffType)
    {
      case 1:
        return MyColor.colorT2;
      case 3:
        return MyColor.colorT6;
      case 2:
        return MyColor.colorT4;
      case 8:
        return MyColor.colorT6;
      default:
        return MyColor.colorT6;
    }
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
