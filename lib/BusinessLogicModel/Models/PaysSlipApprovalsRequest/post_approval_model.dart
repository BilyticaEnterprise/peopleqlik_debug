class PostApprovalAcceptRejectJson {
  //ObjSecurity objSecurity;
  String? message;
  String? errorMessage;
  ObjEntity? objEntity;

  PostApprovalAcceptRejectJson({
    //this.objSecurity,
    this.objEntity});

  PostApprovalAcceptRejectJson.fromJson(Map<String, dynamic> json) {
    // objSecurity = json['objSecurity'] != null
    //     ? new ObjSecurity.fromJson(json['objSecurity'])
    //     : null;
    objEntity = json['objEntity'] != null
        ? new ObjEntity.fromJson(json['objEntity'])
        : null;
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.objSecurity != null) {
    //   data['objSecurity'] = this.objSecurity.toJson();
    // }
    if (this.objEntity != null) {
      data['objEntity'] = this.objEntity?.toJson();
    }
    data['Message'] = message;
    data['ErrorMessage'] = errorMessage;
    return data;
  }
}
class ObjEntity {
  bool? isSuccess;
  String? errorResourceName;

  ObjEntity({this.isSuccess, this.errorResourceName});

  ObjEntity.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    errorResourceName = json['ErrorResourceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    data['ErrorResourceName'] = this.errorResourceName;
    return data;
  }
}