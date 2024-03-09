
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/Models/TimeOffAndEnCashModel/error_result_model.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';

import '../../../../../../../../../../../utils/date_formats.dart';
import '../../../../../../../../../../../utils/CommonUis/container_design_1.dart';
import '../../CommonWidgets/header_value_widget.dart';

class ShiftPendingListWidget extends StatelessWidget {
  final ShiftPendingList? shiftPendingList;
  const ShiftPendingListWidget(this.shiftPendingList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerDesign1(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.employeeDetail)??'',answer: shiftPendingList?.employee??'',),
          const DividerByHeight(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.shiftType)??'',answer: shiftPendingList?.shiftName??'',),
          const DividerByHeight(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.RequestDate)??'',answer: GetDateFormats().getFilterDate(shiftPendingList?.shiftDate??'')??'',),
        ],
      ),
    );
  }
}
