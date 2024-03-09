import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';

getApprovalList(List<ApprovalList> history)
{
  var seen = <dynamic>{};
  List<ApprovalList>? uniqueList = history.where((student) => seen.add(student.hierarchyID)).toList();
  List<List<ApprovalList>>? approvalsList = List.empty(growable: true);
  for(int x=0;x<uniqueList.length;x++)
  {
    List<ApprovalList> l = List.empty(growable: true);
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