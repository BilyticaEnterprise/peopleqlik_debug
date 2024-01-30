import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_detail_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_separation_detail_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_rejection_page.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import '../../ApprovalsSubPages/ApprovalsAcceptance/CommonWidgets/approval_list_widget.dart';

class RequestSeparationDetailPage extends StatelessWidget {
  RequestSeparationDetailPage({Key? key}) : super(key: key);
  RequestSeparationDetailData? requestDetailData;
  @override
  Widget build(BuildContext context) {
    requestDetailData = ModalRoute.of(context)!.settings.arguments as RequestSeparationDetailData;
    return Scaffold(
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
                  title: AppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.requestsDetail)}')
              ),
            ];
          },
          body: Consumer<CheckInternetConnection>(
              builder: (context,data,child) {
                if(data.internetConnectionEnum == InternetConnectionEnum.available)
                {
                  return ChangeNotifierProvider<GetRequestSeparationDetailListener>(
                      create: (_) => GetRequestSeparationDetailListener(),
                      builder: (context, snapshot) {
                        return BodyData(requestDetailData);
                      }
                  );
                }
                else
                {
                  return NotAvailable(GetVariable.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
                }
              }
          ),
        )
    );
  }
}
class BodyData extends StatefulWidget {
  final RequestSeparationDetailData? requestDetailData;
  const BodyData(this.requestDetailData, {Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetRequestSeparationDetailListener>(context,listen: false).start(context, widget.requestDetailData?.id);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetRequestSeparationDetailListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return BodyDataNow(data.requestSeparationDetailResultSet,data);
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
  final RequestSeparationDetailResultSet? requestSeparationDetailResultSet;
  final GetRequestSeparationDetailListener data;
  const BodyDataNow(this.requestSeparationDetailResultSet, this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          if(requestSeparationDetailResultSet?.approvalHistory!=null&&requestSeparationDetailResultSet!.approvalHistory!.isNotEmpty&&data.approvalsList!=null&&data.approvalsList!.isNotEmpty)...
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
            SizedBox(height: ScreenSize(context).heightOnly( 10),),
          ],
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
}
class BodyWidget extends StatelessWidget {
  final String? header,body;
  const BodyWidget(this.header,this.body, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              header??'',
              style: GetFont.get(
                  context,
                  fontSize:1.8,
                  fontWeight: FontWeight.w600,
                  color: MyColor.colorBlack
              ),
            ),
            SizedBox(height: ScreenSize(context).widthOnly( 2),),
            Flexible(
              flex:0,
              child: Text(
                body??'',
                style: GetFont.get(
                    context,
                    fontSize:1.6,
                    fontWeight: FontWeight.w400,
                    color: MyColor.colorBlack
                ),
              ),
            ),
          ],

    );
  }
}

