import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeRegulationModels/time_regulation_approval_detail_model.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/BottomSheetUi/bottom_sheet_ui.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:provider/provider.dart';

import '../../../../../BusinessLogicModel/AppConstants/app_constants.dart';
import '../../../../../BusinessLogicModel/Enums/apistatus_enum.dart';
import '../../../../../BusinessLogicModel/Listeners/Approvals/approvals_accept_listener.dart';
import '../../../../../BusinessLogicModel/Listeners/Approvals/approvals_detail_collector.dart';
import '../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/TimeRegulationListener/approval_time_regulation_detail_listener.dart';
import '../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/TimeRegulationListener/time_regulation_detail_Listener.dart';
import '../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import '../../../../../BusinessLogicModel/Models/TimeRegulationModels/time_regulation_model.dart';
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
import '../../ApprovalsSubPages/ApprovalsAcceptance/CommonWidgets/approval_list_widget.dart';
import '../../RequestsPage/SeperationRequestPages/request_separation_detail_page.dart';

class TimeRegulationDetailPage extends StatelessWidget {
  TimeRegulationDetailPage({Key? key}) : super(key: key);
  RequestDataTaker? requestDataTaker;
  // TimeRegulationDataList? timeRegulationDataList;

  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)!.settings.arguments as RequestDataTaker;
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<TimeRegulationDetailListener>(create: (_) => TimeRegulationDetailListener(requestDataTaker?.extraData))
        ],
        builder: (context, snapshot) {
          return GetPageStarterScaffold(
            title: requestDataTaker?.title??'',
            body: BodyData(),
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
      Provider.of<TimeRegulationDetailListener>(context,listen: false).start(context);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<TimeRegulationDetailListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return BodyDataNow();
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

  BodyDataNow({Key? key}) : super(key: key);

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    TimeRegulationDetailListener data = Provider.of<TimeRegulationDetailListener>(context,listen: false);
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
                  color: const Color(MyColor.colorGrey7),
                  width: 1,
                )
            ),
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.6)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail1)??'',GetDateFormats().getFilterDate(data.timeRegulationLeaveDetail?[0].reqDate)),
                  SizedBox(height: ScreenSize(context).heightOnly( 2),),
                  BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.timeRegulationDetail2)??'',data.timeRegulationLeaveDetail?[0].statusName),
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

          SizedBox(height: ScreenSize(context).heightOnly( 10),),
        ],
      ),
    );
  }

}
