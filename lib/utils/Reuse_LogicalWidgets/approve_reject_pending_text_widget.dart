import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/Reuse_LogicalWidgets/status_colors.dart';

import '../../configs/colors.dart';
import '../../configs/fonts.dart';
import '../screen_sizes.dart';

class ApproveRejectPendingTextWidget extends StatelessWidget {
  final int id;
  final String text;
  const ApproveRejectPendingTextWidget({required this.id,required this.text,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: Material(
        color: Color(getColorOfLeaveStatusType(id)??MyColor.colorPrimary),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenSize(context).heightOnly(1),vertical: ScreenSize(context).heightOnly( 0.4)),
          child: Text(
            text,
            style: GetFont.get(
                context,
                fontSize: 1.5,
                fontWeight: FontWeight.w400,
                color: getColorOfLeaveStatusText(id)
            ),
          ),
        ),
      ),
    );
  }
}
