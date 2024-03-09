import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';

import '../../../../../../../../Version1/Models/TimeOffAndEnCashModel/shift_list_model.dart';
import '../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../utils/screen_sizes.dart';
import '../../../../../../../../utils/Reuse_LogicalWidgets/approve_reject_pending_text_widget.dart';
import '../../../../../../../../utils/CommonUis/container_design_1.dart';
import '../../../../../../../../utils/dividers_screen/dividers.dart';

class ShiftListWidget extends StatelessWidget {
  final int index;
  final ShiftListDataList? data;
  final Function()? onTap;
  const ShiftListWidget({this.onTap,required this.index,required this.data,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
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
                  '# ${data?.requestMID}',
                  style: GetFont.get(
                      context,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w400,
                      color: MyColor.colorGrey3
                  ),
                ),
              ),
              ApproveRejectPendingTextWidget(id: data?.statusID??0,text: data?.statusName??'',),
            ],
          ),
          SizedBox(height: ScreenSize(context).heightOnly( 0.3),),
          Text(
            '${CallLanguageKeyWords.get(context, LanguageCodes.effectiveDate)}, ${GetDateFormats().getFilterDate(data?.effectiveDate)}',
            style: GetFont.get(
                context,
                fontSize: 2.0,
                fontWeight: FontWeight.w600,
                color: MyColor.colorBlack
            ),
          ),
          SizedBox(height: ScreenSize(context).heightOnly( 0.8),),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${CallLanguageKeyWords.get(context, LanguageCodes.shiftType)}: ${data?.regularShift} ',
                  style: GetFont.get(
                      context,
                      fontSize: 1.6,
                      fontWeight: FontWeight.w600,
                      color: MyColor.colorPrimary
                  ),
                ),
              ),
            ],
          ),
          DividerByHeight(1),
          RichText(
            text: TextSpan(
                text: '${CallLanguageKeyWords.get(context, LanguageCodes.ramzanShift)}: ',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w400,
                    fontSize: 1.6,
                    color: MyColor.colorBlack
                ),
                children: [
                  TextSpan(
                    text: data?.ramadanShift!=null&&data!.ramadanShift!.isNotEmpty?'${CallLanguageKeyWords.get(context, LanguageCodes.included)}':'${CallLanguageKeyWords.get(context, LanguageCodes.notIncluded)}',
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
          DividerByHeight(1),
          Row(
            children: [
              Expanded(
                child: Text(
                  '${CallLanguageKeyWords.get(context, LanguageCodes.appliedOn)} ${GetDateFormats().getFilterDate(data?.createdDate)}',
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
