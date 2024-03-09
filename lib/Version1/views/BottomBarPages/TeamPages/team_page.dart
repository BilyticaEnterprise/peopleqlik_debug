import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TeamGetListeners/team_get_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/utils/Enums/apistatus_enum.dart';
import 'package:peopleqlik_debug/Version1/Models/TeamModel/get_team_model.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/utils/ScreenLoader/circular_indicator_customized.dart';
import 'package:peopleqlik_debug/utils/ErrorsUi/not_available.dart';
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
import 'package:peopleqlik_debug/utils/SkeletetonAnimation/skeleton_text.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  State<TeamPage> createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckInternetConnection>(
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
    );
  }
}
class BodyData extends StatefulWidget {
  const BodyData({Key? key}) : super(key: key);

  @override
  _BodyDataState createState() => _BodyDataState();
}

class _BodyDataState extends State<BodyData> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetTeamListModelListener>(context,listen: false).start(context, ApiStatus.started, null);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GetTeamListModelListener>(
        builder: (context,data,child) {
          if(data.apiStatus == ApiStatus.done|| data.apiStatus == ApiStatus.pagination)
          {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification){
                GetTeamListModelListener getTeamListModelListener = Provider.of<GetTeamListModelListener>(context,listen: false);
                // PrintLogs.print('${scrollNotification.metrics.pixels} ${scrollNotification.metrics.maxScrollExtent}');
                if(scrollNotification.metrics.pixels>0.0&&scrollNotification.metrics.pixels >= scrollNotification.metrics.maxScrollExtent-20)
                {
                  // PrintLogs.print('true');
                  getTeamListModelListener.updateStep(true, context);
                  return true;
                }
                else
                {
                  getTeamListModelListener.updateStep(false, context);
                  return false;
                }
              },
              child: ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 2),bottom: ScreenSize(context).heightOnly( 10)),
                  itemBuilder: (context,index)
                  {
                    return TeamWidget(data.teamDataList?[index],index);
                  },
                  separatorBuilder: (context,index)
                  {
                    return SizedBox(height: ScreenSize(context).heightOnly( 2),);
                  },
                  itemCount: data.teamDataList?.length??0
              ),
            );
          }
          else if(data.apiStatus == ApiStatus.empty)
          {
            return NotAvailable('not_available', '${CallLanguageKeyWords.get(context, LanguageCodes.teamHeader)}', '${CallLanguageKeyWords.get(context, LanguageCodes.teamValue)}',topMargin: 8,width: 40,);
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
class TeamWidget extends StatelessWidget {
  final TeamDataList? teamDataList;
  final int? index;
  const TeamWidget(this.teamDataList,this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<GetTeamListModelListener>(context,listen: false).reachedEnd&&index==Provider.of<GetTeamListModelListener>(context,listen: false).teamDataList!.length-1?
    Container(
      height: ScreenSize(context).heightOnly( 14),
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
      width: double.maxFinite,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: const Color(MyColor.colorBackgroundDark),
            width: 1,
          )
      ),
      child: SkeletonAnimation(
          key: Key('timeOffShimmer$index'),
          shimmerColor:Colors.white70,
          gradientColor:const Color(MyColor.colorGreyPrimary).withOpacity(0.2),
          curve:Curves.fastOutSlowIn, child: Container()),
    ):Container(
      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly(5.6)),
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
            splashColor: const Color(MyColor.colorBackgroundDark),
            onTap: (){
              Navigator.pushNamed(context, CurrentPage.TeamDetailPage,arguments: teamDataList);
            },
            child: Padding(
              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.5)),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${teamDataList?.fullName}',
                          style: GetFont.get(
                              context,
                              fontSize: 1.8,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                        ),
                        SizedBox(height: ScreenSize(context).heightOnly( 0.6),),
                        Text(
                          '${teamDataList?.jobTitle}',
                          style: GetFont.get(
                              context,
                              fontSize: 1.5,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorGrey3
                          ),
                        ),
                        SizedBox(height: ScreenSize(context).heightOnly( 1),),
                        RichText(
                          text: TextSpan(
                              text: '${CallLanguageKeyWords.get(context, LanguageCodes.supervisor)}: ',
                              style: GetFont.get(
                                context,
                                fontSize: 1.4,
                                fontWeight: FontWeight.w600,
                                color: MyColor.colorBlack,
                              ),
                            children: [
                              TextSpan(
                                text: teamDataList?.supervisorName?.toUpperCase()??'',
                                style: GetFont.get(
                                  context,
                                  fontSize: 1.4,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.colorGrey3,
                                ),
                              )
                            ]
                          ),
                        ),
                        SizedBox(height: ScreenSize(context).heightOnly( 1),),
                        RichText(
                          text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: SvgPicture.string(
                                    SvgPicturesData.birthDay,
                                    width: ScreenSize(context).heightOnly( 2),
                                    height: ScreenSize(context).heightOnly( 2),
                                  )
                                ),
                                WidgetSpan(child: SizedBox(width: ScreenSize(context).heightOnly( 1),)),
                                TextSpan(
                                  text: GetDateFormats().getFilterDate(teamDataList?.dOB)??'',
                                  style: GetFont.get(
                                    context,
                                    fontSize: 1.5,
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.colorGrey3,
                                  ),
                                )
                              ]
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CachedNetworkImage(
                          imageUrl: '${RequestType.profileUrl}${teamDataList?.picture}',
                          imageBuilder: (context, imageProvider) => Container(
                            width: ScreenSize(context).heightOnly( 6),
                            height: ScreenSize(context).heightOnly( 6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: const Color(MyColor.colorWhite),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            width: ScreenSize(context).heightOnly( 6),
                            height: ScreenSize(context).heightOnly( 6),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(MyColor.colorWhite),

                            ),
                            child: const ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                child: Center(child: CircularProgressIndicator())
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                              width: ScreenSize(context).heightOnly( 6),
                              height: ScreenSize(context).heightOnly( 6),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(MyColor.colorGrey0),

                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(15)),
                                child: Image.asset('assets/logo.png',fit: BoxFit.fitWidth,
                                ),
                              )
                          )
                      ),
                      SizedBox(height: ScreenSize(context).heightOnly( 2),),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        child: Material(
                          color: const Color(MyColor.colorGrey6),
                          child: InkWell(
                            splashColor: const Color(MyColor.colorGrey0),
                            //onTap: (){},
                            child: Padding(
                                padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.75)),
                                child: Icon(
                                  Icons.arrow_forward_ios,
                                  size: ScreenSize(context).heightOnly( 2.0),
                                  color: const Color(MyColor.colorGrey3),
                                )
                            ),
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

