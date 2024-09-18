import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/approval_list_model.dart';

abstract class GetApprovalListForViewRepo
{
  List<List<ApprovalList>>? getApprovalListForView();

  bool? _canAdminApprove;

  set canAdminApprove(int? value) {
    if(value == 1) {
      _canAdminApprove = true;
    }
    else
      {
        _canAdminApprove = false;
      }
  }

  bool? canAdminApproveRequest()
  {
    return _canAdminApprove;
  }
}