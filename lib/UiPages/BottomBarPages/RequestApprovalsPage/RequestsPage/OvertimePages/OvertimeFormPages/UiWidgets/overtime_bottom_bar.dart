import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/src/date_formats.dart';
import 'package:provider/provider.dart';

import '../../../../../../../BusinessLogicModel/Listeners/Requests/RequestSubListListeners/OverTimeListeners/overtime_form_listener.dart';
import '../../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../../src/colors.dart';
import '../../../../../../../src/divider.dart';
import '../../../../../../../src/fonts.dart';
import '../../../../../../../src/language_codes.dart';
import '../../../../../../../src/screen_sizes.dart';
import '../../../../../../Reuse_Widgets/Buttons/bottom_single_button.dart';
import '../../OverTimeDashBoardTeamRequest/UiWidgets/start_end_widget.dart';

class OverTimeBottomBar extends StatelessWidget {
  final Function() onTap;
  const OverTimeBottomBar({required this.onTap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OverTimeFormListener>(
      builder: (context, data, child) {
        if(data.overtimeHourFilterMapper!=null)
          {
            return BottomSingleButton(
              text: '${CallLanguageKeyWords.get(context, LanguageCodes.done)}',
              onPressed: onTap,
              actionWidget: Padding(
                padding: EdgeInsets.only(bottom: ScreenSize(context).heightOnly(2),top: ScreenSize(context).heightOnly(2),left: ScreenSize(context).widthOnly(6),right: ScreenSize(context).widthOnly(6)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    RichText(
                      text: TextSpan(
                          text: '${CallLanguageKeyWords.get(context, LanguageCodes.totalEmployees)}:  ',
                          style: GetFont.get(
                              context,
                              fontWeight: FontWeight.w400,
                              fontSize: 1.7,
                              color: MyColor.colorBlack
                          ),
                          children: [
                            TextSpan(
                              text: '${data.overtimeFilterMapper?.employeeList?.length??0}',
                              style: GetFont.get(
                                  context,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 1.8,
                                  color: MyColor.colorBlack
                              ),
                            )
                          ]
                      ),
                    ),
                    DividerVertical(1),
                    Row(
                      children: [
                        Text(
                          '${CallLanguageKeyWords.get(context, LanguageCodes.dateRange)}:  ',
                          style: GetFont.get(
                              context,
                              fontWeight: FontWeight.w400,
                              fontSize: 1.6,
                              color: MyColor.colorBlack
                          ),
                        ),
                        Text(
                          '${GetDateFormats().getFilterDateTimeFormat(data.overtimeFilterMapper?.startDate)}',
                          style: GetFont.get(
                              context,
                              fontWeight: FontWeight.w700,
                              fontSize: 1.5,
                              color: MyColor.colorBlack
                          ),
                        ),
                        const DividerHorizontal(2),
                        const StartEndWidget(width: 14,size: 1.0,),
                        const DividerHorizontal(2),
                        Expanded(
                          child: Text(
                            '${GetDateFormats().getFilterDateTimeFormat(data.overtimeFilterMapper?.endDate)}',
                            overflow: TextOverflow.ellipsis,
                            style: GetFont.get(
                                context,
                                fontWeight: FontWeight.w700,
                                fontSize: 1.5,
                                color: MyColor.colorBlack
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                )
            ),elevation: true,backGroundColor: MyColor.colorWhite,);
          }
        else
          {
            return Container(height: 0,);
          }
      }
    );
  }
}
