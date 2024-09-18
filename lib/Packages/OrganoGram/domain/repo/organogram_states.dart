abstract class OrganizationChartState
{
}

class OrganizationChartDataState<T> extends OrganizationChartState
{
  T? data;
  OrganizationChartDataState({required this.data});
}

class OrganizationChartDummyState<T> extends OrganizationChartState
{
  T? data;
  OrganizationChartDummyState({this.data});
}

class OrganizationChartEmptyState extends OrganizationChartState
{

}
