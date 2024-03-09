import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/utils/Urls/urls.dart';
import 'package:peopleqlik_debug/Version1/viewModel/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/repoImpl/settings_listeners.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleSetting/domain/model/settings_model.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

class AppBarWidgetDashBoard extends StatelessWidget {
  final String title;
  final int currentIndex;
  final Function()? profileTap;
  const AppBarWidgetDashBoard(this.title, this.currentIndex, {this.profileTap,Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
    return Container(
      padding:EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 0.8)),
      height: ScreenSize(context).heightOnly( 6.8),
      child:
      currentIndex!=4?
      Stack(
        children: [
          Align(
            alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.centerRight:Alignment.centerLeft,
            child: GestureDetector(
              onTap: profileTap,
              child: CachedNetworkImage(
                  imageUrl: '${RequestType.profileUrl}${Provider.of<SettingsModelListener>(context,listen: false).settingsResultSet?.myProfile?.picture}',
                  imageBuilder: (context, imageProvider) => Container(
                    width:ScreenSize(context).heightOnly(4.4),
                    height: ScreenSize(context).heightOnly(4.4),
                    margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(1)),
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(MyColor.colorWhite),
                      border: Border.all(
                          color: const Color(MyColor.colorPrimary),
                          width: 1.5
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
                    margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1)),
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(MyColor.colorWhite),
                        border: Border.all(
                            color: const Color(MyColor.colorPrimary),
                            width: 1.5
                        )

                    ),
                    child: const ClipOval(
                        child: Center(child: CircularProgressIndicator())
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                      width:ScreenSize(context).heightOnly(4.4),
                      height: ScreenSize(context).heightOnly(4.4),
                      margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly( 1)),
                      padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.2)),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(MyColor.colorWhite),
                          border: Border.all(
                              color: const Color(MyColor.colorPrimary),
                              width: 1.5
                          )

                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(15)),
                        child: Image.asset('assets/avatar.png',fit: BoxFit.cover,
                        ),
                      )
                  )
              ),
            ),
            // child: ClipRRect(
            //   borderRadius:BorderRadius.all(Radius.circular(5)),
            //   child: Material(
            //     color: const Color(MyColor.colorTransparent),
            //     child: InkWell(
            //       splashColor: Color(MyColor.colorGrey0),
            //       onTap:(){
            //         // Navigator.pop(context);
            //       },
            //       child:  Padding(
            //         padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.2)),
            //         child:
            //         SvgPicture.string(SvgPicturesData.hamBurger,width: ScreenSize(context).heightOnly( 3.4),height:ScreenSize(context).heightOnly( 3.4),color: Color(MyColor.colorBlack),),
            //       ),
            //     ),
            //   ),
            // )
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: GetFont.get(
                    context,
                    fontSize: 2.0,
                    color: MyColor.colorBlack,
                    fontWeight: FontWeight.w600
                ),

              )
          ),
          Align(
            alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.centerLeft:Alignment.centerRight,
            child: ClipOval(
              child: Material(
                color: const Color(MyColor.colorTransparent),
                child: Padding(
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.2)),
                    child: InkWell(
                      splashColor: const Color(MyColor.colorGrey0),
                      onTap: (){
                        Navigator.pushNamed(context, CurrentPage.NotificationPage);
                      },
                      child: badges.Badge(
                          position: badges.BadgePosition.topEnd(
                              top: ScreenSize(context).heightOnly( 0.7),
                              end: ScreenSize(context).heightOnly( 0.7)),
                          badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.circle,
                            padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.7)),
                            badgeColor: const Color(MyColor.colorPrimary),
                          ),
                          badgeAnimation: const badges.BadgeAnimation.scale(
                            animationDuration: Duration(milliseconds: 80),
                          ),
                          showBadge: false,
                          badgeContent: Text('0',
                              style: GetFont.get(context,
                                  fontWeight: FontWeight.w400,
                                  color: MyColor.colorWhite,
                                  fontSize: 1.3)),
                          child: Icon(
                            MdiIcons.bellOutline,
                            size: ScreenSize(context).heightOnly( 3.5),
                            color: const Color(MyColor.colorBlack),
                          )
                      ),
                    ),
                  ),
                ),
            ),
          )
        ],
      ):Container(),
    );
  }
}