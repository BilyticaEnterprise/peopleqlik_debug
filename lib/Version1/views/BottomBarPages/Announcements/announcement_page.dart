import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peopleqlik_debug/Version1/viewModel/AnnouncementListeners/announcements_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/models/Notifications/announcement_list_model.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/utils/screenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:peopleqlik_debug/utils/strings.dart';
import 'package:provider/provider.dart';

import '../../../../../configs/get_assets.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInternetConnection>(
      builder: (context,data,child) {
        if(data.internetConnectionEnum == InternetConnectionEnum.available)
          {
            return ChangeNotifierProvider<GetAnnouncementModelListener>(
                create: (_) => GetAnnouncementModelListener(),
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
      Provider.of<GetAnnouncementModelListener>(context,listen: false).start(context, ApiStatus.started);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetAnnouncementModelListener>(
      builder: (context,data,child) {
        if(data.apiStatus == ApiStatus.done)
        {
          return AnnouncementMultipleWidgetBody(data.notificationDataList);
        }
        else if(data.apiStatus == ApiStatus.empty)
        {
          return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr32)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr33)}',topMargin: 8,width: 40,);
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
class AnnouncementMultipleWidgetBody extends StatelessWidget {
  final GetAnnouncementListResultSet? announcementDataList;
  const AnnouncementMultipleWidgetBody(this.announcementDataList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(announcementDataList?.announcements!=null&&announcementDataList!.announcements!.isNotEmpty)...
            [
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 2),bottom: ScreenSize(context).heightOnly( 2)),
                  itemBuilder: (context,index)
                  {
                    return AnnouncementWidget(announcementDataList?.announcements?[index],index);
                  },
                  separatorBuilder: (context,index)
                  {
                    return SizedBox(height: ScreenSize(context).heightOnly( 2),);
                  },
                  itemCount: announcementDataList?.announcements?.length??0
              ),
            ],
            if(announcementDataList?.anniversary!=null&&announcementDataList!.anniversary!.isNotEmpty)...
            [
              SizedBox(height: ScreenSize(context).heightOnly( 1),),
              HeaderWidget('${CallLanguageKeyWords.get(context, LanguageCodes.anniversary)}'),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 2),bottom: ScreenSize(context).heightOnly( 2)),
                  itemBuilder: (context,index)
                  {
                    return AnniversaryWidget(announcementDataList?.anniversary?[index],index);
                  },
                  separatorBuilder: (context,index)
                  {
                    return SizedBox(height: ScreenSize(context).heightOnly( 2),);
                  },
                  itemCount: announcementDataList?.anniversary?.length??0
              ),
            ],
            if(announcementDataList?.employeeOnLeave!=null&&announcementDataList!.employeeOnLeave!.isNotEmpty)...
            [
              SizedBox(height: ScreenSize(context).heightOnly( 1),),
              HeaderWidget('${CallLanguageKeyWords.get(context, LanguageCodes.leaves)}'),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 2),bottom: ScreenSize(context).heightOnly( 10)),
                  itemBuilder: (context,index)
                  {
                    return EmployeeLeavesWidget(announcementDataList?.employeeOnLeave?[index],index);
                  },
                  separatorBuilder: (context,index)
                  {
                    return SizedBox(height: ScreenSize(context).heightOnly( 2),);
                  },
                  itemCount: announcementDataList?.employeeOnLeave?.length??0
              ),
            ],

          ],

      ),
    );
  }
}
class HeaderWidget extends StatelessWidget {
  final String? title;
  const HeaderWidget(this.title,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 6.0)),
      child: Text(
        '$title',
        style: GetFont.get(
            context,
            fontWeight: FontWeight.w600,
            color: MyColor.colorBlack,
            fontSize: 2.2
        ),
      ),
    );
  }
}
class EmployeeLeavesWidget extends StatelessWidget {
  final EmployeeOnLeave? leaves;
  final int index;
  const EmployeeLeavesWidget(this.leaves,this.index,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
              width: 1,
              color: const Color(MyColor.colorBackgroundDark)
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          leaves?.employeeName??'',
                          style: GetFont.get(
                              context,
                              fontSize:1.8,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                        ),
                        SizedBox(height: ScreenSize(context).heightOnly( 0.6),),
                        Text(
                          leaves?.jobTitle??'',
                          style: GetFont.get(
                              context,
                              fontSize:1.4,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorBlack
                          ),
                        ),
                      ],
                    )
                ),
                CachedNetworkImage(
                    imageUrl: '${RequestType.profileUrl}${leaves?.picture}',
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
              ],
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 1),),
            RichText(
              text: TextSpan(
                children: [
                  WidgetSpan(
                      child: SvgPicture.string(
                        SvgPicturesData.locationPin,
                        height: ScreenSize(context).heightOnly( 2),
                        width: ScreenSize(context).heightOnly( 2),
                      )
                  ),
                  WidgetSpan(child: SizedBox(
                    width: ScreenSize(context).heightOnly( 0.4),
                  )),
                  TextSpan(
                    text: leaves?.location??'',
                    style: GetFont.get(
                        context,
                        fontSize:1.6,
                        fontWeight: FontWeight.w400,
                        color: MyColor.colorGrey3
                    ),
                  )
                ]
              ),
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 1),),
            Row(
              children: [
                SvgPicture.string(
                  SvgPicturesData.holiday,
                  height: ScreenSize(context).heightOnly( 2),
                  width: ScreenSize(context).heightOnly( 2),
                ),
                SizedBox(width: ScreenSize(context).heightOnly( 0.6),),
                Expanded(
                  child: Text(
                    '${CallLanguageKeyWords.get(context, LanguageCodes.leaveTotal)} ${leaves?.leaveDays??''}',
                    style: GetFont.get(
                        context,
                        fontSize:1.6,
                        fontWeight: FontWeight.w600,
                        color: MyColor.colorGrey3
                    ),
                  ),
                ),
                SizedBox(width: ScreenSize(context).heightOnly( 0.6),),
                SvgPicture.string(
                  SvgPicturesData.leaveDate,
                  height: ScreenSize(context).heightOnly( 2),
                  width: ScreenSize(context).heightOnly( 2),
                ),
                SizedBox(width: ScreenSize(context).heightOnly( 0.6),),
                Text(
                  leaves?.leaveDate??'',
                  style: GetFont.get(
                      context,
                      fontSize:1.6,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorGrey3
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AnniversaryWidget extends StatelessWidget {
  final Anniversary? anniversary;
  final int index;
  const AnniversaryWidget(this.anniversary,this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
              width: 1,
              color: const Color(MyColor.colorBackgroundDark)
          )
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        anniversary?.event??'',
                        style: GetFont.get(
                            context,
                            fontSize:1.8,
                            fontWeight: FontWeight.w600,
                            color: MyColor.colorBlack
                        ),
                      ),
                      SizedBox(height: ScreenSize(context).heightOnly( 0.6),),
                      Text(
                        anniversary?.employeeName??'',
                        style: GetFont.get(
                            context,
                            fontSize:1.4,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorBlack
                        ),
                      ),
                    ],
                  )
                ),
                CachedNetworkImage(
                    imageUrl: '${RequestType.profileUrl}${anniversary?.picture}',
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
              ],
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 1),),
            Text(
              '${CallLanguageKeyWords.get(context, LanguageCodes.leaveEvent)} ${anniversary?.date??''}',
              style: GetFont.get(
                  context,
                  fontSize:1.6,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorGrey3
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnnouncementWidget extends StatelessWidget {
  final Announcements? announcements;
  final int? index;
  const AnnouncementWidget(this.announcements,this.index,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          color: const Color(MyColor.colorTransparent),
          child: InkWell(
            splashColor: const Color(MyColor.colorBackgroundDark),
            onTap: (){
              Navigator.pushNamed(context, CurrentPage.AnnouncementDetailPage,arguments: announcements?.announcementCode);
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
                          announcements?.announcementTitle??'',
                          style: GetFont.get(
                              context,
                              fontSize:1.8,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 1),),
                  Row(
                    children: [
                      Text(
                        announcements?.date??'',
                        style: GetFont.get(
                            context,
                            fontSize:1.4,
                            fontWeight: FontWeight.w400,
                            color: MyColor.colorGrey3
                        ),
                      ),
                      Expanded(child: SizedBox(width: ScreenSize(context).widthOnly( 2),)),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: Material(
                          color: const Color(MyColor.colorGrey6),
                          child: Padding(
                              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.75)),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                size: ScreenSize(context).heightOnly( 2.0),
                                color: const Color(MyColor.colorGrey3),
                              )
                          ),
                        ),
                      )
                    ],
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
