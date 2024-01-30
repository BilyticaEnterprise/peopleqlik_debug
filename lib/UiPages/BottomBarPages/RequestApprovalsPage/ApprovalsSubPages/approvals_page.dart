import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Approvals/approvals_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_approvals_list.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalThreePages/approved_approvals.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalThreePages/pending_approvals.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalThreePages/rejected_approvals.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/panel_body_approvals.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/panel_header_approval.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/TimeOffPage/TimeOffSubPages/time_off_header_tabs.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/approvals_appbar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ApprovalPage extends StatelessWidget {
  const ApprovalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
      providers: [
        ChangeNotifierProvider<ApprovalCollector>(create: (_) => ApprovalCollector()),
      ],
        child: StartPage());
  }
}
class StartPage extends StatelessWidget {
  StartPage({Key? key}) : super(key: key);
  PanelController panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    Provider.of<ApprovalCollector>(context,listen: false).panelController = panelController;
    return WillPopScope(
      onWillPop: ()async{
        Provider.of<ApprovalCollector>(context,listen: false).startDate = null;
        Provider.of<ApprovalCollector>(context,listen: false).endDate = null;
        Provider.of<ApprovalCollector>(context,listen: false).approvalPageEnum = ApprovalPageEnum.pending;
        return true;
      },
      child: Scaffold(
        backgroundColor: const Color(MyColor.colorWhite),
          body: SlidingUpPanel(
            maxHeight: ScreenSize(context).heightOnly(90),
            minHeight: 0,
            isDraggable: true,
            panelSnapping: true,
            defaultPanelState: PanelState.CLOSED,
            controller: Provider.of<ApprovalCollector>(context,listen: false).panelController,
            parallaxEnabled: true,
            backdropEnabled: true,
            backdropColor: const Color(MyColor.colorGreySecondary),
            header: ApprovalsPanelHeader(),
            parallaxOffset: .5,
            panelBuilder: (sc) => ApprovalsPanelBody(sc),
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
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
                      title: ApprovalsAppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr41)}')
                  ),
                ];
              },
              body: Consumer<CheckInternetConnection>(
                  builder: (context,data,child) {
                    if(data.internetConnectionEnum == InternetConnectionEnum.available)
                    {
                      return const BodyData();
                    }
                    else
                    {
                      return NotAvailable(GetVariable.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
                    }
                  }
              ),
            ),
          )
      ),
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
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: ScreenSize(context).heightOnly( 0.2),),
        HeaderWidget(),
        SizedBox(height: ScreenSize(context).heightOnly( 2),),
        const Expanded(child: ListWidget())
      ],
    );
  }
}
class HeaderWidget extends StatelessWidget {
  late BuildContext mContext;
  HeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    mContext = context;
    return Container(
      height: ScreenSize(context).heightOnly( 6.5),
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      width: double.maxFinite,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(MyColor.colorGrey6)
      ),
      child: Consumer<ApprovalCollector>(
          builder: (context, data, child) {
            return Row(
              children: [
                Expanded(
                    child: TimeOffHeader(data.approvalPageEnum == ApprovalPageEnum.pending?true:false,'${CallLanguageKeyWords.get(context, LanguageCodes.pending)}',pendingClick)
                ),
                Expanded(
                    child: TimeOffHeader(data.approvalPageEnum == ApprovalPageEnum.approve?true:false,'${CallLanguageKeyWords.get(context, LanguageCodes.approved)}',approveClick)
                ),
                Expanded(
                    child: TimeOffHeader(data.approvalPageEnum == ApprovalPageEnum.rejected?true:false,'${CallLanguageKeyWords.get(context, LanguageCodes.rejected)}',rejectClick)
                )
              ],
            );
          }
      ),
    );
  }

  void pendingClick()
  {
    ApprovalCollector approvalCollector = Provider.of<ApprovalCollector>(mContext,listen: false);
    if(approvalCollector.checkIfApiHitsAlready()==true)
      {
        print('clickedpend');
        approvalCollector.pendingButton = true;
        approvalCollector.updatePage(mContext,ApprovalPageEnum.pending,ApiStatus.started);
      }
  }

  void approveClick()
  {
    ApprovalCollector approvalCollector = Provider.of<ApprovalCollector>(mContext,listen: false);
    if(approvalCollector.checkIfApiHitsAlready()==true)
    {
      print('appclickedpend');
      approvalCollector.approveButton = true;
      approvalCollector.updatePage(mContext,ApprovalPageEnum.approve,ApiStatus.started);

    }
  }

  void rejectClick()
  {
    ApprovalCollector approvalCollector = Provider.of<ApprovalCollector>(mContext,listen: false);
    if(approvalCollector.checkIfApiHitsAlready()==true)
    {
      print('reclickedpend');
      approvalCollector.rejectionButton = true;
      approvalCollector.updatePage(mContext,ApprovalPageEnum.rejected,ApiStatus.started);

    }
  }
}
class ListWidget extends StatefulWidget {
  const ListWidget({Key? key}) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApprovalCollector>(context,listen: false).updatePage(context,ApprovalPageEnum.pending,ApiStatus.started);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ApprovalCollector>(
        builder: (context,data,child) {
          if(data.approvalPageEnum == ApprovalPageEnum.pending) {
            if(data.apiStatus == ApiStatus.done||data.apiStatus == ApiStatus.pagination)
              {
                return NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification){
                      ApprovalCollector approvalCollector = Provider.of<ApprovalCollector>(context,listen: false);
                      // PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                      if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                      {
                       // PrintLogs.printLogs('true');
                        approvalCollector.updateStep(true, context);
                        return true;
                      }
                      else
                      {
                        approvalCollector.updateStep(false, context);
                        return false;
                      }
                    },
                    child: PendingApprovals(data.approvalPageEnum,data.dataList?.cast<ApprovalResultSet>(),key: const Key('Pending'),)
                );
              }
            else if(data.apiStatus == ApiStatus.empty)
            {
              return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr30)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr31)}',topMargin: 8,width: 40,key: const Key('PendingNoWay'),);
            }
            else if(data.apiStatus == ApiStatus.error)
            {
              return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30,key: const Key('PendingNti'),);
            }
            else
            {
              return const CircularIndicatorCustomized();
            }
          }
          else if(data.approvalPageEnum == ApprovalPageEnum.rejected)
            {
              if(data.apiStatus == ApiStatus.done||data.apiStatus == ApiStatus.pagination)
              {
                return NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification){
                      ApprovalCollector approvalCollector = Provider.of<ApprovalCollector>(context,listen: false);
                      // PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                      if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                      {
                        // PrintLogs.print('true');
                        approvalCollector.updateStep(true, context);
                        return true;
                      }
                      else
                      {
                        approvalCollector.updateStep(false, context);
                        return false;
                      }
                    },
                    child: RejectedApprovals(data.approvalPageEnum,data.dataList?.cast<ApprovalResultSet>(),key: const Key('Reject'),));
              }
              else if(data.apiStatus == ApiStatus.empty)
              {
                return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr30)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr31)}',topMargin: 8,width: 40,key: const Key('RejectNot'),);
              }
              else if(data.apiStatus == ApiStatus.error)
              {
                return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30,key: const Key('RejectNtoA'),);
              }
              else
              {
                return const CircularIndicatorCustomized();
              }
            }
          else if(data.approvalPageEnum == ApprovalPageEnum.approve)
          {
            if(data.apiStatus == ApiStatus.done||data.apiStatus == ApiStatus.pagination)
            {
              return NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification){
                    ApprovalCollector approvalCollector = Provider.of<ApprovalCollector>(context,listen: false);
                    // PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                    if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                    {
                      // PrintLogs.print('true');
                      approvalCollector.updateStep(true, context);
                      return true;
                    }
                    else
                    {
                      approvalCollector.updateStep(false, context);
                      return false;
                    }
                  },
                  child: ApprovedApprovals(data.approvalPageEnum,data.dataList?.cast<ApprovalResultSet>(),key: const Key('Approval'),)
              );
            }
            else if(data.apiStatus == ApiStatus.empty)
            {
              return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr30)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr31)}',topMargin: 8,width: 40,key: const Key('ApproveNOt'),);
            }
            else if(data.apiStatus == ApiStatus.error)
            {
              return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30,key: const Key('ApproveNti'),);
            }
            else
            {
              return const CircularIndicatorCustomized();
            }
          }
          else
            {
              return const CircularIndicatorCustomized();
            }
        }
    );
  }
}

