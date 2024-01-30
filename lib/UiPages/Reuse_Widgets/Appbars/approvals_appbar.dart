import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/Approvals/approvals_collector.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/icons.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:provider/provider.dart';

class ApprovalsAppBarWidget extends StatelessWidget {
  String title;
  ApprovalsAppBarWidget(this.title, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ChangeLanguage changeLanguage = Provider.of<ChangeLanguage>(context,listen: false);
    return Container(
      padding:EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 4.6)),
      height: ScreenSize(context).heightOnly( 5.5),
      child: Stack(
        children: [
          Align(
            alignment: changeLanguage.languageEnum == LanguageEnum.arabic?Alignment.centerRight:Alignment.centerLeft,
            child: ClipRRect(
              borderRadius:const BorderRadius.all(Radius.circular(5)),
              child: Material(
                color: const Color(MyColor.colorTransparent),
                child: InkWell(
                  splashColor: const Color(MyColor.colorGrey0),
                  onTap:(){
                    Navigator.pop(context);
                  },
                  child:  Padding(
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.5)),
                    child: SvgPicture.string(changeLanguage.languageEnum == LanguageEnum.arabic?SvgPicturesData.backRight:SvgPicturesData.back,width: ScreenSize(context).heightOnly( 3.0),height:ScreenSize(context).heightOnly( 3.0),color: const Color(MyColor.colorBlack),),
                  ),
                ),
              ),
            ),
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
                child: InkWell(
                  splashColor: const Color(MyColor.colorGrey0),
                  onTap:(){
                    Provider.of<ApprovalCollector>(context,listen: false).panelController?.open();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.0)),
                    child: Consumer<ApprovalCollector>(
                      builder: (context,data,child) {
                        return badges.Badge(
                            position: badges.BadgePosition.topEnd(top: -ScreenSize(context).heightOnly( 0.7), end: -ScreenSize(context).heightOnly( 0.7)),
                            badgeStyle: badges.BadgeStyle(
                              shape: badges.BadgeShape.circle,
                              padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.4)),
                              badgeColor: const Color(MyColor.colorPrimary),
                            ),
                            badgeAnimation: const badges.BadgeAnimation.scale(
                              animationDuration: Duration(milliseconds: 80),
                            ),
                            showBadge: data.approvalPageEnum == data.approvalFiltersEnum&&data.approvalFiltersEnum!=ApprovalPageEnum.nothing?true:false,
                            badgeContent: SvgPicture.string(
                                    SvgPicturesData.done,
                                    color: const Color(MyColor.colorWhite),
                                    width : ScreenSize(context).heightOnly( 1.6)
                            ),
                            child: SvgPicture.string(SvgPicturesData.filter,width: ScreenSize(context).heightOnly( 3.4),height:ScreenSize(context).heightOnly( 3.4),color: const Color(MyColor.colorBlack),)
                        );
                      }
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}