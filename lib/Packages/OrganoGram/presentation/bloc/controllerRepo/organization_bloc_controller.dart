import 'dart:ui';

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';

class OrganizationChartController
{
  late Function(int verticalIndex,int widgetIndex, OrganizationWidgetModel dataModel) onRotatePageHorizontalIndex;
  late Function(int verticalIndex,int widgetIndex, OrganizationWidgetModel dataModel) onWidgetTapped;
  late Future<void> Function(bool? onTop) showDummyView;
  late Future<void> Function(bool? onTop) hideDummyView;
  // late Future<void> Function(bool? onTop) setInteration;
  Function(OrganizationWidgetModel)? onUpTap;
  Function({required OrganizationWidgetModel organizationWidgetModel})? updateDataOnTop;
  bool Function()? isDummyVisible;
  Function({required int listIndex})? removeListFromIndex;
  OrganizationWidgetModel initialList;
  void Function({required OrganizationWidgetModel organizationWidgetModel})? addDataToList;

  OrganizationChartController({
    required this.onRotatePageHorizontalIndex,
    required this.onWidgetTapped,
    required this.initialList,
    required this.onUpTap
  });
}