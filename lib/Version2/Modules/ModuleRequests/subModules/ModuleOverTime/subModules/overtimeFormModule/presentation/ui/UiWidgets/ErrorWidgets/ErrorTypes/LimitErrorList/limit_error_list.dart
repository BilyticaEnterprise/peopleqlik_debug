import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/models/TimeOffAndEnCashModel/error_result_model.dart';
import 'package:peopleqlik_debug/Version1/models/call_setting_data.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/commonUis/container_design_1.dart';
import 'package:peopleqlik_debug/utils/date_formats.dart';
import 'package:peopleqlik_debug/utils/dividers_screen/dividers.dart';

import '../../CommonWidgets/header_value_widget.dart';

class LimitErrorListWidget extends StatelessWidget {
  final LimitErrorList? limitErrorList;
  const LimitErrorListWidget(this.limitErrorList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerDesign1(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.employeeDetail)??'',answer: limitErrorList?.employee??'',),
          const DividerByHeight(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.weeklyApplied)??'',answer: GetDateFormats().getFilterTime3(limitErrorList?.weeklyOvertimeApplied??'0:0')??'',),
          const DividerByHeight(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.weeklyAppliedLimit)??'',answer: GetDateFormats().getFilterTime3(limitErrorList?.weeklyOvertimeLimit??'0:0')??'',),
          const DividerByHeight(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.monthlyApplied)??'',answer: GetDateFormats().getFilterTime3(limitErrorList?.monthlyOvertimeApplied??'0.0')??'',),
          const DividerByHeight(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.monthlyAppliedLimit)??'',answer: GetDateFormats().getFilterTime3(limitErrorList?.monthlyOvertimeLimit??'0.0')??'',),
          const DividerByHeight(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.yearlyApplied)??'',answer: GetDateFormats().getFilterTime3(limitErrorList?.yearlyOvertimeApplied??'0.0')??'',),
          const DividerByHeight(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.yearlyAppliedLimit)??'',answer: GetDateFormats().getFilterTime3(limitErrorList?.yearlyOvertimeLimit??'0.0')??'',),
        ],
      ),
    );
  }
}
