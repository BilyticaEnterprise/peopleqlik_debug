import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../../../BusinessLogicModel/Enums/dashboard_enums.dart';
import '../../../../BusinessLogicModel/Listeners/LanguageListeners/language_listener.dart';
import '../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../src/colors.dart';
import '../../../../src/divider.dart';
import '../../../../src/fonts.dart';
import '../../../../src/language_codes.dart';
import '../../../../src/pages_name.dart';
import '../../../../src/screen_sizes.dart';

class BottomCardWidget extends StatelessWidget {
  final DashboardEnum dashboardEnum;
  final String header,value,animationIcon;
  final int? iconColor;
  final Function() onTap;
  const BottomCardWidget({required this.dashboardEnum,required this.onTap,required this.header,required this.value,this.iconColor, required this.animationIcon,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenSize(context).heightOnly(16.5),
        margin: EdgeInsets.fromLTRB(ScreenSize(context).widthOnly( 5.6),ScreenSize(context).heightOnly(1.5),ScreenSize(context).widthOnly( 5.6),ScreenSize(context).heightOnly(2.0)),
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
              color: const Color(MyColor.colorPrimary),
              width: 1,
            ),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          color: const Color(MyColor.colorWhite),
          // boxShadow: [
          //   BoxShadow(
          //       color: Colors.grey.shade300,
          //       spreadRadius: 0.0,
          //       blurRadius: 14,
          //       offset: const Offset(3.0, 3.0)),
          //   BoxShadow(
          //       color: Colors.grey.shade400,
          //       spreadRadius: 0.0,
          //       blurRadius: 14 / 2.0,
          //       offset: const Offset(3.0, 3.0)),
          //   BoxShadow(
          //       color: Colors.grey.shade50,
          //       spreadRadius: 2.0,
          //       blurRadius: 14,
          //       offset: const Offset(0.0, -3.0)),
          //   BoxShadow(
          //       color: Colors.grey.shade50,
          //       spreadRadius: 2.0,
          //       blurRadius: 14 / 2,
          //       offset: const Offset(0.0, -3.0)),
          // ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Material(
            color: const Color(MyColor.colorTransparent),
            child: InkWell(
              onTap: onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(Provider.of<ChangeLanguage>(context,listen: false).languageEnum == LanguageEnum.arabic?0:ScreenSize(context).heightOnly( 1.6), ScreenSize(context).heightOnly( 1.6), Provider.of<ChangeLanguage>(context,listen: false).languageEnum == LanguageEnum.arabic?ScreenSize(context).heightOnly( 1.6):0, ScreenSize(context).heightOnly( 1.6)),
                      child: Column(
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
                          Expanded(
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
                          ClipRRect(
                            borderRadius: const BorderRadius.all(Radius.circular(8)),
                            child: Material(
                              color: Color(iconColor??MyColor.colorA4),
                              child: InkWell(
                                splashColor: const Color(MyColor.colorGrey0),
                                //onTap: (){},
                                child: Padding(
                                    padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.75)),
                                    child: Icon(
                                      Icons.arrow_forward_ios,
                                      size: ScreenSize(context).heightOnly( 2.0),
                                      color: const Color(MyColor.colorBlack),
                                    )
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: ScreenSize(context).heightOnly(dashboardEnum == DashboardEnum.timesheet?1:0)),
                    child: Lottie.asset(animationIcon,fit: BoxFit.fitWidth,height: ScreenSize(context).heightOnly(dashboardEnum == DashboardEnum.timesheet?14:11.5),width: ScreenSize(context).heightOnly(dashboardEnum == DashboardEnum.timesheet?14:11.5),repeat: true),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
