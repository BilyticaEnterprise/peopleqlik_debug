import 'package:flutter/material.dart';

import '../../../../../../../../../../../Version1/Models/TimeOffAndEnCashModel/error_result_model.dart';
import '../../../../../../../../../../../Version1/Models/call_setting_data.dart';
import '../../../../../../../../../../../utils/date_formats.dart';
import '../../../../../../../../../../../utils/dividers_screen/dividers.dart';
import '../../../../../../../../../../../configs/language_codes.dart';
import '../../../../../../../../../../../utils/CommonUis/container_design_1.dart';
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
          const DividerByHeight(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.RequestDate)??'',answer: GetDateFormats().getFilterDate(employeeErrorList?.oVTDate??'')??'',),
          const DividerByHeight(2),
          HeaderValueWidget(header: CallLanguageKeyWords.get(context, LanguageCodes.totalTime)??'',answer: '${GetDateFormats().getTimeWithDuration(context,(employeeErrorList?.ovtHours??0).toInt())}',),
        ],
      ),
    );
  }
}