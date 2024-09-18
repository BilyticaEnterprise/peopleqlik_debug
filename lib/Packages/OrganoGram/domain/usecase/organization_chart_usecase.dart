
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/repo/organization_chart_handler_repo.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/usecase/repos/usecase_repo.dart';

class OrganizationChartUseCase extends OrganizationListUsecaseRepo
{
  OrganizationChartHandlerRepo repo;
  OrganizationChartUseCase({required this.repo});

  @override
  void addDataToList({required OrganizationWidgetModel organizationWidgetModel}) {
    repo.addDataToList(organizationWidgetModel: organizationWidgetModel);
  }

  @override
  currentRotatePageHorizontalIndex(int verticalIndex, int widgetIndex) {
    repo.currentRotatePageHorizontalIndex(verticalIndex, widgetIndex);
  }

  @override
  hideDummyView(bool? onTop)async {
    await repo.hideDummyView(onTop);
  }

  // @override
  // hideEmptyView()async {
  //   await repo.hideEmptyView();
  // }

  @override
  bool isDummyVisible() {
    return repo.isDummyVisible();
  }

  @override
  removeListFromIndex({required int listIndex}) {
    repo.removeListFromIndex(listIndex: listIndex);
  }

  @override
  showDummyView(bool? onTop)async {
    await repo.showDummyView(onTop);
  }

  @override
  updateScrollingPermissionAt(int listIndex) {
    repo.updateScrollingPermissionAt(listIndex);
  }

  @override
  void updateDataOnTop({required OrganizationWidgetModel organizationWidgetModel}) {
    repo.updateDataOnTop(organizationWidgetModel: organizationWidgetModel);
  }

  
}