import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_remarks_sheet/widgets/approval_body_panel.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/utils/approval_remarks_sheet/widgets/approval_header_panel.dart';
import 'package:peopleqlik_debug/utils/bottomSheetUi/bottom_sheet_ui.dart';

class CallApprovalRemarksBottomSheet
{
  static void show(BuildContext context,{required Function(String) remarksCallBack,required AcceptReject acceptReject})
  {
    DraggableScrollableController controller = DraggableScrollableController();
    ShowBottomSheet.show(
        context,
        height: 90,
        draggableScrollableController: controller,
        appBar: ApprovalsRemarksHeader(),
        body: ApprovalsRemarksBody(
          acceptReject: acceptReject,
        ),
      callBack: (value)
        {
          remarksCallBack(value);
        }
    );
  }
}