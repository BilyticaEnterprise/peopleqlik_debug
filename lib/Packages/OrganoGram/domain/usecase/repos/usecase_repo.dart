import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';

abstract class OrganizationListUsecaseRepo
{
  Future<void> hideDummyView(bool? onTop);
  Future<void> showDummyView(bool? onTop);
  bool isDummyVisible();
  removeListFromIndex({required int listIndex});
  void addDataToList({required OrganizationWidgetModel organizationWidgetModel});
  void updateDataOnTop({required OrganizationWidgetModel organizationWidgetModel});
  currentRotatePageHorizontalIndex(int verticalIndex,int widgetIndex);
  updateScrollingPermissionAt(int listIndex);

}