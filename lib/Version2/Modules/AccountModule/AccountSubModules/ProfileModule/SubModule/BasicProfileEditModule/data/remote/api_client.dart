import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Version2/Modules/AccountModule/AccountSubModules/ProfileModule/SubModule/BasicProfileEditModule/domain/repo/api_client_repo.dart';

class BasicProfileApiClientRepoImpl extends BasicProfileApiClientRepo
{
  @override
  getData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    return null;
  }

}