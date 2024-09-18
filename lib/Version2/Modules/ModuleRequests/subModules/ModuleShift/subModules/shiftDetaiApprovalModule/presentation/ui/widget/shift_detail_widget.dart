import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleShift/subModules/shiftDetaiApprovalModule/domain/model/shift_detail_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleShift/subModules/shiftDetaiApprovalModule/presentation/listener/get_shift_bloc.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';

import '../../../../../../../../../../Version1/models/TimeOffAndEnCashModel/shift_detail_model.dart';
import '../../../../../../../../../../Version1/models/TimeOffAndEnCashModel/shift_list_model.dart';
import '../../../../../../../../../../../Version1/models/call_setting_data.dart';
import '../../../../../../../../../../../configs/colors.dart';
import '../../../../../../../../../../../../configs/fonts.dart';
import '../../../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../../../utils/screen_sizes.dart';
import '../../../../../../../../../../utils/Reuse_LogicalWidgets/approve_reject_pending_text_widget.dart';
import '../../../../../../../../../../utils/Reuse_LogicalWidgets/custom_chips.dart';
import '../../../../../../../../../../utils/commonUis/container_design_1.dart';
import '../../../../../../../../../../utils/dividers_screen/dividers.dart';

class ShiftDetailWidget extends StatelessWidget {
  final ShiftResult? data;
  const ShiftDetailWidget({required this.data,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    GetShiftDetailBloc shiftDetailBloc = BlocProvider.of<GetShiftDetailBloc>(context,listen: false);
    return ContainerDesign1(
      key: const Key('OverTimeDetail'),
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
              // ApproveRejectPendingTextWidget(id: data?.??0,text: data?.statusName??'',),
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
          const DividerByHeight(1.6),
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
          const DividerByHeight(0.6),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: ScreenSize(context).heightOnly(0.8)),
                child: Text(
                  '${CallLanguageKeyWords.get(context, LanguageCodes.weekends)}: ',
                  style: GetFont.get(
                      context,
                      fontWeight: FontWeight.w400,
                      fontSize: 1.5,
                      color: MyColor.colorBlack
                  ),
                ),
              ),
              Expanded(
                child: Wrap(
                  children: shiftDetailBloc.getOffDays(context)?.map((e) => TextEmployeeChipWidget(e??'',verticalPadding: 0.4,textSize: 1.4,)).toList()??[Container(height: 0,)],
                ),
              ),
            ],
          ),
          const DividerByHeight(1),
          Text(
            '${CallLanguageKeyWords.get(context, LanguageCodes.appliedOn)} ${GetDateFormats().getFilterDate(data?.createdDate)}',
            style: GetFont.get(
                context,
                fontSize: 1.4,
                fontWeight: FontWeight.w400,
                color: MyColor.colorBlack
            ),
          ),
        ],
      ),
    );
  }
}
