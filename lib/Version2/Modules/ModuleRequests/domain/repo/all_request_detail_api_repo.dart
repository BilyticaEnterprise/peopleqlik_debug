import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/ApiModule/domain/model/model_decider.dart';
import 'package:peopleqlik_debug/Version2/Modules/ModuleRequests/domain/models/all_requests_detail_mapper.dart';

abstract class AllRequestDetailApiClientRepo
{
  getData(BuildContext context,AllRequestDetailMapper allRequestDetailMapper,ClassType classType);
  approveRejectRequest(BuildContext context, {required AllRequestDetailMapper allRequestDetailMapper,required String remarks,required int approveOrReject});

}