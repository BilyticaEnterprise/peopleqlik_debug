class DocumentFilterTypeModel {
  int? typeID;
  String? typeName;

  DocumentFilterTypeModel({this.typeID, this.typeName});

  DocumentFilterTypeModel.fromJson(Map<String, dynamic> json) {
    typeID = json['TypeID'];
    typeName = json['TypeName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TypeID'] = this.typeID;
    data['TypeName'] = this.typeName;
    return data;
  }
}