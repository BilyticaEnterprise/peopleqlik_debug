import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:peopleqlik_debug/utils/Enums/dashboard_enums.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:provider/provider.dart';

import '../../../../../../../Version1/viewModel/LanguageListeners/language_listener.dart';
import '../../../../../../../configs/colors.dart';
import '../../../../../../../configs/fonts.dart';
import '../../../../../../../utils/icon_view/next_icon.dart';
import '../../../../../../../utils/screen_sizes.dart';
import '../../../../utils/common_dashboard_container.dart';

class BottomCardWidget extends StatelessWidget {
  final DashboardEnum dashboardEnum;
  final String header,value,animationIcon;
  final double? animSize;
  final double? paddingRight;
  final int? iconColor;
  final Function() onTap;
  const BottomCardWidget({required this.dashboardEnum,required this.onTap,required this.header,required this.value,this.iconColor, required this.animationIcon,this.animSize,this.paddingRight,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonDashboardContainer(
      noPadding: true,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(Provider.of<ChangeLanguage>(context,listen: false).languageEnum == LanguageEnum.arabic?0:ScreenSize(context).heightOnly( 1.6), ScreenSize(context).heightOnly( 1.6), Provider.of<ChangeLanguage>(context,listen: false).languageEnum == LanguageEnum.arabic?ScreenSize(context).heightOnly( 1.6):0, ScreenSize(context).heightOnly( 1.6)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    header,
                    style: GetFont.get(
                        context,
                        fontWeight: FontWeight.w600,
                        fontSize: 2.2,
                        color: MyColor.colorBlack
                    ),
                  ),
                  SizedBox(height: ScreenSize(context).heightOnly( 0.5),),
                  Flexible(
                    child: Text(
                      value,
                      style: GetFont.get(
                          context,
                          fontWeight: FontWeight.w400,
                          fontSize: 1.5,
                          color: MyColor.colorBlack
                      ),
                    ),
                  ),
                  const DividerByHeight(1),
                  NextIcon(color: iconColor??MyColor.colorA4,),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: ScreenSize(context).heightOnly(paddingRight??(dashboardEnum == DashboardEnum.timesheet?1:0))),
            child: Lottie.asset(animationIcon,fit: BoxFit.fitWidth,height: ScreenSize(context).heightOnly(animSize??(dashboardEnum == DashboardEnum.timesheet?14:11.5)),width: ScreenSize(context).heightOnly(animSize??(dashboardEnum == DashboardEnum.timesheet?14:11.5)),repeat: true),
          )
        ],
      ),
    );
  }
}
