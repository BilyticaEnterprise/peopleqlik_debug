import 'package:flutter/material.dart';

import '../../domain/repo/api_client_repo.dart';

class CompensationApiClientRepoImpl extends CompensationApiClientRepo
{
  @override
  getData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    return null;
  }

}