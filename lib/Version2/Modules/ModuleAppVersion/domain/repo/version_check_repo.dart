import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../data/repoImpl/version_checker_repo_impl.dart';

abstract class VersionCheckRepo
{
  PackageInfo? packageInfo;
  bool userCheckAppVersion = false;

  static final VersionCheckRepo _instance = VersionCheckRepoImpl();
  static VersionCheckRepo get instance => _instance;

  void getVersionData(BuildContext context);
  void goToStore(BuildContext context);
}