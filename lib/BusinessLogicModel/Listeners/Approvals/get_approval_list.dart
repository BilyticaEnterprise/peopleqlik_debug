import '../../Models/PaysSlipApprovalsRequest/get_approvals_detail_model.dart';

getApprovalHistory(List<ApprovalHistory>? history)
{
  var seen = <dynamic>{};
  List<ApprovalHistory>? uniqueList = history!.where((student) => seen.add(student.hierarchyID)).toList();
  List<List<ApprovalHistory>>? approvalsList = List.empty(growable: true);
  for(int x=0;x<uniqueList.length;x++)
  {
    List<ApprovalHistory> l = List.empty(growable: true);
    for(int y=0;y<history.length;y++)
    {
      if(history[y].hierarchyID == uniqueList[x].hierarchyID)
      {
        l.add(history[y]);
      }
    }
    if(l.isNotEmpty)
    {
      approvalsList.add(l);
    }
  }
  return approvalsList.isEmpty?null:approvalsList;
}