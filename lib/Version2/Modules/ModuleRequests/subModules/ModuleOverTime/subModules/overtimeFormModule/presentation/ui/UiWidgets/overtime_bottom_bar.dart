import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/OverTimeDashBoardTeamRequest/UiWidgets/start_end_widget.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleOverTime/subModules/overtimeFormModule/presentation/listener/overtime_form_listener.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';
import 'package:provider/provider.dart';

import '../../../../../../../../../../configs/fonts.dart';
import 'package:peopleqlik_debug/utils/buttons/bottom_single_button.dart';

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
                    DividerByHeight(1),
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
                        const DividerByWidth(2),
                        const StartEndWidget(width: 14,size: 1.0,),
                        const DividerByWidth(2),
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
