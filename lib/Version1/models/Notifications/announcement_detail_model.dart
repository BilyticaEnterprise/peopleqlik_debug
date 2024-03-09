class GetAnnouncementDetailJson {
  bool? isSuccess;
  GetAnnouncementDetailResultSet? resultSet;
  String? filePath;
  String? message;
  String? errorMessage;

  GetAnnouncementDetailJson(
      {this.isSuccess,
        this.resultSet,
        this.filePath,
        this.message,
        this.errorMessage});

  GetAnnouncementDetailJson.fromJson(Map<String, dynamic> json) {
    isSuccess = json['IsSuccess'];
    resultSet = json['ResultSet'] != null
        ? new GetAnnouncementDetailResultSet.fromJson(json['ResultSet'])
        : null;
    filePath = json['FilePath'];
    message = json['Message'];
    errorMessage = json['ErrorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['IsSuccess'] = this.isSuccess;
    if (this.resultSet != null) {
      data['ResultSet'] = this.resultSet?.toJson();
    }
    data['FilePath'] = this.filePath;
    data['Message'] = this.message;
    data['ErrorMessage'] = this.errorMessage;
    return data;
  }
}

class GetAnnouncementDetailResultSet {
  String? announcementCode;
  String? title;
  String? description;
  List<AdmAnnouncementDocument>? admAnnouncementDocument;

  GetAnnouncementDetailResultSet(
      {this.announcementCode,
        this.title,
        this.description,
        this.admAnnouncementDocument});

  GetAnnouncementDetailResultSet.fromJson(Map<String, dynamic> json) {
    announcementCode = json['AnnouncementCode'];
    title = json['Title'];
    description = json['Description'];
    if (json['adm_announcement_document'] != null) {
      admAnnouncementDocument = new List<AdmAnnouncementDocument>.empty(growable: true);
      json['adm_announcement_document'].forEach((v) {
        admAnnouncementDocument?.add(new AdmAnnouncementDocument.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AnnouncementCode'] = this.announcementCode;
    data['Title'] = this.title;
    data['Description'] = this.description;
    if (this.admAnnouncementDocument != null) {
      data['adm_announcement_document'] =
          this.admAnnouncementDocument?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class AdmAnnouncementDocument {
  int? iD;
  String? announcementCode;
  int? cultureID;
  String? fileName;
  dynamic admAnnouncementMf;
  int? trackingState;
  dynamic modifiedProperties;

  AdmAnnouncementDocument(
      {this.iD,
        this.announcementCode,
        this.cultureID,
        this.fileName,
        this.admAnnouncementMf,
        this.trackingState,
        this.modifiedProperties});

  AdmAnnouncementDocument.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    announcementCode = json['AnnouncementCode'];
    cultureID = json['CultureID'];
    fileName = json['FileName'];
    admAnnouncementMf = json['adm_announcement_mf'];
    trackingState = json['TrackingState'];
    modifiedProperties = json['ModifiedProperties'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['AnnouncementCode'] = this.announcementCode;
    data['CultureID'] = this.cultureID;
    data['FileName'] = this.fileName;
    data['adm_announcement_mf'] = this.admAnnouncementMf;
    data['TrackingState'] = this.trackingState;
    data['ModifiedProperties'] = this.modifiedProperties;
    return data;
  }
}