import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/icon_view/next_icon.dart';

import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/fonts.dart';
import '../../../../../../../../utils/charts/line_bar_chart.dart';
import '../../../../../../../../utils/screen_sizes.dart';
import '../../../../../utils/common_dashboard_container.dart';

class AttendanceSummary extends StatelessWidget {
  final Function() onTap;
  const AttendanceSummary({required this.onTap,super.key});

  @override
  Widget build(BuildContext context) {
    return CommonDashboardContainer(
      onTap: onTap,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            CallLanguageKeyWords.get(context, LanguageCodes.attendanceSummary)??'',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w600,
                fontSize: 2.2,
                color: MyColor.colorBlack
            ),
          ),
          const DividerByHeight(0.5),
          Text(
            CallLanguageKeyWords.get(context, LanguageCodes.attendanceSummaryDesc)??'',
            style: GetFont.get(
                context,
                fontWeight: FontWeight.w400,
                fontSize: 1.5,
                color: MyColor.colorBlack
            ),
          ),
          const DividerByHeight(0.5),
          LineBarChart(
            data: [
              LineBarChartData(bottomText: 'On-T', value: 20),
              LineBarChartData(bottomText: 'Late', value: 20),
              LineBarChartData(bottomText: 'E-Out', value: 10),
              LineBarChartData(bottomText: 'Miss', value: 11),
              LineBarChartData(bottomText: 'Pres', value: 23),
              LineBarChartData(bottomText: 'Leave', value: 15),
            ],
            total: 30,date: '',),
          const DividerByHeight(1.5),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const NextIcon(color: MyColor.colorA1,),
              const DividerByWidth(3),
              Text(
                CallLanguageKeyWords.get(context, LanguageCodes.clickHereToSee)??'',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w400,
                    fontSize: 1.4,
                    color: MyColor.colorBlack
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
