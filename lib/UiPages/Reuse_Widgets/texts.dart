import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/colors.dart';
import 'package:peopleqlik_debug/src/fonts.dart';
import 'package:peopleqlik_debug/src/screen_sizes.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ClockInClockOut extends StatelessWidget {
  String? text,data;
  int? total = 2;
  int? colorIs;
  double? calculated = 0;
  ProgressTypeEnum progressTypeEnum = ProgressTypeEnum.dashboard;
  ClockInClockOut(this.progressTypeEnum,{Key? key,this.text,this.data,this.colorIs,this.total}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Because this widget is also getting used by boss attendance page where we are showing LIVE ATTENDANCE
    /// feature with LinearPercentIndicator
    if(progressTypeEnum == ProgressTypeEnum.attendance)
      {
        calculated = (double.parse(data!)/total!);
      }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: '$text   ',
              style: GetFont.get(
                  context,
                  fontSize: 1.6,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorGrey3
              ),
              children: [
                TextSpan(
                  text: data??'00:00',
                  style: GetFont.get(
                      context,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w600,
                      color: MyColor.colorBlack
                  ),
                ),
              ]
          ),
        ),
        if(progressTypeEnum == ProgressTypeEnum.attendance)
          ...[
            LinearPercentIndicator(
              animation: true,
              animationDuration: 1000,
              lineHeight: ScreenSize(context).heightOnly( 1.2),
              percent: calculated==0?0.0:calculated!,
              linearStrokeCap: LinearStrokeCap.roundAll,
              padding: EdgeInsets.only(top: ScreenSize(context).heightOnly( 1.2),left: ScreenSize(context).heightOnly( 0.5),right: ScreenSize(context).heightOnly( 0.5)),
              //padding: const EdgeInsets.all(0),
              progressColor: Color(colorIs??MyColor.colorPrimary),
              backgroundColor: const Color(MyColor.colorPrimary).withOpacity(0.1),
            ),
          ],
        if(progressTypeEnum == ProgressTypeEnum.dashboard)
          ...[
            Container(
              height: ScreenSize(context).heightOnly( 1),
              margin: EdgeInsets.only(top: ScreenSize(context).heightOnly( 0.8)),
              decoration: BoxDecoration(
                  color: Color(colorIs??MyColor.colorPrimary),
                  borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
            )
          ]
      ],
    );
  }
}
enum ProgressTypeEnum
{
  dashboard,attendance
}