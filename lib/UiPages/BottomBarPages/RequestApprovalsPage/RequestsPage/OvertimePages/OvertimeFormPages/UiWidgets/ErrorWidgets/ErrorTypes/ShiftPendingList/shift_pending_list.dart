
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/TimeOffAndEnCashModel/error_result_model.dart';
import 'package:peopleqlik_debug/BusinessLogicModel/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/src/divider.dart';
import 'package:peopleqlik_debug/src/language_codes.dart';

import '../../../../../../../../../../src/colors.dart';
import '../../../../../../../../../../src/date_formats.dart';
import '../../../../../../../../../../src/fonts.dart';
import '../../../../../../../../../Reuse_Widgets/Containers/container_design_1.dart';
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
          const DividerVertical(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.shiftType)??'',answer: shiftPendingList?.shiftName??'',),
          const DividerVertical(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.RequestDate)??'',answer: GetDateFormats().getFilterDate(shiftPendingList?.shiftDate??'')??'',),
        ],
      ),
    );
  }
}
