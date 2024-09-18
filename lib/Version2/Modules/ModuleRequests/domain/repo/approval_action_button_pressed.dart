import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version1/viewModel/Approvals/approvals_detail_collector.dart';

mixin ApprovalActionButton
{
  void actionButtonPressed(BuildContext context, AcceptReject acceptReject, int statusId);
}