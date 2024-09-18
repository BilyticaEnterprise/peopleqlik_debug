import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/Version1/viewModel/TeamGetListeners/team_detail_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version1/models/TeamModel/get_team_model.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/internetConnectionChecker/internet_connection.dart';
import 'package:peopleqlik_debug/utils/errorsUi/not_available.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/utils/headers/header_large.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/icons.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';
import '../../../../../configs/get_assets.dart';
import '../../../../../utils/Appbars/app_bar.dart';
import '../../../../../utils/wave_clipper.dart';
import 'package:peopleqlik_debug/utils/SkeletetonAnimation/skeleton_text.dart';

import 'Widgets/action_widgets.dart';
import 'Widgets/view_widgets.dart';

class TeamDetailPage extends StatelessWidget {
  TeamDetailPage({Key? key}) : super(key: key);
  TeamDataList? teamDataList;
  @override
  Widget build(BuildContext context) {
    teamDataList = ModalRoute.of(context)?.settings.arguments as TeamDataList;
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
                title: AppBarWidget('${CallLanguageKeyWords.get(context, LanguageCodes.employeeDetail)}'),
              ),
            ];
          },
          body: Consumer<CheckInternetConnection>(
              builder: (context,data,child) {
                if(data.internetConnectionEnum == InternetConnectionEnum.available)
                {
                  return ChangeNotifierProvider<TeamDetailListener>(
                      create: (_) => TeamDetailListener(teamDataList!,context),
                      child: BodyData(teamDataList));
                }
                else
                {
                  return NotAvailable(GetAssets.internetAnim, '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr26)}', '${CallLanguageKeyWords.get(context, LanguageCodes.stringsstr27)}',topMargin: 8,width: 50,height: 24,);
                }
              }
          ),
        )
    );
  }
}
class BodyData extends StatelessWidget {
  final TeamDataList? teamDataList;
  const BodyData(this.teamDataList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height/100*22;
    double _width = MediaQuery.of(context).size.width;
    LanguageEnum languageEnum = Provider.of<ChangeLanguage>(context,listen: false).languageEnum;
    return
      SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: _height,
                      width: _width,
                      child: ClipPath(
                        clipper: WaveClipper(),
                        child: CachedNetworkImage(
                            imageUrl: '${RequestType.profileUrl}${teamDataList?.picture}',
                            imageBuilder: (context, imageProvider) => Container(
                              width: _width,
                              height: _height,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: const Color(MyColor.colorWhite),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: _width,
                              height: _height,
                              decoration: const BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color(MyColor.colorWhite),

                              ),
                              child: const ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  child: Center(child: CircularProgressIndicator())
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                                width: _width,
                                height: _height,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: Color(MyColor.colorGrey0),

                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                                  child: Image.asset('assets/logo.png',fit: BoxFit.fitWidth,
                                  ),
                                )
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                        height: _height,
                        width: _width,
                        child: Stack(
                          children: [
                            Positioned(
                              top: 0,
                              left: 0,
                              width: _width,
                              height: _height,
                              child: ClipPath(
                                clipper: WaveClipper(),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                                  child: Container(
                                    height: ScreenSize(context).heightOnly( 20),
                                    alignment: Alignment.center,
                                    color: const Color(MyColor.colorWhite).withOpacity(0.8),
                                  ),
                                ),

                              ),
                            ),
                          ],
                        )
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: _height/100*44,),
                        Align(
                          alignment: Alignment.center,
                          child: CachedNetworkImage(
                            imageUrl: "${RequestType.profileUrl}${teamDataList?.picture}",
                            imageBuilder: (context, imageProvider) => Container(
                              width: ScreenSize(context).heightOnly(18),
                              height: ScreenSize(context).heightOnly(18),
                              margin: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  //borderRadius: const BorderRadius.all(Radius.circular(45)),
                                  color: const Color(MyColor.colorWhite),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(MyColor.colorGrey2).withOpacity(0.6),
                                      spreadRadius: 5,
                                      blurRadius: 7,
                                      offset: const Offset(0, 3), // changes position of shadow
                                    ),
                                    BoxShadow(
                                      color: const Color(MyColor.colorGrey0).withOpacity(0.2),
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: const Offset(-3, -3), // changes position of shadow
                                    ),
                                  ],
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover
                                  )

                              ),
                            ),
                            placeholder: (context, url) => Container(
                              width: ScreenSize(context).heightOnly(18),
                              height: ScreenSize(context).heightOnly(18),
                              margin: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //borderRadius: const BorderRadius.all(Radius.circular(45)),
                                color: const Color(MyColor.colorWhite),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(MyColor.colorGrey2).withOpacity(0.6),
                                    spreadRadius: 4,
                                    blurRadius: 6,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: const Color(MyColor.colorGrey0).withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(-3, -3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(45)),
                                  child: SkeletonAnimation(
                                    shimmerColor:const Color(MyColor.colorGrey0).withOpacity(0.2),
                                    gradientColor:const Color.fromARGB(0, 244, 244, 244),
                                    curve:Curves.easeInOutSine,
                                    child: const SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  )
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: ScreenSize(context).heightOnly(18),
                              height: ScreenSize(context).heightOnly(18),
                              margin: EdgeInsets.all(ScreenSize(context).heightOnly(1.0)),
                              padding: EdgeInsets.all(ScreenSize(context).heightOnly(1.2)),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(Radius.circular(45)),
                                color: const Color(MyColor.colorGrey6),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(MyColor.colorGrey2).withOpacity(0.6),
                                    spreadRadius: 3,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                  BoxShadow(
                                    color: const Color(MyColor.colorGrey0).withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: const Offset(-3, -3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(45)),
                                child: Image.asset('assets/avatar_profile.png',fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: ScreenSize(context).heightOnly( 2.0),),
                        if(teamDataList?.jobTitle!=null&&teamDataList!.jobTitle!.isNotEmpty)...[
                          Text(
                            teamDataList?.jobTitle??'',
                            style: GetFont.get(
                              context,
                              fontSize: 1.6,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorBlack,
                            ),
                          ),
                          SizedBox(height: ScreenSize(context).heightOnly( 0.1),),
                        ],
                        Text(
                          '${teamDataList?.fullName}',
                          style: GetFont.get(
                              context,
                              fontSize: 2.6,
                              fontWeight: FontWeight.w600,
                              color: MyColor.colorBlack
                          ),
                        ),
                        SizedBox(height: ScreenSize(context).heightOnly( 1.0),),
                        RichText(
                          text: TextSpan(
                              children: [
                                WidgetSpan(
                                    child: SvgPicture.string(
                                      SvgPicturesData.birthDay,
                                      width: ScreenSize(context).heightOnly( 3),
                                      height: ScreenSize(context).heightOnly( 3),
                                    )
                                ),
                                WidgetSpan(child: SizedBox(width: ScreenSize(context).heightOnly( 1),)),
                                TextSpan(
                                  text: GetDateFormats().getFilterDate(teamDataList?.dOB)??'',
                                  style: GetFont.get(
                                    context,
                                    fontSize: 1.8,
                                    fontWeight: FontWeight.w400,
                                    color: MyColor.colorGrey3,
                                  ),
                                )
                              ]
                          ),
                        ),
                        if(teamDataList?.emailID!=null&&teamDataList!.emailID!.isNotEmpty)...[
                          SizedBox(height: ScreenSize(context).heightOnly( 1),),
                          Text(
                            teamDataList?.emailID??'',
                            style: GetFont.get(
                              context,
                              fontSize: 1.8,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorGrey3,
                            ),
                          )
                        ],

                      ],
                    ),
                  ],
                ),

                SizedBox(height: ScreenSize(context).heightOnly( 3),),
                Align(
                    alignment: languageEnum==LanguageEnum.english?Alignment.centerLeft:Alignment.centerRight,
                    child: MainHeaderWidget(text: CallLanguageKeyWords.get(context, LanguageCodes.info)??'')),
                EmployeeDetailView(teamDataList),
                Align(
                    alignment: languageEnum==LanguageEnum.english?Alignment.centerLeft:Alignment.centerRight,
                    child: MainHeaderWidget(text: CallLanguageKeyWords.get(context, LanguageCodes.actions)??'')),
                EmployeeDetailActionView(teamDataList,onTapIndex: (index){
                  Provider.of<TeamDetailListener>(context,listen: false).onActionTap(index,context,teamDataList);
                },),
                DividerByHeight(10),

              ],
            ),

      );
  }
}

