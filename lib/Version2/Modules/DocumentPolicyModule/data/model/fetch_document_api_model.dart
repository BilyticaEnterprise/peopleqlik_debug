class FetchDocumentApiModel
{
  String companyCode;
  int? pageNumber;
  int typeID;
  FetchDocumentApiModel({
    required this.companyCode,
    this.pageNumber,
    required this.typeID,
  });
}