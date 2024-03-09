import 'package:flutter/material.dart';

import '../repo/version_check_repo.dart';

class VersionCheckUseCase
{
  void getVersionData(BuildContext context){
    VersionCheckRepo.instance.getVersionData(context);
  }
}