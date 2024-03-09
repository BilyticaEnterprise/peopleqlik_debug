import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peopleqlik_debug/Version1/Models/call_setting_data.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/subModules/ModuleLeave/subModules/LeaveDetailModule/presentation/listener/get_leave_detail_bloc.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_heraricay_view.dart';
import 'package:peopleqlik_debug/configs/colors.dart';
import 'package:peopleqlik_debug/configs/fonts.dart';
import 'package:peopleqlik_debug/configs/language_codes.dart';
import 'package:peopleqlik_debug/utils/screen_sizes.dart';

class ApprovalHistoryView extends StatelessWidget {
  final List<List<ApprovalList>>? approvalList;
  const ApprovalHistoryView({required this.approvalList,super.key});

  @override
  Widget build(BuildContext context) {

    if(approvalList !=null&&approvalList!.isNotEmpty)
      {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: ScreenSize(context).heightOnly( 2),),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).widthOnly( 5.6)),
              child: Text(
                '${CallLanguageKeyWords.get(context, LanguageCodes.ApprovalHistory)}',
                style: GetFont.get(
                    context,
                    fontWeight: FontWeight.w700,
                    fontSize: 2.2,
                    color: MyColor.colorBlack
                ),
              ),
            ),
            SizedBox(height: ScreenSize(context).heightOnly( 1.5),),
            Flexible(
              //fit: FlexFit.loose,
                flex: 1,
                child: ApprovalHierarchyWidget(approvalList)

            ),
            SizedBox(height: ScreenSize(context).heightOnly(2),),
          ],
        );
      }
    else
      {
        return Container(height: 0,);
      }
  }
}
