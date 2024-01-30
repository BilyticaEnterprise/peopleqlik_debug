import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../BusinessLogicModel/Listeners/Approvals/approvals_accept_listener.dart';
import '../../../../../../BusinessLogicModel/Listeners/Approvals/approvals_detail_collector.dart';
import '../../../../../Reuse_Widgets/BottomSheetUi/bottom_sheet_ui.dart';
import '../AcceptancePanels/approval_body_panel.dart';
import '../AcceptancePanels/approval_header_panel.dart';

class CallBottomSheetForRemarks
{
  void call(BuildContext context,ApprovalsDetailCollector approvalsDetailCollector,ApprovalsAcceptRejectCollector approvalsAcceptRejectCollector)
  {
    ShowBottomSheet.show(
        context,
        height: 90,
        appBar: ApprovalsDetailHeader(),
        body: ApprovalsDetailBody(
          acceptRejectCollector: approvalsAcceptRejectCollector,
          approvalsDetailCollector: approvalsDetailCollector,
          callback: (){
            approvalsAcceptRejectCollector.callApi(context, approvalsDetailCollector);
          },
        )
    );
  }
}