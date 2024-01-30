import 'package:flutter/material.dart';

import '../../../../../../../../../../BusinessLogicModel/Models/TimeOffAndEnCashModel/error_result_model.dart';
import '../../../../../../../../../../BusinessLogicModel/Models/call_setting_data.dart';
import '../../../../../../../../../../src/date_formats.dart';
import '../../../../../../../../../../src/divider.dart';
import '../../../../../../../../../../src/language_codes.dart';
import '../../../../../../../../../Reuse_Widgets/Containers/container_design_1.dart';
import '../../CommonWidgets/header_value_widget.dart';

class EmployeeErrorListWidget extends StatelessWidget {
  final EmployeeErrorList? employeeErrorList;
  const EmployeeErrorListWidget(this.employeeErrorList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerDesign1(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.employeeDetail)??'',answer: employeeErrorList?.employee??'',),
          const DividerVertical(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.RequestDate)??'',answer: GetDateFormats().getFilterDate(employeeErrorList?.oVTDate??'')??'',),
          const DividerVertical(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.totalTime)??'',answer: '${GetDateFormats().getTimeWithDuration(context,(employeeErrorList?.ovtHours??0).toInt())}',),
        ],
      ),
    );
  }
}