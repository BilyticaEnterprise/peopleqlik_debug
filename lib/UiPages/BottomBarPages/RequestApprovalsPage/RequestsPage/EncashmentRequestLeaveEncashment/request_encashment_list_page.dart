import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Enums/apistatus_enum.dart';

import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestLeaveEncashmentListeners/request_encashment_detail_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/RequestLeaveEncashmentListeners/request_encashment_list_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Requests/RequestSubListListeners/request_list_listener.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/PaysSlipApprovalsRequest/RequestsModel/get_request_encashment_list_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/internet_connection.dart';
import 'package:peopleqlik_debug/UiPages/BottomBarPages/RequestApprovalsPage/SearchEmployeePanelPages/panel_header.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/Appbars/request_others_add_appbar.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/UiPages/Reuse_Widgets/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';
import 'package:peopleqlik_debug/src/pages_name.dart';
import 'package:peopleqlik_debug/src/prints_logs.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:peopleqlik_debug/src/strings.dart';
import 'package:provider/provider.dart';
import '../../../../Reuse_Widgets/SkeletetonAnimation/skeleton_text.dart';

import '../../../../../BusinessLogicModel/Listeners/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../Reuse_LogicalWidgets/approve_reject_pending_text_widget.dart';
import '../../../../Reuse_Widgets/Appbars/generic_app_bar.dart';
import '../../../../Reuse_Widgets/Default_Screens/default_screens.dart';
import '../../../GlobalEmployeeSearchUi/call_employee_search_ui.dart';


class RequestEncashmentListPage extends StatelessWidget {
  RequestEncashmentListPage({Key? key}) : super(key: key);
  late RequestDataTaker? requestDataTaker;
  @override
  Widget build(BuildContext context) {
    requestDataTaker = ModalRoute.of(context)?.settings.arguments as RequestDataTaker;
    return WillPopScope(
      onWillPop: ()async{
        //Provider.of<EmployeeSearchController>(context,listen: false).clearEmployeeData();
        return true;
      },
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider<GetEncashmentRequestListListener>(create: (_) => GetEncashmentRequestListListener()),
          ],
          builder: (context, snapshot) {
            return GetPageStarterScaffold(
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
                                Provider.of<GetEncashmentRequestListListener>(context,listen: false).start(context,ApiStatus.started);
                              }
                          );
                        },
                        removeEmployeeTap: () async {
                          await employeeData.resetEmployee();
                          Provider.of<GetEncashmentRequestListListener>(context,listen: false).start(context,ApiStatus.started);
                        },
                        addFormClick: () {
                          Navigator.pushNamed(context, CurrentPage.RequestSpecialFormPage,arguments: requestDataTaker).then((value){
                            if(value!=null&&value is bool && value == true)
                            {
                              Provider.of<GetEncashmentRequestListListener>(context,listen: false).start(context,ApiStatus.started);
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
                        Provider.of<GetEncashmentRequestListListener>(context,listen: false).start(context,ApiStatus.started);
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
  State<BodyData> createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GlobalSelectedEmployeeController>(context,listen: false).resetEmployee();
      Provider.of<GetEncashmentRequestListListener>(context,listen: false).start(context,ApiStatus.started);
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetEncashmentRequestListListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done|| data.apiStatus == ApiStatus.pagination)
          {
            return NotificationListener<ScrollNotification>(
                onNotification: (scrollNotification){
                  GetEncashmentRequestListListener getRequestListListener = Provider.of<GetEncashmentRequestListListener>(context,listen: false);
                  // PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                  if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                  {
                    //PrintLogs.printLogs('true');
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
                      return RequestListWidget(data.requestDataList![index],index,widget.requestDataTaker);
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
class RequestListWidget extends StatelessWidget {
  final int? index;
  final RequestSpecialDataList? requestListDataList;
  final RequestDataTaker? requestDataTaker;
  const RequestListWidget(this.requestListDataList,this.index, this.requestDataTaker,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
    return Provider.of<GetEncashmentRequestListListener>(context,listen: false).reachedEnd&&index==Provider.of<GetEncashmentRequestListListener>(context,listen: false).requestDataList!.length-1?
    Container(
      height: ScreenSize(context).heightOnly(12),
      width: double.maxFinite,
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
              width: 1,
              color: const Color(MyColor.colorGrey7)
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
              color: const Color(MyColor.colorGrey7),
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
              Navigator.pushNamed(context, CurrentPage.RequestEncashmentDetailPage,arguments: RequestEncashmentDetailData(requestListDataList?.requestCode));
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
                            '${CallLanguageKeyWords.get(context, LanguageCodes.requestsSubListPage)} ${requestListDataList?.requestCode}',
                            style: GetFont.get(
                                context,
                                fontSize: 1.6,
                                fontWeight: FontWeight.w400,
                                color: MyColor.colorGrey3
                            ),
                          ),
                        ),
                        SizedBox(width: ScreenSize(context).widthOnly( 2),),
                        ApproveRejectPendingTextWidget(id: requestListDataList?.approvalStatusID??0,text: requestListDataList?.statusName??'',),
                      ],
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 0.3),),
                    Flexible(
                      child: Text(
                        '${requestListDataList?.leaveTypeTitle}, ${requestListDataList?.paymentTypeName}',
                        style: GetFont.get(
                            context,
                            fontSize: 1.8,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorBlack
                        ),
                      ),
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 1.2),),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            '${GetDateFormats().getFilterDate(requestListDataList?.modifiedDate)}',
                            style: GetFont.get(
                                context,
                                fontSize: 1.4,
                                fontWeight: FontWeight.w400,
                                color: MyColor.colorGrey3
                            ),
                          ),
                        ),
                        Icon(
                          changeLanguage.languageEnum == LanguageEnum.arabic?Icons.arrow_back_ios:Icons.arrow_forward_ios,
                          size: ScreenSize(context).heightOnly( 1.8),
                          color: const Color(MyColor.colorBlack),
                        )
                      ],
                    )
                  ],
                )
            ),
          ),
        ),
      ),
    );
  }
// int? getColorOfLeaveStatusType(int? timeOffType)
// {
//   switch(timeOffType)
//   {
//     case 1:
//       return MyColor.colorT1;
//     case 3:
//       return MyColor.colorT5;
//     case 2:
//       return MyColor.colorT3;
//     case 8:
//       return MyColor.colorT5;
//     default:
//       return MyColor.colorPurpleLight;
//   }
// }
// int? getColorOfLeaveStatusText(int? timeOffType)
// {
//   switch(timeOffType)
//   {
//     case 1:
//       return MyColor.colorT2;
//     case 3:
//       return MyColor.colorT6;
//     case 2:
//       return MyColor.colorT4;
//     case 8:
//       return MyColor.colorT6;
//     default:
//       return MyColor.colorT6;
//   }
// }
}