import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestLeaveEncashmentListeners/request_encashment_detail_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_request_encashment_detail_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_rejection_page.dart' as approval_page;
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/approval_acceptance_rejection_page.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/SeperationRequestPages/request_separation_detail_page.dart';
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

class RequestEncashmentDetailPage extends StatelessWidget {
  RequestEncashmentDetailPage({Key? key}) : super(key: key);
  RequestEncashmentDetailData? requestDetailData;
  @override
  Widget build(BuildContext context) {
    requestDetailData = ModalRoute.of(context)!.settings.arguments as RequestEncashmentDetailData;
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
                  return ChangeNotifierProvider<GetRequestEncashmentDetailListener>(
                      create: (_) => GetRequestEncashmentDetailListener(),
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
  final RequestEncashmentDetailData? requestDetailData;
  const BodyData(this.requestDetailData, {Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetRequestEncashmentDetailListener>(context,listen: false).start(context, widget.requestDetailData?.id);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetRequestEncashmentDetailListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return BodyDataNow(data.encashmentDetailResultSet,data);
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
  final EncashmentDetailResultSet? encashmentDetailResultSet;
  final GetRequestEncashmentDetailListener data;
  const BodyDataNow(this.encashmentDetailResultSet, this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                        BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.requestsSubListPage)??'',encashmentDetailResultSet?.reuestDetail?[0].requestCode),
                        SizedBox(height: ScreenSize(context).heightOnly( 2),),
                        BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.LeaveType)??'',encashmentDetailResultSet?.reuestDetail?[0].leaveType),
                        SizedBox(height: ScreenSize(context).heightOnly( 2),),
                        BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.RequestDateIs)??'','${GetDateFormats().getFilterDate(encashmentDetailResultSet?.reuestDetail?[0].createdDate)}'),
                        SizedBox(height: ScreenSize(context).heightOnly( 2),),
                        BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.BalanceUnit)??'','${encashmentDetailResultSet?.reuestDetail?[0].balanceUnit}'),
                        SizedBox(height: ScreenSize(context).heightOnly( 2),),
                        BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.MaxEncashmentUnit)??'','${encashmentDetailResultSet?.reuestDetail?[0].maxEncashmentUnit}'),
                        SizedBox(height: ScreenSize(context).heightOnly( 2),),
                        BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.EncashmentType)??'',getEncahsmentType(encashmentDetailResultSet?.reuestDetail?[0].arPaymentType?.typeID??0)),
                        SizedBox(height: ScreenSize(context).heightOnly( 2),),
                        BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.encashmentUnit)??'','${encashmentDetailResultSet?.reuestDetail?[0].encashmentUnit}'),
                        SizedBox(height: ScreenSize(context).heightOnly( 2),),
                        BodyWidget(CallLanguageKeyWords.get(context, LanguageCodes.paymentTypeId)??'','${encashmentDetailResultSet?.reuestDetail?[0].arPaymentType?.typeName}'),
                      ]
                  )
              )
          ),
          SizedBox(height: ScreenSize(context).heightOnly( 1),),
          if(encashmentDetailResultSet?.approvalHistory!=null&&encashmentDetailResultSet!.approvalHistory!.isNotEmpty&&data.approvalsList!=null&&data.approvalsList!.isNotEmpty)...
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
        ],
    );
  }
  int? getColorOfLeaveStatusType(int? timeOffType)
  {
    switch(timeOffType)
    {
      case 1:
        return MyColor.colorT1;
      case 3:
        return MyColor.colorT5;
      case 2:
        return MyColor.colorT3;
      case 8:
        return MyColor.colorT5;
      default:
        return MyColor.colorPurpleLight;
    }
  }
  String getEncahsmentType(int typeID)
  {
    switch(typeID)
    {
      case 1:
        return 'Fully';
      case 2:
        return 'Partially';
      default:
        return 'Unknown Type';
    }
  }
}
