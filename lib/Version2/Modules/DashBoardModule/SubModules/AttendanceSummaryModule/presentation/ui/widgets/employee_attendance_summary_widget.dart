import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/lines_widget/horizontal_vertical_line.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/commonUis/common_container.dart';
import 'package:peopleqlik_debug/utils/image_getter/cache_image.dart';
import 'package:peopleqlik_debug/utils/strings.dart';

import '../../../../../../../../configs/colors.dart';
import '../../../../../../../../configs/fonts.dart';
import '../../../../../../../../utils/date_formats.dart';
import '../../../../../../../../utils/screen_sizes.dart';

class EmployeeAttendanceSummaryWidget extends StatelessWidget {
  const EmployeeAttendanceSummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      horizontalMargin: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hussan Rehman',
                      style: GetFont.get(
                          context,
                          fontSize: 1.8,
                          fontWeight: FontWeight.w600,
                          color: MyColor.colorBlack
                      ),
                    ),
                    SizedBox(height: ScreenSize(context).heightOnly( 0.6),),
                    Text(
                      '.Net Developer',
                      style: GetFont.get(
                          context,
                          fontSize: 1.5,
                          fontWeight: FontWeight.w400,
                          color: MyColor.colorGrey3
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GetNetWorkImage(
                    image: GetVariable.testPic,
                    size: 6,
                    boxShape: BoxShape.circle,
                    withBorder: true,
                    borderPadding: 0.2,
                    borderColor: MyColor.colorPrimary,
                  ),
                ],
              )
            ],
          ),
          const HorizontalLine(color: MyColor.colorA5,borderRadius: 50,lineHeight: 0.1,marginVertical: 1.5,),
          _CheckInOutTime(
            header: CallLanguageKeyWords.get(context, LanguageCodes.attendanceCheckIn)??'',
            value: '${GetDateFormats().getFilterTime4('12:30')}',
          ),
          const DividerByHeight(0.5),
          _CheckInOutTime(
            header: CallLanguageKeyWords.get(context, LanguageCodes.attendanceCheckOut)??'',
            value: '${GetDateFormats().getFilterTime4('19:30')}',
          ),
        ],
      ),
    );
  }
}
class _CheckInOutTime extends StatelessWidget {
  final String header;
  final String value;
  const _CheckInOutTime({required this.header,required this.value,super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$header:  ',
        style: GetFont.get(
            context,
            fontSize: 1.8,
            fontWeight: FontWeight.w400,
            color: MyColor.colorBlack
        ),
        children: [
          TextSpan(
            text: value,
            style: GetFont.get(
                context,
                fontSize: 1.8,
                fontWeight: FontWeight.w600,
                color: MyColor.colorPrimary
            ),
          )
        ]
      ),
    );
  }
}
