import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/utils/Enums/request_enums.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Requests/request_name_listener.dart';
import 'package:peopleqlik_debug/Version1/Models/RequestsModel/get_request_name_model.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';

import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/utils/ScreenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/mainCommon.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import 'package:peopleqlik_debug/utils/AppConstants/app_constants.dart';
import '../../../../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../../../../Version1/Models/RequestsModel/request_data_taker.dart';
import '../../../../../configs/get_assets.dart';
import '../../../../../utils/Appbars/app_bar.dart';

class RequestPage extends StatelessWidget {
  const RequestPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: ()async{
        Provider.of<GlobalSelectedEmployeeController>(GetNavigatorStateContext.navigatorKey.currentState!.context,listen: false).resetEmployee();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color(MyColor.colorWhite),
            toolbarHeight: 0,
          ),
          backgroundColor: const Color(MyColor.colorWhite),
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                    automaticallyImplyLeading: false,
                    pinned: false,
                    floating: true,
                  // systemOverlayStyle: SystemUiOverlayStyle(
                  //   statusBarColor: Colors.green, // <-- SEE HERE
                  //   statusBarIconBrightness: Brightness.dark, //<-- For Android SEE HERE (dark icons)
                  //   statusBarBrightness: Brightness.light, //<-- For iOS SEE HERE (dark icons)
                  // ),
                    backgroundColor: const Color(MyColor.colorWhite),
                    snap: true,
                    elevation: 0,
                    titleSpacing: 0,
                    title: AppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.requestsheader)}'),
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
                  return NotAvailable(GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
                }
              }
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
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetRequestNameListener>(context,listen: false).start(context);
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetRequestNameListener>(
      builder: (context,data,child) {
        if(data.apiStatus == ApiStatus.done)
          {
            return ListView.separated(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 2),bottom: ScreenSize(context).heightOnly( 10)),
                itemBuilder: (context,index){

                  // if(index == 0)
                  // {
                  //   return TimeOffWidget(index,key: const Key('TimeOffWidget'),);
                  // }
                  // else {
                    return RequestListWidget(data.requestNamesResultSet![index],index);
                  //}
                },
                separatorBuilder: (context,index){return SizedBox(height: ScreenSize(context).heightOnly(2),);},
                itemCount: (data.requestNamesResultSet?.length??0)
                // itemCount: (data.requestNamesResultSet?.length??0)+1
        );
          }
        else if(data.apiStatus == ApiStatus.empty)
        {
          return ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 2),bottom: ScreenSize(context).heightOnly( 10)),
              itemBuilder: (context,index){
                return TimeOffWidget(index,key: const Key('TimeOffWidget'),);
              },
              separatorBuilder: (context,index){return SizedBox(height: ScreenSize(context).heightOnly( 2),);},
              itemCount: 1);
          //return NotAvailable('not_available', '${CallSettingsKeyWords.get(context, LanguageCodes.stringsstr28)}', '${CallSettingsKeyWords.get(context, LanguageCodes.stringsstr29)}',topMargin: 8,width: 40,);
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
  final RequestNamesResultSet? requestNamesResultSet;
  const RequestListWidget(this.requestNamesResultSet,this.index,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              PrintLogs.printLogs('KJABSJDS ${requestNamesResultSet?.screenID}');
              if(requestNamesResultSet?.managerID == 0 && requestNamesResultSet?.screenID == AppConstants.requestEnCashmentScreenID)
                {
                  Navigator.pushNamed(context, CurrentPage.RequestEncashmentListPage, arguments: RequestDataTaker(requestNamesResultSet!.requestTitle!,id: requestNamesResultSet!.managerID!,requestsEnum: RequestsEnum.encashment));
                }
              else if(requestNamesResultSet?.managerID == 0 && requestNamesResultSet?.screenID == AppConstants.requestSeparationScreenID)
              {
                Navigator.pushNamed(context, CurrentPage.RequestSeperationPage, arguments: RequestDataTaker(requestNamesResultSet!.requestTitle!,id: requestNamesResultSet!.managerID!,requestsEnum: RequestsEnum.speration));
              }
              else if(requestNamesResultSet?.managerID == AppConstants.managerTimeRegulationMiscTransaction && requestNamesResultSet?.screenID == AppConstants.requestTimeRegulationScreenID)
              {
                Navigator.pushNamed(context, CurrentPage.TimeRegulationListPage, arguments: RequestDataTaker(requestNamesResultSet!.requestTitle!,id: requestNamesResultSet!.managerID!,requestsEnum: RequestsEnum.timeRegulationMisc));
              }
              else if(requestNamesResultSet?.managerID == AppConstants.managerTimeRegulationOfficePermission && requestNamesResultSet?.screenID == AppConstants.requestTimeRegulationScreenID)
              {
                Navigator.pushNamed(context, CurrentPage.TimeRegulationListPage, arguments: RequestDataTaker(requestNamesResultSet!.requestTitle!,id: requestNamesResultSet!.managerID!,requestsEnum: RequestsEnum.timeRegulationMovementSlip));
              }
              else if(requestNamesResultSet?.managerID == 0 && requestNamesResultSet?.screenID == AppConstants.requestOverTimeScreenID)
              {
                Navigator.pushNamed(context, CurrentPage.OverTimeListPage, arguments: RequestDataTaker(requestNamesResultSet!.requestTitle!,id: requestNamesResultSet!.managerID!, requestsEnum: RequestsEnum.timeRegulationMovementSlip));
              }
              else if(requestNamesResultSet?.managerID == 0 && requestNamesResultSet?.screenID == AppConstants.requestShiftScreenID)
              {
                Navigator.pushNamed(context, CurrentPage.ShiftListPage, arguments: RequestDataTaker(requestNamesResultSet!.requestTitle!,id: requestNamesResultSet!.managerID!,requestsEnum: RequestsEnum.timeRegulationMovementSlip));
              }
              else if(requestNamesResultSet?.screenID == AppConstants.requestPerformanceScreenID)
              {
                Navigator.pushNamed(context, CurrentPage.PerformancePage, arguments: RequestDataTaker(requestNamesResultSet!.requestTitle!,id: requestNamesResultSet!.managerID!,requestsEnum: RequestsEnum.performance,extraData: Provider.of<GetRequestNameListener>(context,listen: false).createUrl(context,requestNamesResultSet?.extraData)));
              }
              else if(requestNamesResultSet?.screenID == GetVariable.leaveScreenId)
              {
                Navigator.pushNamed(context, CurrentPage.TimeOffPage);
              }
              else {
                Navigator.pushNamed(context, CurrentPage.RequestListSubPage, arguments: RequestDataTaker(requestNamesResultSet!.requestTitle!,id: requestNamesResultSet!.managerID!,requestsEnum: RequestsEnum.generalRequest));
              }
            },
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
              child: Row(
                children: [
                  CachedNetworkImage(
                      imageUrl: '${RequestType.profileUrl}${requestNamesResultSet?.fileName}',
                      imageBuilder: (context, imageProvider) => Container(
                        width:ScreenSize(context).heightOnly(4.4),
                        height: ScreenSize(context).heightOnly(4.4),
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(MyColor.colorWhite),
                          border: Border.all(
                              color: const Color(MyColor.colorT5),
                              width: 1.0
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        width:ScreenSize(context).heightOnly(4.4),
                        height: ScreenSize(context).heightOnly(4.4),
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(MyColor.colorWhite),
                            border: Border.all(
                                color: const Color(MyColor.colorT5),
                                width: 1.0
                            )

                        ),
                        child: const ClipOval(
                            child: Center(child: CircularProgressIndicator())
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                          width:ScreenSize(context).heightOnly(4.4),
                          height: ScreenSize(context).heightOnly(4.4),
                          padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(MyColor.colorWhite),
                              border: Border.all(
                                  color: const Color(MyColor.colorT5),
                                  width: 1.0
                              )

                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            child: Image.asset('assets/avatar.png',fit: BoxFit.cover,
                            ),
                          )
                      )
                  ),
                  SizedBox(width: ScreenSize(context).widthOnly( 2),),
                  Expanded(
                    child: Text(
                      requestNamesResultSet?.requestTitle??'',
                      style: GetFont.get(
                          context,
                          fontSize:1.8,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenSize(context).widthOnly( 2),),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: ScreenSize(context).heightOnly( 1.8),
                    color: const Color(MyColor.colorBlack),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//------
class TimeOffWidget extends StatelessWidget {
  final int? index;
  const TimeOffWidget(this.index,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Navigator.pushNamed(context, CurrentPage.TimeOffPage);
            },
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
              child: Row(
                children: [
                  CachedNetworkImage(
                      imageUrl: '',
                      imageBuilder: (context, imageProvider) => Container(
                        width:ScreenSize(context).heightOnly(4.4),
                        height: ScreenSize(context).heightOnly(4.4),
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(MyColor.colorWhite),
                          border: Border.all(
                              color: const Color(MyColor.colorT5),
                              width: 1.0
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        width:ScreenSize(context).heightOnly(4.4),
                        height: ScreenSize(context).heightOnly(4.4),
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(MyColor.colorWhite),
                            border: Border.all(
                                color: const Color(MyColor.colorT5),
                                width: 1.0
                            )

                        ),
                        child: const ClipOval(
                            child: Center(child: CircularProgressIndicator())
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                          width:ScreenSize(context).heightOnly(4.4),
                          height: ScreenSize(context).heightOnly(4.4),
                          padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(MyColor.colorWhite),
                              border: Border.all(
                                  color: const Color(MyColor.colorT5),
                                  width: 1.0
                              )

                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            child: Image.asset('assets/avatar.png',fit: BoxFit.cover,
                            ),
                          )
                      )
                  ),
                  SizedBox(width: ScreenSize(context).widthOnly( 2),),
                  Expanded(
                    child: Text(
                      '${CallLanguageKeyWords.get(context, LanguageCodes.TimeOff)}',
                      style: GetFont.get(
                          context,
                          fontSize:1.8,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenSize(context).widthOnly( 2),),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: ScreenSize(context).heightOnly( 1.8),
                    color: const Color(MyColor.colorBlack),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class TEstingWidget extends StatelessWidget {
  final int? index;
  const TEstingWidget(this.index,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              Navigator.pushNamed(context, CurrentPage.TimeRegulationListPage);
            },
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
              child: Row(
                children: [
                  CachedNetworkImage(
                      imageUrl: '',
                      imageBuilder: (context, imageProvider) => Container(
                        width:ScreenSize(context).heightOnly(4.4),
                        height: ScreenSize(context).heightOnly(4.4),
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(MyColor.colorWhite),
                          border: Border.all(
                              color: const Color(MyColor.colorT5),
                              width: 1.0
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        width:ScreenSize(context).heightOnly(4.4),
                        height: ScreenSize(context).heightOnly(4.4),
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(MyColor.colorWhite),
                            border: Border.all(
                                color: const Color(MyColor.colorT5),
                                width: 1.0
                            )

                        ),
                        child: const ClipOval(
                            child: Center(child: CircularProgressIndicator())
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                          width:ScreenSize(context).heightOnly(4.4),
                          height: ScreenSize(context).heightOnly(4.4),
                          padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(MyColor.colorWhite),
                              border: Border.all(
                                  color: const Color(MyColor.colorT5),
                                  width: 1.0
                              )

                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                            child: Image.asset('assets/avatar.png',fit: BoxFit.cover,
                            ),
                          )
                      )
                  ),
                  SizedBox(width: ScreenSize(context).widthOnly( 2),),
                  Expanded(
                    child: Text(
                      'Testing Wiget',
                      style: GetFont.get(
                          context,
                          fontSize:1.8,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                      ),
                    ),
                  ),
                  SizedBox(width: ScreenSize(context).widthOnly( 2),),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: ScreenSize(context).heightOnly( 1.8),
                    color: const Color(MyColor.colorBlack),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
