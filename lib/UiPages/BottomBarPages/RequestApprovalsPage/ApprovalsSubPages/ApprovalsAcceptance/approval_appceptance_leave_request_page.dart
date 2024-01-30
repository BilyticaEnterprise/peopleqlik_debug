import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/ApiCalls/Urls/urls.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Approvals/approvals_accept_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestDetails/request_detail_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/get_approvals_list.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/AcceptancePanels/approval_body_panel.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/ApprovalsSubPages/ApprovalsAcceptance/AcceptancePanels/approval_header_panel.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/RequestsPage/RequestSubPages/request_list_sub_page.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/app_bar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Buttons/buttons.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';

import '../../../../Reuse_Widgets/BottomSheetUi/bottom_sheet_ui.dart';
import 'CommonWidgets/call_bottom_sheet_for_remarks.dart';


class ApprovalRequestFormPage extends StatelessWidget {
  ApprovalRequestDetailData? requestDetailData;
  ApprovalRequestFormPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    requestDetailData = ModalRoute.of(context)!.settings.arguments as ApprovalRequestDetailData;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ApprovalsDetailCollector>(create: (_) => ApprovalsDetailCollector()),
        ChangeNotifierProvider<ApprovalsAcceptRejectCollector>(create: (_) => ApprovalsAcceptRejectCollector())
      ],
      builder: (context, snapshot) {
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
                      return ChangeNotifierProvider<GetRequestDetailListener>(
                          create: (_) => GetRequestDetailListener(),
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
    );
  }
}
class BodyData extends StatefulWidget {
  final ApprovalRequestDetailData? requestDetailData;
  const BodyData(this.requestDetailData, {Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ApprovalsDetailCollector>(context,listen: false).approvalResultSet = widget.requestDetailData?.approvalResultSet;
      Provider.of<GetRequestDetailListener>(context,listen: false).start(context, widget.requestDetailData?.requestCode, widget.requestDetailData?.managerId);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetRequestDetailListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done)
          {
            return BodyDataNow(data,widget.requestDetailData);
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
  final GetRequestDetailListener data;
  final ApprovalRequestDetailData? requestDetailData;
  late BuildContext context;
  BodyDataNow(this.data, this.requestDetailData, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return SizedBox(
      height: ScreenSize(context).heightOnly( 100),
      child: SingleChildScrollView(
        child: Column(
          children: [
            if(data.requestNamesResultSet!=null&&data.requestNamesResultSet!.isNotEmpty&&data.requestNamesResultSet?[0].admRequestFile!=null&&data.requestNamesResultSet![0].admRequestFile!.isNotEmpty)...[
              SizedBox(
                height: ScreenSize(context).heightOnly( 24),
                child: Swiper(
                  itemHeight: ScreenSize(context).heightOnly( 10),
                  autoplay: true,
                  itemBuilder: (BuildContext context, int indexYe) {
                    //PrintLogs.print('${RequestType.requestUrl}${data.requestNamesResultSet?[0].admRequestFile?[indexYe].fileName}');
                    return CachedNetworkImage(
                        imageUrl: '${RequestType.requestUrl}${data.requestNamesResultSet?[0].admRequestFile?[indexYe].fileName}',
                        imageBuilder: (context, imageProvider) => Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: const Color(MyColor.colorWhite),
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color(MyColor.colorWhite),
                            borderRadius: BorderRadius.all(Radius.circular(15)),

                          ),
                          child: const ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(15)),
                              child: Center(child: CircularProgressIndicator())
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Color(MyColor.colorGrey0),
                              borderRadius: BorderRadius.all(Radius.circular(15)),

                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(15)),
                              child: Image.asset('assets/logo.png',fit: BoxFit.fitWidth,
                              ),
                            )
                        )
                    );
                  },
                  onTap: (pos){
                    Navigator.pushNamed(context, CurrentPage.ProductImageZoom,arguments: '${RequestType.requestUrl}${data.requestNamesResultSet?[0].admRequestFile?[pos].fileName}');
                  },
                  itemCount: data.requestNamesResultSet?[0].admRequestFile?.length??0,
                  viewportFraction: 0.75,
                  scale: 0.85,
                ),
              ),
              SizedBox(height: ScreenSize(context).heightOnly( 2),)
            ],
            ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: ScreenSize(context).heightOnly( 2)),
                itemBuilder: (context,index){
                 // PrintLogs.printLogs('saasasas ${data.requestNamesResultSet?[0].admRequestValue?[index].controlValue}');
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                            color: const Color(MyColor.colorGrey7),
                            width: 0.7
                        )
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
                      child:
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              data.requestNamesResultSet?[0].admRequestValue?[index].admRequestManagerDt?.title??'${CallLanguageKeyWords.get(context, LanguageCodes.File)} ${index+1}',
                              style: GetFont.get(
                                  context,
                                  fontSize:1.8,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.colorBlack
                              ),
                              maxLines: 1,
                          ),
                          SizedBox(height: ScreenSize(context).widthOnly( 2),),
                          Flexible(
                            flex:0,
                            child: Text(
                              data.requestNamesResultSet?[0].admRequestValue?[index].controlValue??'',
                              style: GetFont.get(
                                  context,
                                  fontSize:1.8,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorBlack
                              ),
                              maxLines: 10,
                            ),
                          ),
                        ],
                      )
                    ),
                  );
                },
                separatorBuilder: (context,index){return SizedBox(height: ScreenSize(context).heightOnly( 2),);},
                itemCount: data.requestNamesResultSet?[0].admRequestValue?.length??0),
            if(requestDetailData?.show == true)...[
              SizedBox(height: ScreenSize(context).heightOnly( 4),),
              ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.announcementReject)}',buttonColor: MyColor.colorBlack,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: rejectPressed,),
              SizedBox(height: ScreenSize(context).heightOnly( 2),),
              ButtonWidget(text: '${CallLanguageKeyWords.get(context, LanguageCodes.approvalBodyPanelButton2)}',buttonColor: MyColor.colorPrimary,textSize: 2.2,textColor: MyColor.colorWhite,height: 6.5,width: ScreenSize(context).widthOnly( 90),paddingHorizontal: ScreenSize(context).heightOnly( 1.2),weight: FontWeight.w600,onPressed: approvePressed,),
              SizedBox(height: ScreenSize(context).heightOnly( 6),),
            ]
          ],
        ),
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
class ApprovalRequestDetailData
{
  dynamic requestCode;
  dynamic managerId;
  bool? show;
  ApprovalResultSet? approvalResultSet;
  ApprovalRequestDetailData(this.requestCode,this.managerId,this.show,this.approvalResultSet);
}

