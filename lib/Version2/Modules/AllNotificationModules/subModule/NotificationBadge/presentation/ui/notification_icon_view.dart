import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:peopleqlik_debug/Version2/Modules/AllNotificationModules/subModule/NotificationBadge/domain/repo/notification_badge_controller_repo.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/routing/pages_name.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:badges/badges.dart' as badges;

class NotificationIconView extends StatefulWidget {
  const NotificationIconView({super.key});

  @override
  State<NotificationIconView> createState() => _NotificationIconViewState();
}

class _NotificationIconViewState extends State<NotificationIconView> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      NotificationBadgeControllerRepo.instance.checkLazily();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: const Color(MyColor.colorTransparent),
        child: Padding(
          padding: EdgeInsets.all(ScreenSize(context).heightOnly( 1.2)),
          child: InkWell(
            splashColor: const Color(MyColor.colorGrey0),
            onTap: (){
              Navigator.pushNamed(context, CurrentPage.NotificationPage);
            },
            child: StreamBuilder(
              stream: NotificationBadgeControllerRepo.instance.getStream(),
                builder: (context, snapShot) {
                  return badges.Badge(
                      position: badges.BadgePosition.topEnd(
                        top: ScreenSize(context).heightOnly(-0.6),
                        end: ScreenSize(context).heightOnly(-0.4),
                      ),
                      badgeStyle: badges.BadgeStyle(
                        shape: badges.BadgeShape.circle,
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly(0.7)),
                        badgeColor: const Color(MyColor.colorPrimary),
                      ),
                      badgeAnimation: const badges.BadgeAnimation.scale(
                        animationDuration: Duration(milliseconds: 80),
                      ),
                      showBadge: snapShot.data??false,
                      badgeContent: Text(' ',
                          style: GetFont.get(context,
                              fontWeight: FontWeight.w400,
                              color: MyColor.colorWhite,
                              fontSize: 0.2)),
                      child: Icon(
                        MdiIcons.bellOutline,
                        size: ScreenSize(context).heightOnly(3.5),
                        color: const Color(MyColor.colorBlack),
                      )
                  );
                }
            ),
          ),
        ),
      ),
    );
  }
}
