import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/RequestSubListListeners/RequestSeparationListener/request_separation_list_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/Version1/models/RequestsModel/get_request_separation_list_model.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../../Version1/models/RequestsModel/request_data_taker.dart';
import '../../../../../../utils/Appbars/generic_app_bar.dart';
import '../../../../../../../../utils/Default_Screens/scafold_screens/default_screens.dart';
import '../../../../../../../utils/Reuse_LogicalWidgets/approve_reject_pending_text_widget.dart';
import 'package:peopleqlik_debug/utils/SkeletetonAnimation/skeleton_text.dart';
import '../../../GlobalEmployeeSearchUi/call_employee_search_ui.dart';

class RequestSeparationPage extends StatelessWidget {
  RequestSeparationPage({Key? key}) : super(key: key);
  RequestDataTaker? requestDataTaker;
  PanelController panelController = PanelController();
  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)!.settings.arguments as RequestDataTaker;
    return WillPopScope(
      onWillPop: ()async{
        //Provider.of<EmployeeSearchController>(context,listen: false).clearEmployeeData();
        return true;
      },
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider<GetSeparationRequestListListener>(create: (_) => GetSeparationRequestListListener()),
          ],
          builder: (context, snapshot) {
            return GetPageStarterScaffoldStateLess(
                body: BodyData(requestDataTaker),
                appBar: Consumer<GlobalSelectedEmployeeController>(
                    builder: (context, employeeData, child) {
                      return EmployeeAppBarWidget(
                        requestDataTaker?.title??'',
                        hidePlusButton: employeeData.apiStatus==ApiStatus.done?false:true,
                        selectEmployeeTap: () {
                          EmployeeSearchBottomSheet().show(
                              context,
                                  (employeeInfoMapper)
                              {
                                Provider.of<GetSeparationRequestListListener>(context,listen: false).start(context,ApiStatus.started);
                              }
                          );
                        },
                        removeEmployeeTap: () async {
                          await employeeData.resetEmployee();
                          Provider.of<GetSeparationRequestListListener>(context,listen: false).start(context,ApiStatus.started);
                        },
                        addFormClick: () {
                          Navigator.pushNamed(context, CurrentPage.RequestSeparationFormPage,arguments: requestDataTaker).then((value){
                            if(value!=null&&value is bool && value == true)
                            {
                              Provider.of<GetSeparationRequestListListener>(context,listen: false).start(context,ApiStatus.started);
                            }
                          });
                        },
                        employeeInfoMapper: employeeData.getEmployee(),
                      );
                    }
                ),
                checkEmployeeIfExistInCurrentCompany: Provider.of<GlobalSelectedEmployeeController>(context,listen: false).checkIfCurrentUserCompanyMatches(),
                employeeChangeCurrentCompanyTap: (){
                  EmployeeSearchBottomSheet().show(
                      context,
                          (employeeInfoMapper)
                      {
                        Provider.of<GetSeparationRequestListListener>(context,listen: false).start(context,ApiStatus.started);
                      }
                  );
                }
            );
          }
      ),
    );
  }
}
class BodyData extends StatefulWidget {
  final RequestDataTaker? requestDataTaker;
  const BodyData(this.requestDataTaker, {Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GlobalSelectedEmployeeController>(context,listen: false).resetEmployee();
      Provider.of<GetSeparationRequestListListener>(context,listen: false).start(context,ApiStatus.started);
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetSeparationRequestListListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done|| data.apiStatus == ApiStatus.pagination)
          {
            return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification){
                  GetSeparationRequestListListener getRequestListListener = Provider.of<GetSeparationRequestListListener>(context,listen: false);
                  // PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                  if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                  {
                    PrintLogs.printLogs('true');
                    getRequestListListener.updateStep(true, context);
                    return true;
                  }
                  else
                  {
                    getRequestListListener.updateStep(false, context);
                    return false;
                  }
                },
                child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 2),bottom: ScreenSize(context).heightOnly( 10)),
                    itemBuilder: (context,index){
                      return RequestSeparationListWidget(data.requestDataList![index],index,widget.requestDataTaker);
                    },
                    separatorBuilder: (context,index){return SizedBox(height: ScreenSize(context).heightOnly( 2),);},
                    itemCount: data.requestDataList?.length??0
                )
            );
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr28)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr29)}',topMargin: 8,width: 40,);
          }
          else if(data.apiStatus == ApiStatus.error)
          {
            return NotAvailable('404anim', '${CallLanguageKeyWords.get(context, LanguageCodes.Stringsstr9)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr15)}',topMargin: 8,width: 30);
          }
          else
          {
            return const CircularIndicatorCustomized();
          }
        }
    );
  }
}
class RequestSeparationListWidget extends StatelessWidget {
  final GetSeparationDataList? getSeparationDataList;
  final int? index;
  final RequestDataTaker? requestDataTaker;
  const RequestSeparationListWidget(this.getSeparationDataList,this.index, this.requestDataTaker, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<GetSeparationRequestListListener>(context,listen: false).reachedEnd&&index==Provider.of<GetSeparationRequestListListener>(context,listen: false).requestDataList!.length-1?
    Container(
      height: ScreenSize(context).heightOnly( 12),
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
              width: 1,
              color: const Color(MyColor.colorBackgroundDark)
          )
      ),
      child: SkeletonAnimation(
          key: Key('requestShimmer$index'),
          shimmerColor:Colors.white70,
          gradientColor:const Color(MyColor.colorGreyPrimary).withOpacity(0.2),
          curve:Curves.fastOutSlowIn, child: Container()),
    ):Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
              color: const Color(MyColor.colorBackgroundDark),
              width: 0.7
          )
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Material(
          color: const Color(MyColor.colorWhite),
          child: InkWell(
            splashColor: const Color(MyColor.colorGrey0),
            onTap: (){
              Navigator.pushNamed(context, CurrentPage.RequestSeparationDetailPage,arguments: AllRequestDetailMapper(documentNumber: getSeparationDataList?.documentNo.toString(),companyCode: getSeparationDataList?.companyCode.toString(),screenID: getSeparationDataList?.screenID.toString(),isApprovalScreen: false));

            },
            child: Padding(
                padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${CallLanguageKeyWords.get(context, LanguageCodes.separationJobCode)} ${getSeparationDataList?.jobCode?.toUpperCase()}',
                            style: GetFont.get(
                                context,
                                fontSize: 1.6,
                                fontWeight: FontWeight.w600,
                                color: MyColor.colorBlack
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenSize(context).widthOnly( 2),),
                        ApproveRejectPendingTextWidget(id: getSeparationDataList?.approvalStatusID??0,text: getSeparationDataList?.statusName??'',),

                      ],
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 0.3),),
                    if(getSeparationDataList?.remarks!=null)...
                    [
                      //SizedBox(height: ScreenSize(context).heightOnly( 1.2),),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                              text: '${CallLanguageKeyWords.get(context, LanguageCodes.approvalbodyPanelRemarks)}:  ',
                              style: GetFont.get(
                                  context,
                                  fontSize: 1.8,
                                  fontWeight: FontWeight.w600,
                                  color: MyColor.colorT6
                              ),
                              children: [
                                TextSpan(
                                  text: '${getSeparationDataList?.remarks}',
                                  style: GetFont.get(
                                      context,
                                      fontSize: 1.8,
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.colorBlack
                                  ),
                                )
                              ]
                          ),
                          maxLines: 3,
                        ),
                      ),
                    ],
                    SizedBox(height: ScreenSize(context).heightOnly( 1.2),),
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${GetDateFormats().getFilterDate(getSeparationDataList?.effectiveFrom)} - ${GetDateFormats().getFilterDate(getSeparationDataList?.newLastWorkingDate ?? getSeparationDataList?.lastWorkingDate)}',
                                  style: GetFont.get(
                                      context,
                                      fontSize: 1.4,
                                      fontWeight: FontWeight.w400,
                                      color: MyColor.colorGrey3
                                  ),
                                ),
                                if(getSeparationDataList?.newRemarks!=null)...
                                [
                                  SizedBox(height: ScreenSize(context).heightOnly( 1.2),),
                                  Flexible(
                                    child: RichText(
                                      text: TextSpan(
                                        text: '${CallLanguageKeyWords.get(context, LanguageCodes.separationLatestRemarks)}:  ',
                                        style: GetFont.get(
                                            context,
                                            fontSize: 1.4,
                                            fontWeight: FontWeight.w600,
                                            color: MyColor.colorT4
                                        ),
                                        children: [
                                          TextSpan(
                                            text: '${getSeparationDataList?.newRemarks}',
                                            style: GetFont.get(
                                                context,
                                                fontSize: 1.4,
                                                fontWeight: FontWeight.w400,
                                                color: MyColor.colorGrey3
                                            ),
                                          )
                                        ],
                                      ),
                                      maxLines: 3,
                                    ),
                                  ),
                                ]
                              ],
                            )
                        ),
                        if(getSeparationDataList?.approvalStatusID == 2)...[
                          ClipOval(
                            child: Material(
                                color: const Color(MyColor.colorWhite),
                                child: InkWell(
                                  splashColor: const Color(MyColor.colorGrey0),
                                  onTap: (){
                                    print('sbdaybs ${getSeparationDataList?.newLastWorkingDate} ${getSeparationDataList?.lastWorkingDate}');
                                    Navigator.pushNamed(context, CurrentPage.SeparationCalendarPage,arguments: RequestSeparationDetailData(getSeparationDataList?.iD,lastWorkingDate: getSeparationDataList?.newLastWorkingDate ?? getSeparationDataList?.lastWorkingDate,remarks: getSeparationDataList?.remarks)).then((value){
                                      // if(value!=null&&value is bool){
                                      //   print('aysahbsahjdbasbdajhsbdhjasdhasbjhdbajhsbdjhas');
                                      // }
                                      Provider.of<GetSeparationRequestListListener>(context,listen: false).start(context,ApiStatus.started);

                                    });

                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
                                    child: SvgPicture.string(
                                      SvgPicturesData.calendar,
                                      width: ScreenSize(context).heightOnly( 1.8),
                                      height: ScreenSize(context).heightOnly( 1.8),
                                      color: const Color(MyColor.colorBlack),
                                    ),
                                  ),
                                )
                            ),
                          )
                        ]
                      ],
                    ),
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }

}


