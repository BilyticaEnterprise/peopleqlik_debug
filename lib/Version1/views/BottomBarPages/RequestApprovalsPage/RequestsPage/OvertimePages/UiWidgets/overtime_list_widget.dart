import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/Models/TimeOffAndEnCashModel/overtime_list_model.dart';
import 'package:peopleqlik_debug/Version1/views/BottomBarPages/RequestApprovalsPage/RequestsPage/OvertimePages/OverTimeDashBoardTeamRequest/UiWidgets/start_end_widget.dart';

import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../../configs/colors.dart';

import '../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../utils/screen_sizes.dart';
import '../../../../../../../../../utils/date_formats.dart';
import '../../../../../../../utils/Reuse_LogicalWidgets/approve_reject_pending_text_widget.dart';
import '../../../../../../../../utils/CommonUis/container_design_1.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';

class OverTimeActualListWidget extends StatelessWidget {
  final int index;
  final OvertimeListData? dataList;
  final Function()? onTap;
  const OverTimeActualListWidget(this.index, this.dataList, {this.onTap,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int total = dataList?.noOfEmploees??0;

    return ContainerDesign1(
      key: Key('OverTimeList$index'),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '# ${dataList?.documentNo}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorGrey3
                  ),
                ),
              ),
              ApproveRejectPendingTextWidget(id: dataList?.approvalStatusID??0,text: dataList?.status??'',),
            ],
          ),
          const DividerByHeight(0.6),
          Text(
            '${CallLanguageKeyWords.get(context, LanguageCodes.from)}, ${GetDateFormats().getFilterDate(dataList?.minDate)} - ${GetDateFormats().getFilterDate(dataList?.maxDate)}',
            style: GetFont.get(
                context,
                fontSize: 2.0,
                fontWeight: FontWeight.w600,
                color: MyColor.colorBlack
            ),
          ),
          const DividerByHeight(0.3),
          Text(
            '${CallLanguageKeyWords.get(context, LanguageCodes.overTimeType)}, ${dataList?.overtimeType??''}',
            style: GetFont.get(
                context,
                fontSize: 1.8,
                fontWeight: FontWeight.w600,
                color: MyColor.colorPrimary
            ),
          ),
          const DividerByHeight(0.6),
          RichText(
            text: TextSpan(
             text: '${CallLanguageKeyWords.get(context, LanguageCodes.overtimeList1)} ',
              style: GetFont.get(
                  context,
                  fontSize: 1.6,
                  fontWeight: FontWeight.w400,
                  color: MyColor.colorBlack
              ),
              children: [
                TextSpan(
                  text: '$total ${CallLanguageKeyWords.get(context, total<=1?LanguageCodes.separationEmployee:LanguageCodes.employees)}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w700,
                      color: MyColor.colorBlack
                  ),
                )
              ]
            )
          ),
          const DividerByHeight(0.6),
          RichText(
            text: TextSpan(
              text: '${CallLanguageKeyWords.get(context, LanguageCodes.overtimeFor)} ',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w400,
                    fontSize: 1.6,
                    color: MyColor.colorBlack
                ),
              children: [
                TextSpan(
                  text: '${GetDateFormats().getTimeWithDuration(context, (dataList?.overtimeMinutes??0.0).toInt())}',
                  style: GetFont.get(
                      context,
                      fontWeight: FontWeight.w700,
                      fontSize: 1.6,
                      color: MyColor.colorBlack
                  ),
                )
              ]
            ),
          ),
          const DividerByHeight(1),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${CallLanguageKeyWords.get(context, LanguageCodes.appliedOn)} ${GetDateFormats().getFilterDate(dataList?.requestDate)}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.4,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorBlack
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: Material(
                  color: const Color(MyColor.colorGrey6),
                  child: InkWell(
                    splashColor: const Color(MyColor.colorGrey0),
                    //onTap: (){},
                    child: Padding(
                        padding: EdgeInsets.all(ScreenSize(context).heightOnly( 0.75)),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: ScreenSize(context).heightOnly( 2.0),
                          color: const Color(MyColor.colorGrey3),
                        )
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
