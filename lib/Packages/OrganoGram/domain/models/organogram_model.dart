
class OrganizationWidgetModel
{
  DataType? currentUserData;
  DataType? superVisorData;
  List<DataType>? teamData;
  OrganizationWidgetModel({this.currentUserData,this.superVisorData,this.teamData});
}

class DataType<T>
{
  T? data;
  DataType(this.data);
}