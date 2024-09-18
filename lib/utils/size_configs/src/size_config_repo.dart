import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/utils/size_configs/size_config.dart';

abstract class SizeConfig
{
  static final SizeConfig _instance = GetSizeConfig();
  static SizeConfig get instance => _instance;

  bool checkIfSizeConfigWorking();
  void config(BuildContext context);

  double getTotalWidth();
  double getTotalHeight();

  double getWidthWithSafe(double percent);
  double getHeightWithSafe(double percent);

  double getWidthNotSafe(double percent);
  double getHeightNotSafe(double percent);

  double getTextSize(double percent);
}