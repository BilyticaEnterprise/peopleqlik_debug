import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organization_chart_handler_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/models/organogram_model.dart';
import 'package:peopleqlik_debug/Packages/OrganoGram/domain/repo/organogram_states.dart';

abstract class OrganizationChartHandlerRepo
{
  Future<void> hideDummyView(bool? onTop);
  Future<void> showDummyView(bool? onTop);
  bool isDummyVisible();
  removeListFromIndex({required int listIndex});
  void addDataToList({required OrganizationWidgetModel organizationWidgetModel,int? initialPageIndex});
  void insertDataToList({required int index,required OrganizationWidgetModel organizationWidgetModel,int? initialPageIndex});
  void updateDataOnTop({required OrganizationWidgetModel organizationWidgetModel});
  currentRotatePageHorizontalIndex(int verticalIndex,int widgetIndex);
  OrganizationChartHandlerModel createHandlerData({required int pageIndex,required OrganizationChartState organizationDataState});
  OrganizationChartState decideChartDataState(OrganizationWidgetModel model);
  updateScrollingPermissionAt(int listIndex);
  findCenterIndex(int length);
  int findIndexOf({required int employeeCode,required OrganizationWidgetModel model});

}