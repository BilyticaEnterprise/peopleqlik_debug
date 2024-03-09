import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/NotifcationsListeners/notification_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/Models/Notifications/notification_model.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/utils/ScreenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/configs/prints_logs.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';
import '../../../../../configs/get_assets.dart';
import '../../../../../utils/Appbars/app_bar.dart';
import '../../../../utils/cached_image_getter/cache_image.dart';
import 'package:peopleqlik_debug/utils/SkeletetonAnimation/skeleton_text.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                title: AppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.notificationsAppBar)}')
            ),
          ];
        },
        body: Consumer<CheckInternetConnection>(
            builder: (context,data,child) {
              if(data.internetConnectionEnum == InternetConnectionEnum.available)
              {
                return ChangeNotifierProvider<GetNotificationModelListener>(
                    create: (_) => GetNotificationModelListener(),
                    builder: (context, snapshot) {
                      return const BodyData();
                    }
                );
              }
              else
              {
                return NotAvailable(GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
              }
            }
        ),
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
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<GetNotificationModelListener>(context,listen: false).start(context, ApiStatus.started);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetNotificationModelListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done|| data.apiStatus == ApiStatus.pagination)
          {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification){
                GetNotificationModelListener getNotificationModelListener = Provider.of<GetNotificationModelListener>(context,listen: false);
                // PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                {
                  // PrintLogs.print('true');
                  getNotificationModelListener.updateStep(true, context);
                  return true;
                }
                else
                {
                  getNotificationModelListener.updateStep(false, context);
                  return false;
                }
              },
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 2),bottom: ScreenSize(context).heightOnly( 10)),
                  itemBuilder: (context,index)
                  {
                    return NotificationWidget(data.dataList?[index],index);
                  },
                  separatorBuilder: (context,index)
                  {
                    return SizedBox(height: ScreenSize(context).heightOnly( 2),);
                  },
                  itemCount: data.dataList?.length??0
              ),
            );
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr19)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr20)}',topMargin: 8,width: 40,);
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
class NotificationWidget extends StatelessWidget {
  final NotificationResultSet? notificationDataList;
  final int? index;
  const NotificationWidget(this.notificationDataList,this.index,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PrintLogs.printLogs('${RequestType.profileUrl}${notificationDataList?.picture}');
    return Provider.of<GetNotificationModelListener>(context,listen: false).reachedEnd&&index==Provider.of<GetNotificationModelListener>(context,listen: false).dataList!.length-1?
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
          key: Key('timeOffShimmer$index'),
          shimmerColor:Colors.white70,
          gradientColor:const Color(MyColor.colorGreyPrimary).withOpacity(0.2),
          curve:Curves.fastOutSlowIn, child: Container()),
    ):Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
              width: 1,
              color: const Color(MyColor.colorBackgroundDark)
          )
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Material(
          color: const Color(MyColor.colorWhite),
          child: InkWell(
            splashColor: const Color(MyColor.colorGrey0),
            onTap: (){
              Navigator.pushNamed(context, CurrentPage.NotificationDetailPage, arguments: notificationDataList?.body);
            },
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.8)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          GetDateFormats().getFilterDate(notificationDataList?.createdDate)??'',
                          style: GetFont.get(
                              context,
                              fontSize:1.8,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                        ),
                      ),
                      if(notificationDataList?.isRead==false)...[
                        Container(
                          height: ScreenSize(context).heightOnly( 0.8),
                          width: ScreenSize(context).heightOnly( 0.8),
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(MyColor.colorRed1)
                          ),
                        )
                      ],
                    ],
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly(1),),
                  // ClipRRect(
                  //   borderRadius: const BorderRadius.all(Radius.circular(20)),
                  //   child:  Material(
                  //     color: Color(notificationDataList?.screenID==164?MyColor.colorT5:MyColor.colorT1),
                  //     child: Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1.5),vertical: ScreenSize(context).heightOnly( 0.5)),
                  //       child: Text(
                  //         'Subject',
                  //         style: GetFont.get(
                  //             context,
                  //             fontSize:1.4,
                  //             fontWeight: FontWeight.w400,
                  //             color: MyColor.colorBlack
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // const DividerByHeight(1.5),
                  Text(
                    notificationDataList?.subject?.replaceAll('PeopleQlik - ', '').replaceAll('PeopleQlik-', '').replaceAll('Request', '')??'',
                    style: GetFont.get(
                        context,
                        fontSize: 1.6,
                        fontWeight: FontWeight.w400,
                        color: MyColor.colorBlack
                    ),
                  ),
                  const DividerByHeight(1.5),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            notificationDataList?.employeeName??'',
                          style: GetFont.get(
                              context,
                              fontSize:1.4,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorGrey3
                          ),
                        ),
                        const DividerByWidth(2),
                        GetNetWorkImage(
                            image: '${RequestType.profileUrl}${notificationDataList?.picture}',
                          size: 4.4,
                          boxShape: BoxShape.circle,
                          borderColor: MyColor.colorT5,
                          borderPadding: 0.2,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
