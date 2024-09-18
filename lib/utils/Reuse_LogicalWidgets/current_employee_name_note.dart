import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Version1/viewModel/EmployeeSearchController/global_selected_employee/global_selected_employee_controller.dart';
import '../../Version1/models/call_setting_data.dart';
import '../../configs/colors.dart';
import '../../configs/fonts.dart';
import '../../configs/language_codes.dart';
import '../screen_sizes.dart';

class CurrentEmployeeNoteWidget extends StatelessWidget {
  const CurrentEmployeeNoteWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GlobalSelectedEmployeeController>(
        builder: (context, data, child) {
          if(data.getEmployee().localEmployee == false)
          {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenSize(context).heightOnly( 1.5),
                  vertical: ScreenSize(context).heightOnly( 1.5)
              ),
              margin: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 4.6),vertical: ScreenSize(context).heightOnly(2)),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  color: const Color(MyColor.colorT1).withOpacity(0.4)
              ),
              child: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: '${CallLanguageKeyWords.get(context, LanguageCodes.note)}: ',
                          style: GetFont.get(
                              context,
                              fontSize: 1.6,
                              color: MyColor.colorBlack,
                              fontWeight: FontWeight.w700
                          )
                      ),
                      TextSpan(
                          text: '${CallLanguageKeyWords.get(context, LanguageCodes.noteAlert)} ',
                          style: GetFont.get(
                              context,
                              fontSize: 1.4,
                              color: MyColor.colorBlack,
                              fontWeight: FontWeight.w400
                          )
                      ),
                      TextSpan(
                          text: '${data.getEmployee().name}',
                          style: GetFont.get(
                              context,
                              fontSize: 1.4,
                              color: MyColor.colorBlack,
                              fontWeight: FontWeight.w600
                          )
                      )
                    ]
                ),
              ),
            );
          }
          else
          {
            return Container();
          }

        }
    );
  }
}
