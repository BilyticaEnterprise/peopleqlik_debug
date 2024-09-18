import 'dart:async';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organization_chart_handler_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/repo/organization_chart_handler_repo.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/repo/organogram_states.dart';
import 'package:peopleqlik_debug/utils/generate_random_number.dart';

class OrganizationChartHandlerRepoImpl extends OrganizationChartHandlerRepo
{
  int focusedWidgetIndex = 0;
  int focusedListIndex = 0;
  StreamController<List<OrganizationChartHandlerModel>> streamController;
  late List<OrganizationChartHandlerModel> organizationChartHandlerList;
  late GenerateRandomNumber _generateRandomNumber;

  OrganizationChartHandlerRepoImpl({required this.streamController,required OrganizationWidgetModel initialList})
  {
    _generateRandomNumber = GenerateRandomNumber();
    organizationChartHandlerList = List.empty(growable: true);
    addDataToList(organizationWidgetModel: initialList,initialPageIndex: 0);
  }

  @override
  void addDataToList({required OrganizationWidgetModel organizationWidgetModel,int? initialPageIndex}) {
    organizationChartHandlerList.add(
        createHandlerData(
            pageIndex: initialPageIndex??findCenterIndex(organizationWidgetModel.teamData?.length??0),
            organizationDataState: decideChartDataState(organizationWidgetModel)
        )
    );
    streamController.add(organizationChartHandlerList);
  }

  @override
  currentRotatePageHorizontalIndex(int verticalIndex, int widgetIndex) {
    organizationChartHandlerList[verticalIndex].currentPageIndex = widgetIndex;
    focusedWidgetIndex = widgetIndex;
    focusedListIndex = verticalIndex;
  }

  @override
  Future<void> showDummyView(bool? onTop)async {
    if(onTop != true)
    {
      organizationChartHandlerList.add(
          createHandlerData(
              pageIndex: 0,
              organizationDataState: OrganizationChartDummyState(data: 1)
          )
      );
    }
    else
      {
        organizationChartHandlerList.removeAt(0);
        organizationChartHandlerList.insert(0, createHandlerData(
            pageIndex: 0,
            organizationDataState: OrganizationChartDummyState(data: 1)
        ));
      }
    streamController.add(organizationChartHandlerList);
  }

  @override
  Future<void> hideDummyView(bool? onTop)async {
    if(onTop != true)
      {
        organizationChartHandlerList.removeAt(organizationChartHandlerList.length-1);
        streamController.add(organizationChartHandlerList);
      }
    else
      {
        organizationChartHandlerList.removeAt(0);
      }
  }

  @override
  bool isDummyVisible() {
    return organizationChartHandlerList.indexWhere((element) => element.organizationChartData == OrganizationChartDummyState()) != -1;
  }

  @override
  removeListFromIndex({required int listIndex}) {
    if(organizationChartHandlerList.length>2)
      {
        organizationChartHandlerList.removeRange(listIndex+1, organizationChartHandlerList.length);
        streamController.add(organizationChartHandlerList);
      }
  }

  @override
  updateScrollingPermissionAt(int listIndex) {
    organizationChartHandlerList[listIndex].allowScrolling = true;
  }

  @override
  OrganizationChartHandlerModel createHandlerData({required int pageIndex, required OrganizationChartState organizationDataState}) {
    return OrganizationChartHandlerModel(
      swiperController: SwiperController(),
      currentPageIndex: pageIndex,
      currentPageKey: Key('listKey${_generateRandomNumber.generateUniqueRandomNumber(1, 10000)}'),
      organizationChartData: organizationDataState,
    );
  }

  @override
  OrganizationChartState decideChartDataState(OrganizationWidgetModel model) {
    if(model.teamData != null&&model.teamData!.isNotEmpty)
      {
        return OrganizationChartDataState<OrganizationWidgetModel>(data: model);
      }
    else
      {
        return OrganizationChartEmptyState();
      }
  }

  @override
  Future<void> updateDataOnTop({required OrganizationWidgetModel organizationWidgetModel}) async {
    int? employeeCode = ((organizationChartHandlerList[0].organizationChartData as OrganizationChartDataState).data as OrganizationWidgetModel).currentUserData?.data.employeeCode;
    insertDataToList(index: 0,organizationWidgetModel: organizationWidgetModel,initialPageIndex: 0);
    streamController.add(organizationChartHandlerList);
    await Future.delayed(const Duration(milliseconds: 600));
    insertDataToList(index: 1,organizationWidgetModel: organizationWidgetModel,initialPageIndex: findIndexOf(employeeCode: employeeCode,model: organizationWidgetModel));
    streamController.add(organizationChartHandlerList);
  }

  @override
  void insertDataToList({required int index, required OrganizationWidgetModel organizationWidgetModel, int? initialPageIndex}) {
    organizationChartHandlerList.insert(
      index,
        createHandlerData(
            pageIndex: initialPageIndex??findCenterIndex(organizationWidgetModel.teamData?.length??0),
            organizationDataState: decideChartDataState(organizationWidgetModel)
        )
    );
  }

  @override
  int findIndexOf({required int? employeeCode, required OrganizationWidgetModel model}) {
    int? index = model.teamData?.indexWhere((element) => element.data.employeeCode == employeeCode);
    return index != null&&index != -1?index:0;
  }

  @override
  findCenterIndex(int length) {
    if(length<=2)
    {
      return 0;
    }
    // If the length is odd
    if (length % 2 != 0) {
      return length ~/ 2; // ~~/2 is integer division
    }
    // If the length is even
    else {
      return (length ~/ 2) - 1; // Subtract 1 to get the left center index
    }
  }

}