import 'package:flutter/material.dart';

import '../../domain/repo/api_client_repo.dart';

class FamilyApiClientRepoImpl extends FamilyApiClientRepo
{
  @override
  getData(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    return null;
  }
}